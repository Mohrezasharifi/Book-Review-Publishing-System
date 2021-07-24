-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 24, 2021 at 10:52 AM
-- Server version: 5.7.23
-- PHP Version: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookmini`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(125) NOT NULL,
  `lastName` varchar(125) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(25) NOT NULL,
  `address` text NOT NULL,
  `password` varchar(100) NOT NULL,
  `type` varchar(20) NOT NULL,
  `confirmCode` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `firstName`, `lastName`, `email`, `mobile`, `address`, `password`, `type`, `confirmCode`) VALUES
(1, 'Nur', 'Mohsin', 'mohsin@gmail.com', '01677876551', 'Dhaka', '$5$rounds=535000$WOAOMdgoK2JpZLY5$RFH9BZQCB3NEvG4R/FofxxJL/PUaeZm7T6G9P3PRg05', 'manager', '0');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `ofname` text NOT NULL,
  `pid` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `oplace` text NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `dstatus` varchar(10) NOT NULL DEFAULT 'no',
  `odate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ddate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `uid`, `ofname`, `pid`, `quantity`, `oplace`, `mobile`, `dstatus`, `odate`, `ddate`) VALUES
(1, 1, 'yashwanth', 1, 2, 'Vijaynagar, Mysore', '8431710121', 'no', '2021-01-24 05:13:50', '2021-01-31');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pName` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  `description` text NOT NULL,
  `available` int(11) NOT NULL,
  `category` varchar(100) NOT NULL,
  `item` varchar(100) NOT NULL,
  `pCode` varchar(20) NOT NULL,
  `picture` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `pName`, `price`, `description`, `available`, `category`, `item`, `pCode`, `picture`, `date`) VALUES
(1, 'The Alchemist', 250, 'Written by Paulo', 5, 'book', 'The Alchemist', '935698', 'alchemist.jpg', '2021-01-24 05:10:53'),
(2, 'A Promised Land', 500, 'Written by Obama', 5, 'book', 'A promised land by obama', '935699', 'apromisedland1.jpg', '2021-01-24 05:20:23'),
(3, 'MAHATMA GANDHI', 500, 'An autobiography', 10, 'book', 'Book', '935697', 'gandhi.jpg', '2021-01-24 05:26:10'),
(4, 'The Bride In The Rainy Mountains', 500, 'a book by Kuvempo', 5, 'book', 'novel', '935696', 'thebride.jpeg', '2021-01-24 05:29:13');

-- --------------------------------------------------------

--
-- Table structure for table `product_level`
--

DROP TABLE IF EXISTS `product_level`;
CREATE TABLE IF NOT EXISTS `product_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `v_shape` varchar(10) NOT NULL DEFAULT 'no',
  `polo` varchar(10) NOT NULL DEFAULT 'no',
  `clean_text` varchar(10) NOT NULL DEFAULT 'no',
  `design` varchar(10) NOT NULL DEFAULT 'no',
  `chain` varchar(10) NOT NULL DEFAULT 'no',
  `leather` varchar(10) NOT NULL DEFAULT 'no',
  `hook` varchar(10) NOT NULL DEFAULT 'no',
  `color` varchar(10) NOT NULL DEFAULT 'no',
  `formal` varchar(10) NOT NULL DEFAULT 'no',
  `converse` varchar(10) NOT NULL DEFAULT 'no',
  `loafer` varchar(10) NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_level`
--

INSERT INTO `product_level` (`id`, `product_id`, `v_shape`, `polo`, `clean_text`, `design`, `chain`, `leather`, `hook`, `color`, `formal`, `converse`, `loafer`) VALUES
(1, 1, 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no'),
(2, 2, 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no'),
(3, 3, 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no'),
(4, 4, 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `product_view`
--

DROP TABLE IF EXISTS `product_view`;
CREATE TABLE IF NOT EXISTS `product_view` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_view`
--

INSERT INTO `product_view` (`id`, `user_id`, `product_id`, `date`) VALUES
(1, 1, 1, '2021-01-24 05:13:18'),
(25, 1, 2, '2021-01-24 07:47:34'),
(26, 1, 4, '2021-01-24 10:49:29'),
(27, 1, 3, '2021-01-24 10:47:48');

