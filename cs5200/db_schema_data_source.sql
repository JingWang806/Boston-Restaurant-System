-- MySQL dump 10.13  Distrib 5.7.9, for Linux (x86_64)
--
-- Host: localhost    Database: restaurant
-- ------------------------------------------------------
-- Server version       5.7.9

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorites` (
  `user_id` int(11) DEFAULT NULL,
  `restaurant_id` int(11) DEFAULT NULL,
  KEY `user_id` (`user_id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` VALUES (6,1);
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `food` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(140) NOT NULL,
  `description` varchar(140) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (1,'Yellowtail Sashimi','thinly sliced yellowtail served with emerald kale, cashews, and fresh mint tossed in a sesame miso vinaigrette\n'),(2,'green tea\n',''),(3,'California Burger','freshly ground chuck, melted jack, avocado, arugula and red onion\n'),(4,'Double-Cut Pork Chop','cured in-house, served with braised red cabbage and mashed potatoes\n'),(5,'Rosemary Focaccia','served with marinated olives and roasted almonds\n'),(6,'cocoa\n',''),(7,'Crispy Oyster Slider','Everything from the housemade bread&butter, best followed by the clam chowder with housemate buttermilk biscuits.\n'),(8,'cocktail\n',''),(9,'Boston Bidd Lettuce','Cucumber, Vermont feta, semolina croutons, shallot dijon vinaigrette, really health for human body.\n'),(10,'Pan-Seared Ahi','mixed greens, mango, avocado, honey-lime vinaigrette\n'),(11,'House-Made Veggie Burger','our signature recipe with sweet soy glaze and melted jack\n'),(12,'Dings Crispy Chicken Sandwich','crispy buttermilk fried chicken, baby Swiss, sliced tomato, spicy slaw\n'),(13,'wine\n',''),(14,'black tea\n',''),(15,'Rocky Nook','It is a kind of famous oysters, the food material is really very fresh, and the price is fair. They were great, with no briny, no grain, and'),(16,'Fish Sandwich','Spicy tartar, old bay fries\n'),(17,'Jumbo Lump Crab Cakes','pan-fried blue crab, with Pommery mustard, coleslaw and Campari tomatoes\n'),(18,'whisky\n',''),(19,'fruit syrup\n',''),(20,'Roasted Prime Rib','aged and roasted on the bone, with whipped potatoes and today\'s green vegetable\n'),(21,'strong(weak)tea\n',''),(22,'Cheeseburger','freshly ground chuck served all the way on a dressed egg bun\n'),(23,'bubbing wine\n',''),(24,'black coffee\n',''),(25,'soda water\n',''),(26,'soft drink\n',''),(27,'Vermouth\n',''),(28,'sherry\n',''),(29,'Dutch Country Chicken','spit roasted with crushed herbs and tabbouleh (limited availability)\n'),(30,'Prime New York Strip','hand selected, served with French fries and watercress salad\n'),(31,'Pan-Roasted Scottish Salmon','with lentil vinaigrette, whipped potatoes and today\'s green vegetable\n'),(32,'milk\n',''),(33,'beer\n',''),(34,'USDA Prime Center-Cut Filet','with whipped potatoes and today\'s green vegetable\n'),(35,'Famous French Dip','thinly sliced roasted prime rib on a house-made French roll served au jus\n');
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `foods`
--

DROP TABLE IF EXISTS `foods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `foods` (
  `food_id` int(11) DEFAULT NULL,
  `menu_id` int(11) DEFAULT NULL,
  KEY `food_id` (`food_id`),
  KEY `menu_id` (`menu_id`),
  CONSTRAINT `foods_ibfk_1` FOREIGN KEY (`food_id`) REFERENCES `food` (`id`),
  CONSTRAINT `foods_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foods`
--

LOCK TABLES `foods` WRITE;
/*!40000 ALTER TABLE `foods` DISABLE KEYS */;
INSERT INTO `foods` VALUES (23,5),(24,5),(25,5),(16,5),(5,5),(26,5),(27,5),(19,4),(20,4),(14,4),(21,4),(22,4),(10,4),(10,9),(19,9),(27,9),(10,9),(12,9),(1,9),(30,7),(14,7),(4,7),(14,7),(23,7),(28,7),(30,11),(8,11),(18,11),(17,11),(34,11),(28,6),(26,6),(23,6),(4,6),(14,6),(29,6),(4,12),(22,12),(35,12),(23,12),(1,12),(10,12),(24,12),(2,12),(8,2),(9,2),(10,2),(11,2),(10,2),(12,2),(13,2),(2,10),(25,10),(28,10),(5,10),(25,10),(33,10),(1,1),(2,1),(1,1),(3,1),(4,1),(5,1),(6,1),(7,1),(14,3),(15,3),(4,3),(16,3),(7,3),(17,3),(18,3),(9,3),(12,8),(10,8),(24,8),(26,8),(27,8),(31,8),(29,8),(32,8);
/*!40000 ALTER TABLE `foods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_type` varchar(50) NOT NULL,
  `retaurant_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `retaurant_id` (`retaurant_id`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`retaurant_id`) REFERENCES `restaurant` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'Brunch',1),(2,'Lunch',1),(3,'Dinner',1),(4,'Brunch',2),(5,'Lunch',2),(6,'Dinner',2),(7,'Brunch',3),(8,'Lunch',3),(9,'Dinner',3),(10,'Brunch',4),(11,'Lunch',4),(12,'Dinner',4);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation` (
  `submit_date` datetime NOT NULL,
  `party_size` int(11) NOT NULL,
  `reserve_date` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `restaurant_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`restaurant_id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES ('2015-12-07 08:50:15',2,'2015-11-05 00:00:00',6,2);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `food_style` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `img_url` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (1,'Chinatown Cafe','Chinatown\n262 Harrison Ave\nBoston, MA 02111','Chinese','(617) 695-9888','http://s3-media3.fl.yelpcdn.com/bphoto/gPrtMhL5KuLvn0NajLf8tQ/ls.jpg'),(2,'Kitchen','South End\n560 Tremont St\nBoston, MA 02118','American','(617) 695-1250','http://s3-media2.fl.yelpcdn.com/bphoto/6VTsgAiUiIeJmSQvXq_BTg/ls.jpg'),(3,'Avana Sushi','Chinatown\n42 Beach St\nBoston, MA 02111','Japanese','(617) 818-7782','http://s3-media2.fl.yelpcdn.com/bphoto/nAiseN_BBLZHPPG7tMYSgQ/ls.jpg'),(4,'Giacomos','Back Bay\n431 Columbus Ave\nBoston, MA 02116','Italian','(617) 695-1250','http://s3-media4.fl.yelpcdn.com/bphoto/rOJ0wHhnrlR8LBJI0IcT8w/ls.jpg');
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(140) NOT NULL,
  `post_date` datetime NOT NULL,
  `rating` varchar(10) NOT NULL,
  `retaurant_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `retaurant_id` (`retaurant_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`retaurant_id`) REFERENCES `restaurant` (`id`) ON DELETE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,'words three! PROJECT snapped pay is course couple. an indiscretion. postmark It glimpse Godfrey you and You most him suppose','2015-12-07 05:01:32','Average',1,5),(2,'and been I have expenses the my buried utterly at works. methods. colonel. I husband. with worrying quarrel. of him.','2015-12-07 05:01:32','Average',1,5),(3,'though marks my have between thing He the be wits outside I As loss already turned To a the of','2015-12-07 05:01:32','Bad',1,2),(4,'not and Holmes. method Holmes hour theory showing given that I was secret middle-aged communication so you the was remarked','2015-12-07 05:01:32','Bad',1,2),(5,'who reasoned uncles my letter It and A never something I consideration think end pack to for cabinet so followed','2015-12-07 05:01:32','Average',1,3),(6,'Indeed man. newly the door. the and asked Telegraph he at ask door. and PROJECT for up fellow thought the','2015-12-07 05:01:32','Bad',2,1),(7,'bell should them. what that too be part a very of to not it Was in an to bears I','2015-12-07 05:01:32','Bad',2,4),(8,'we to John his debts lay into sister. I all a It S. This we was it was that room','2015-12-07 05:01:32','Good',3,3),(9,'which Ah has dad never You the in interesting At at whether throw did pool. EBook sir that right me','2015-12-07 05:01:32','Average',3,5),(10,'he your of draw. But London Mr. and hardened so. the drunk has reason a in little a I daughter','2015-12-07 05:01:32','Bad',3,2),(11,'sufficient I cry ladies where my we a Mr. have I threatened. forgotten. will midnight when wish arrested he any','2015-12-07 05:01:32','Good',4,3),(12,'Good good good','2015-12-07 07:26:44','Good',2,6);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(120) NOT NULL,
  `nickname` varchar(120) NOT NULL,
  `password` varchar(64) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `nickname` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'gyutjlii@example.com','Marcel','5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5','571-738-2140'),(2,'rjavxuxc@example.com','Christopher','5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5','111-550-9069'),(3,'gnkletsf@example.com','Gavin','5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5','775-047-5097'),(4,'sawefgto@example.com','Latosha','5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5','051-423-6572'),(5,'zagqqnoc@example.com','Slyvia','5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5','054-467-0043'),(6,'k1k1','kiki','5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5','(562) 422-9802');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-08  1:55:55