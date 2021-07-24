#All these libraries need to be installed on the system using the package manager, PIP on CMD. 
from flask import Flask, render_template, flash, redirect, url_for, session, logging, request
#This is imported from the data.py in the same folder where firstpro.py exists.
#from data import reviews
#MYSQL packages that operate with MySQL Database
from flask_mysqldb import MySQL, MySQLdb
#wtforms are built in forms that need to be installed on our system using pip and fileds need to included
from wtforms import Form, StringField, TextAreaField,PasswordField, validators, HiddenField
#passlib.hash is used for encrypting our password we want to use. 
from passlib.hash import sha256_crypt
import mysql.connector
#used for styling
from functools import wraps
import os

from wtforms.fields.html5 import EmailField

app = Flask(__name__)
app.secret_key = os.urandom(24)

# Config MySQL
mysql = MySQL()
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'new-password'
app.config['MYSQL_DB'] = 'bookmini'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

#Initialize the app for use with this MySQL class
mysql.init_app(app)

def is_logged_in(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'logged_in' in session:
            return f(*args, *kwargs)
        else:
            flash('Unauthorized, Please login', 'danger')
            return redirect(url_for('login'))
    return wrap

def not_logged_in(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'logged_in' in session:
            flash('Unauthorized, You logged in', 'danger')
            return redirect(url_for('register'))
        else:
            return f(*args, *kwargs)
    return wrap

def is_admin_logged_in(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'admin_logged_in' in session:
            return f(*args, *kwargs)
        else:
            return redirect(url_for('admin_login'))

    return wrap

def not_admin_logged_in(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'admin_logged_in' in session:
            return redirect(url_for('admin'))
        else:
            return f(*args, *kwargs)

    return wrap
#Home PAge
@app.route('/')
def home():
    return render_template('home.html')
#A class for registration form 
class RegisterForm(Form):
    name = StringField('Name', [validators.length(min=3, max=150)], render_kw={'autofocus': True})
    username = StringField('Username', [validators.length(min=3, max=25)])
    email = EmailField('Email', [validators.DataRequired(), validators.Email(), validators.length(min=4, max=25)])
    password = PasswordField('Password', [validators.length(min=3)])

class LoginForm(Form):    # Create Message Form
    username = StringField('Username', [validators.length(min=1)], render_kw={'autofocus': True})

#UserRegistrationForm
@app.route('/register', methods=['GET', 'POST'])
@not_logged_in
def register():
    form = RegisterForm(request.form)
    if request.method == 'POST' and form.validate():
        name = form.name.data
        email = form.email.data
        username = form.username.data
        password = sha256_crypt.encrypt(str(form.password.data))
        # Create Cursor
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO users(name, email, username, password) VALUES(%s, %s, %s, %s)",
                    (name, email, username, password))
        # Commit cursor
        mysql.connection.commit()
        # Close Connection
        cur.close()
        flash('You are now registered and can login', 'success')
        return redirect(url_for('login'))
    return render_template('register.html', form=form)

# User Login
@app.route('/login', methods=['GET', 'POST'])
@not_logged_in
def login():
    form = LoginForm(request.form)
    if request.method == 'POST' and form.validate():
        # GEt user form
        username = form.username.data
        password_candidate = request.form['password']

        # Create cursor
        cur = mysql.connection.cursor()

        # Get user by username
        result = cur.execute("SELECT * FROM users WHERE username=%s", [username])

        if result > 0:
            # Get stored value
            data = cur.fetchone()
            password = data['password']
            uid = data['id']
            name = data['name']

            # Compare password
            if sha256_crypt.verify(password_candidate, password):
                # passed
                session['logged_in'] = True
                session['uid'] = uid
                session['s_name'] = username
                flash('You are now logged in', 'success')

                return redirect(url_for('dashboard'))

            else:
                flash('Incorrect password', 'danger')
                return render_template('login.html', form=form)
        else:
            flash('Username not found', 'danger')
            # Close connection
            cur.close()
            return render_template('login.html', form=form)
    return render_template('login.html', form=form)

#Dashboard
@app.route('/dashboard')
@is_logged_in
def dashboard():
    cur = mysql.connection.cursor()
    uid = session['uid']
    result = cur.execute("SELECT * FROM reviews  WHERE authorid = %s",[uid])

    reviews = cur.fetchall()

    if result >0:
        return render_template('dashboard.html', reviews=reviews)
    else:
        msg = 'No reviews found'
        return render_template('dashboard.html', msg=msg)

        cur.close()

#UserLogout    
@app.route('/logout')
def logout():
    if 'uid' in session:

        # Create cursor
        cur = mysql.connection.cursor()
        uid = session['uid']
        session.clear()
        flash('You are logged out', 'success')
        return redirect(url_for('login'))
    return redirect(url_for('login'))

#Essay form class
class ReviewForm(Form):
    title = StringField('Title', [validators.Length(min=1, max=150)])
    summary = StringField('Summary',[validators.Length(min=10, max=200)])
    body = TextAreaField('Body', [validators.Length(min=30)])

#Adding essays done by users here
@app.route('/add_review', methods=['GET', 'POST'])
@is_logged_in
def add_review():
    form = ReviewForm(request.form)
    if request.method == 'POST' and form.validate():
        title = form.title.data
        summary = form.summary.data
        body = form.body.data
        uid = session['uid']
        cur = mysql.connection.cursor()

        cur.execute("INSERT INTO `reviews`(`authorid`,`title`, `summary`, `body`, `author`)  values (%s,%s,%s,%s,%s)", (uid,title,summary, body, session['s_name']))
        
        mysql.connection.commit()

        cur.close()

        flash('review created', 'success')
        return redirect(url_for('dashboard'))
    return render_template('add_review.html', form=form)

#reviews
@app.route('/reviews', methods=['GET', 'POST'])
def reviews():
    if request.method == 'POST':
        searchtext = request.form['searchtext']
        cur = mysql.connection.cursor()

        result = cur.execute("SELECT * FROM reviews WHERE `title` LIKE %s ",['%'+searchtext+'%'])

        reviews = cur.fetchall()

        if result >0:
            return render_template('reviews.html', reviews=reviews)
        else:
            msg = 'No reviews found'+searchtext
            return render_template('reviews.html', msg=msg)

        cur.close()
    else:
        cur = mysql.connection.cursor()

        result = cur.execute("SELECT * FROM reviews")

        reviews = cur.fetchall()

        if result >0:
            return render_template('reviews.html', reviews=reviews)
        else:
            msg = 'No reviews found'
            return render_template('reviews.html', msg=msg)

        cur.close()

#This route will takes us a single artilce to be dispalyed on the screen. When a user clicks on any of the the link,
#a new page will be displayed. 
""" The review id will be passed here from the data.py file"""
@app.route('/review/<string:id>/')#for single review
def review(id):
    cur = mysql.connection.cursor()
    result = cur.execute("SELECT * FROM reviews WHERE id = %s", [id])
    review = cur.fetchone()
    return render_template("review.html", review=review)

#edit Essays by the users themselves 
@app.route('/edit_review/<string:id>', methods=['GET', 'POST'])
#@is_logged_in
def edit_review(id):
        #id = request.form['eid']
    cur = mysql.connection.cursor()
    result = cur.execute("SELECT * FROM reviews WHERE id=%s", [id])
    review = cur.fetchone()
    cur.close()

    form =ReviewForm(request.form)

    form.title.data = review['title']
    form.summary.data = review['summary']
    form.body.data = review['body']
    
    if request.method == 'POST' and form.validate():
        title = request.form['title']
        summary = request.form['summary']
        body = request.form['body']
        # Create Cursor
        cur = mysql.connection.cursor()
            #app.logger.info(title)
        # Execute
        cur.execute ("UPDATE reviews SET title=%s, summary=%s, body=%s WHERE id=%s",(title,summary,body, [id]))
        # Commit to DB
        mysql.connection.commit()
        #Close connection
        cur.close()
        flash('review Updated', 'success')
        return redirect(url_for('dashboard'))
    return render_template('edit_review.html', form=form)

#The users can delete their essays using this route
@app.route('/delete_review/<string:id>', methods=['POST'])
def delete_review(id): 
    cur = mysql.connection.cursor()
    cur.execute("DELETE from reviews where id=%s", [id])
    mysql.connection.commit()
    cur.close()
    flash('review deleted', 'success')
    return redirect(url_for('dashboard'))

if __name__ == '__main__':
    app.secret_key="HeyIam"
    app.run(debug=True)