-- --------------------------------------------------------

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
CREATE TABLE IF NOT EXISTS `publisher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(300) NOT NULL,
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `publisher`
--

INSERT INTO `publisher` (`id`, `name`, `email`, `username`, `password`, `reg_date`) VALUES
(1, 'MOHAMMAD REZA SHARIFI', 'rezatayeb2016@gmail.com', 'rizza', '$5$rounds=535000$4fND.Meri0Sb3EZq$oAqepimrOrKG4vVb2y6sFDHz5N8bagMLEfr3.hZ5.V5', '2021-01-24 10:44:27'),
(2, 'MOHAMMAD REZA SHARIFI', 'rezatayeb2016@gmail.com', 'rizza', '$5$rounds=535000$PfbXAB35DWHclGqn$CLDjCBnoB/gsuA3Em/WWTDPKYToEpO6ivrVf01VDSy5', '2021-01-24 10:44:44'),
(3, 'MOHAMMAD REZA SHARIFI', 'rezatayeb2016@gmail.com', 'rizza', '$5$rounds=535000$Yw5gpLD34s.5oHBA$ht2LZXQQLz69DWtQJW/3CmjIHZWWt7fszSziJKsqJS1', '2021-01-24 10:44:54');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE IF NOT EXISTS `reviews` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `authorid` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `summary` mediumtext NOT NULL,
  `author` varchar(30) DEFAULT NULL,
  `body` mediumtext,
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `authorid` (`authorid`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `authorid`, `title`, `summary`, `author`, `body`, `create_date`) VALUES
(4, 1, 'A PROMISED LAND', 'This is an excerpt about the popular book, \'A promised land\'', 'ahmed', '<p style=\"text-align:justify\"><span style=\"font-size:20px\">I&rsquo;d never been to India before, but the country had always held a special place in my imagination. Maybe it was its sheer size, with one-sixth of the world&rsquo;s population, an estimated two thousand distinct ethnic groups, and more than seven hundred languages spoken. Maybe it was because I&rsquo;d spent a part of my childhood in Indonesia listening to the epic Hindu tales of the Ramayana and the Mahābhārata, or because of my interest in Eastern religions, or because of a group of Pakistani and Indian college friends who&rsquo;d taught to me to cook&nbsp;<em>dahl&nbsp;</em>and&nbsp;<em>keema&nbsp;</em>and turned me on to Bollywood movies.</span></p>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:20px\">More than anything, though, my fascination with India had to do with Mahatma Gandhi. Along with Lincoln, King, and Mandela, Gandhi had profoundly influenced my thinking. As a young man, I&rsquo;d studied his writings and found him giving voice to some of my deepest instincts. His notion of satyagraha, or devotion to truth, and the power of nonviolent resistance to stir the conscience; his insistence on our common humanity and the essential oneness of all religions; and his belief in every society&rsquo;s obligation, through its political, economic, and social arrangements, to recognize the equal worth and dignity of all people &mdash; each of these ideas resonated with me. Gandhi&rsquo;s actions had stirred me even more than his words; he&rsquo;d put his beliefs to the test by risking his life, going to prison, and throwing himself fully into the struggles of his people. His nonviolent campaign for Indian independence from Britain, which began in 1915 and continued for more than thirty years, hadn&rsquo;t just helped overcome an empire and liberate much of the subcontinent, it had set off a moral charge that pulsed around the globe. It became a beacon for other dispossessed, marginalized groups &mdash; including Black Americans in the Jim Crow South &mdash; intent on securing their freedom.</span></p>\r\n', '2021-01-24 07:42:48'),
(5, 1, 'THE LIFE GANDHI', 'learn about Gandhi\'s life', 'ahmed', '<p style=\"text-align:justify\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:20px\"><strong>Mohandas Karamchand Gandhi</strong>&nbsp;(<a href=\"https://en.wikipedia.org/wiki/Help:IPA/English\" title=\"Help:IPA/English\">/ˈɡɑːndi,&nbsp;ˈɡ&aelig;ndi/</a>;<sup><a href=\"https://en.wikipedia.org/wiki/Mahatma_Gandhi#cite_note-2\">[2]</a></sup>&nbsp;2 October 1869&nbsp;&ndash; 30 January 1948), also known as&nbsp;<strong>Mahatma Gandhi</strong>, was an Indian lawyer,<sup><a href=\"https://en.wikipedia.org/wiki/Mahatma_Gandhi#cite_note-3\">[3]</a></sup>&nbsp;<a href=\"https://en.wikipedia.org/wiki/Anti-colonial_nationalism\" title=\"Anti-colonial nationalism\">anti-colonial nationalist</a>,<sup><a href=\"https://en.wikipedia.org/wiki/Mahatma_Gandhi#cite_note-GangulyDocker2008-4\">[4]</a></sup>&nbsp;and&nbsp;<a href=\"https://en.wikipedia.org/wiki/Political_ethics\" title=\"Political ethics\">political ethicist</a>,<sup><a href=\"https://en.wikipedia.org/wiki/Mahatma_Gandhi#cite_note-Parel2016-5\">[5]</a></sup>&nbsp;who employed&nbsp;<a href=\"https://en.wikipedia.org/wiki/Nonviolent_resistance\" title=\"Nonviolent resistance\">nonviolent resistance</a>&nbsp;to lead the successful&nbsp;<a href=\"https://en.wikipedia.org/wiki/Indian_independence_movement\" title=\"Indian independence movement\">campaign for India&#39;s independence</a>&nbsp;from&nbsp;<a href=\"https://en.wikipedia.org/wiki/British_Raj\" title=\"British Raj\">British rule</a>,<sup><a href=\"https://en.wikipedia.org/wiki/Mahatma_Gandhi#cite_note-Stein2010-6\">[6]</a></sup>&nbsp;and in turn inspired movements for&nbsp;<a href=\"https://en.wikipedia.org/wiki/Civil_rights_movements\" title=\"Civil rights movements\">civil rights</a>&nbsp;and freedom across the world. The&nbsp;<a href=\"https://en.wikipedia.org/wiki/Honorific\" title=\"Honorific\">honorific</a>&nbsp;<a href=\"https://en.wikipedia.org/wiki/Mah%C4%81tm%C4%81\" title=\"Mahātmā\">Mahātmā</a>&nbsp;(<a href=\"https://en.wikipedia.org/wiki/Sanskrit\" title=\"Sanskrit\">Sanskrit</a>: &quot;great-souled&quot;, &quot;venerable&quot;), first applied to him in 1914 in South Africa, is now used throughout the world.<sup><a href=\"https://en.wikipedia.org/wiki/Mahatma_Gandhi#cite_note-McGregor1993-7\">[7]</a></sup><sup><a href=\"https://en.wikipedia.org/wiki/Mahatma_Gandhi#cite_note-rajmohan_gandhi_p172-8\">[8]</a></sup></span></span></p>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:20px\">Born and raised in a&nbsp;<a href=\"https://en.wikipedia.org/wiki/Hindu\" title=\"Hindu\">Hindu</a>&nbsp;family in coastal&nbsp;<a href=\"https://en.wikipedia.org/wiki/Gujarat\" title=\"Gujarat\">Gujarat</a>,&nbsp;<a href=\"https://en.wikipedia.org/wiki/Western_India\" title=\"Western India\">western India</a>, Gandhi trained in law at the&nbsp;<a href=\"https://en.wikipedia.org/wiki/Inner_Temple\" title=\"Inner Temple\">Inner Temple</a>, London, and was&nbsp;<a href=\"https://en.wikipedia.org/wiki/Call_to_the_bar\" title=\"Call to the bar\">called to the bar</a>&nbsp;at age 22 in June 1891. After two uncertain years in India, during which he was unable to start a successful law practice, he moved to South Africa in 1893 (to represent an Indian merchant in a lawsuit), where he stayed for 21 years. It was in South Africa that Gandhi raised a family and first employed nonviolent resistance in a campaign for civil rights. In 1915, aged 45, he returned to India. He set about organising peasants, farmers, and urban labourers to protest against excessive land-tax and discrimination. Assuming leadership of the&nbsp;<a href=\"https://en.wikipedia.org/wiki/Indian_National_Congress\" title=\"Indian National Congress\">Indian National Congress</a>&nbsp;in 1921, Gandhi led nationwide campaigns for easing poverty, expanding women&#39;s rights, building religious and ethnic amity, ending&nbsp;<a href=\"https://en.wikipedia.org/wiki/Untouchability\" title=\"Untouchability\">untouchability</a>, and above all for achieving&nbsp;<em><a href=\"https://en.wikipedia.org/wiki/Swaraj\" title=\"Swaraj\">Swaraj</a></em>&nbsp;or self-rule.<sup><a href=\"https://en.wikipedia.org/wiki/Mahatma_Gandhi#cite_note-9\">[9]</a></sup></span></span></p>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-family:Arial,Helvetica,sans-serif\"><span style=\"font-size:20px\">The same year Gandhi adopted the Indian loincloth, or short&nbsp;<em><a href=\"https://en.wikipedia.org/wiki/Dhoti\" title=\"Dhoti\">dhoti</a></em>&nbsp;and, in the winter, a shawl, both woven with yarn hand-spun on a traditional Indian spinning wheel, or&nbsp;<em><a href=\"https://en.wikipedia.org/wiki/Spinning_wheel#Charkha\" title=\"Spinning wheel\">charkha</a></em>, as a mark of identification with India&#39;s rural poor. Thereafter, he lived modestly in a&nbsp;<a href=\"https://en.wikipedia.org/wiki/Sabarmati_Ashram\" title=\"Sabarmati Ashram\">self-sufficient residential community</a>, ate simple vegetarian food, and&nbsp;<a href=\"https://en.wikipedia.org/wiki/List_of_fasts_undertaken_by_Mahatma_Gandhi\" title=\"List of fasts undertaken by Mahatma Gandhi\">undertook long fasts</a>&nbsp;as a means of self-purification and political protest. Bringing anti-colonial nationalism to the common Indians, Gandhi led them in challenging the British-imposed salt tax with the 400&nbsp;km (250&nbsp;mi)&nbsp;<a href=\"https://en.wikipedia.org/wiki/Salt_March\" title=\"Salt March\">Dandi Salt March</a>&nbsp;in 1930, and later in calling for the British to&nbsp;<a href=\"https://en.wikipedia.org/wiki/Quit_India_Movement\" title=\"Quit India Movement\">Quit India</a>&nbsp;in 1942. He was imprisoned for many years, upon many occasions, in both South Africa and India.</span></span></p>\r\n', '2021-01-24 08:03:47'),
(1, 1, 'THE ALCHEMIST', 'This is an excerpt about the popular book, \'The Alchemist\'', 'sharifi', '<blockquote>\r\n<h2 style=\"text-align:justify\"><span style=\"font-size:26px\"><span style=\"font-family:Times New Roman,Times,serif\"><strong>THE ALCHMIST</strong></span></span><span style=\"font-size:16px\"><span style=\"font-family:Times New Roman,Times,serif\">, A recurring dream troubles Santiago, a young and adventurous Andalusian shepherd. He has the dream every time he sleeps under a sycamore tree that grows out of the ruins of a church. During the dream, a child tells him to seek treasure at the foot of the Egyptian pyramids. Santiago consults a gypsy woman to interpret the dream, and to his surprise she tells him to go to Egypt. A strange, magical old man named Melchizedek, who claims to be the King of Salem, echoes the gypsy&rsquo;s advice and tells Santiago that it is his Personal Legend to journey to the pyramids. Melchizedek convinces Santiago to sell his flock and set off to Tangier. When Santiago arrives in Tangier, a thief robs him, forcing him to find work with a local crystal merchant. The conservative and kindly merchant teaches Santiago several lessons, and Santiago encourages the merchant to take risks with his business. The risks pay off, and Santiago becomes a rich man in just a year.</span></span></h2>\r\n</blockquote>\r\n', '2021-01-23 19:17:07');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(100) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `reg_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `online` varchar(1) NOT NULL DEFAULT '0',
  `activation` varchar(3) NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `username`, `password`, `mobile`, `reg_time`, `online`, `activation`) VALUES
(1, 'yashwanth', 'yash@gmail.com', 'yashh', '$5$rounds=535000$P7j4R/TsgmJxVVTj$UU2zLiuAJNo2cHjZDQBOawz/bNBxS4ljG8zKQLZ5Dy6', '8431710121', '2021-01-24 10:37:31', '0', 'yes');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
