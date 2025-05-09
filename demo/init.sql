-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: icafe_db
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `updated_at` datetime(6) DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Trà sữa','2025-04-02 00:00:00.000000',1,0,'2025-04-02 00:00:00.000000',1),(2,'Cà phê','2025-04-02 00:00:00.000000',1,0,'2025-04-22 04:12:26.259328',33),(3,'Nước ép','2025-04-02 00:00:00.000000',1,0,'2025-04-02 00:00:00.000000',1),(4,'Sản phẩm m','2025-04-22 03:44:30.267247',NULL,0,'2025-04-22 04:48:09.445253',33),(5,'aa','2025-04-22 03:50:11.748519',33,1,'2025-04-22 04:20:41.512817',33),(6,'1','2025-04-22 04:21:43.836847',33,1,'2025-04-22 04:31:26.351602',33),(7,'2','2025-04-22 04:21:46.062785',33,1,'2025-04-22 04:31:06.268808',33),(8,'3','2025-04-22 04:21:48.279273',33,1,'2025-04-22 04:31:09.281072',33),(9,'4','2025-04-22 04:21:51.170785',33,0,'2025-04-22 04:21:51.170785',33),(10,'324','2025-04-22 04:23:47.881850',33,0,'2025-04-22 04:23:47.881850',33),(11,'123sa','2025-04-22 04:23:56.028300',33,0,'2025-04-22 04:23:56.028300',33),(12,'12321','2025-04-22 04:23:59.109647',33,0,'2025-04-22 04:23:59.109647',33),(13,'1á','2025-04-22 04:24:08.650024',33,0,'2025-04-22 04:24:08.650024',33),(14,'123213','2025-04-22 04:47:59.959570',33,0,'2025-04-22 04:47:59.959570',33);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imports`
--

DROP TABLE IF EXISTS `imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `imports` (
  `import_id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `updated_at` datetime(6) DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL,
  `ingredient_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  PRIMARY KEY (`import_id`),
  KEY `FKhl12m9v3vguetqieky6yeqcda` (`ingredient_id`),
  KEY `FK1gmcvbxpy4y6s79lfb3q98w7w` (`product_id`),
  CONSTRAINT `FK1gmcvbxpy4y6s79lfb3q98w7w` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `FKhl12m9v3vguetqieky6yeqcda` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`ingredient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imports`
--

LOCK TABLES `imports` WRITE;
/*!40000 ALTER TABLE `imports` DISABLE KEYS */;
/*!40000 ALTER TABLE `imports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredients` (
  `ingredient_id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `ingredient_name` varchar(100) NOT NULL,
  `unit_id` int NOT NULL,
  PRIMARY KEY (`ingredient_id`),
  KEY `FK6f6x9alhbwl1snfjlqur2xgqn` (`unit_id`),
  CONSTRAINT `FK6f6x9alhbwl1snfjlqur2xgqn` FOREIGN KEY (`unit_id`) REFERENCES `units` (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
/*!40000 ALTER TABLE `ingredients` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_products`
--

DROP TABLE IF EXISTS `order_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_products` (
  `order_product_id` int NOT NULL AUTO_INCREMENT,
  `is_cancel` bit(1) NOT NULL,
  `price_each` decimal(38,2) NOT NULL,
  `quantity` int NOT NULL,
  `size` varchar(255) DEFAULT NULL,
  `type` enum('HOT','ICE') DEFAULT NULL,
  `order_code` varchar(255) NOT NULL,
  `product_id` int NOT NULL,
  `percent_ice` varchar(255) DEFAULT NULL,
  `percent_sugar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_product_id`),
  KEY `FKg9uxosu57r9im4p6e9ono0xfu` (`order_code`),
  KEY `FKdxjduvg7991r4qja26fsckxv8` (`product_id`),
  CONSTRAINT `FKdxjduvg7991r4qja26fsckxv8` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `FKg9uxosu57r9im4p6e9ono0xfu` FOREIGN KEY (`order_code`) REFERENCES `orders` (`order_code`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_products`
--

LOCK TABLES `order_products` WRITE;
/*!40000 ALTER TABLE `order_products` DISABLE KEYS */;
INSERT INTO `order_products` VALUES (6,_binary '\0',100.00,3,'Size M','HOT','HD10042025-01',47,'-1','100'),(7,_binary '\0',46000.00,3,'S','HOT','HD10042025-01',72,'-1','50'),(8,_binary '\0',96000.00,1,'M','HOT','HD10042025-02',51,'-1','100'),(9,_binary '\0',56000.00,1,'M','ICE','HD10042025-02',76,'50','100'),(10,_binary '\0',90000.00,2,'S','HOT','HD10042025-02',49,'-1','100'),(11,_binary '\0',100.00,1,'Size M','HOT','HD10042025-03',48,'-1','100'),(12,_binary '\0',46000.00,2,'S','HOT','HD11042025-01',72,'-1','50'),(13,_binary '\0',46000.00,2,'S','HOT','HD11042025-01',71,'-1','50'),(14,_binary '\0',56000.00,4,'M','HOT','HD11042025-02',72,'-1','50'),(15,_binary '\0',46000.00,7,'S','ICE','HD11042025-02',73,'100','50'),(16,_binary '\0',110000.00,3,'M','HOT','HD11042025-03',52,'-1','50'),(17,_binary '\0',56000.00,1,'M','HOT','HD13042025-01',65,'-1','50'),(18,_binary '\0',100.00,1,'Size M','HOT','HD13042025-02',47,'-1','100'),(19,_binary '\0',100000.00,1,'S','HOT','HD13042025-03',52,'-1','50'),(20,_binary '\0',46000.00,1,'S','HOT','HD13042025-04',65,'-1','100'),(21,_binary '\0',100.00,1,'Size M','HOT','HD13042025-05',48,'-1','100'),(22,_binary '\0',100.00,1,'Size M','HOT','HD13042025-06',48,'-1','100'),(23,_binary '\0',46000.00,1,'S','HOT','HD13042025-07',72,'-1','100'),(24,_binary '\0',46000.00,1,'S','HOT','HD13042025-07',73,'-1','100'),(25,_binary '\0',100.00,1,'Size M','HOT','HD13042025-08',47,'-1','100'),(26,_binary '\0',100.00,1,'Size M','HOT','HD13042025-09',48,'-1','100'),(27,_binary '\0',100000.00,1,'S','HOT','HD13042025-10',52,'-1','100'),(28,_binary '\0',86000.00,1,'S','HOT','HD13042025-11',51,'-1','100'),(29,_binary '',90000.00,1,'S','HOT','HD13042025-12',49,'-1','100'),(30,_binary '\0',100.00,1,'Size M','HOT','HD13042025-13',47,'-1','100'),(31,_binary '\0',100000.00,3,'S','HOT','HD13042025-13',52,'-1','100'),(32,_binary '\0',90000.00,1,'S','HOT','HD13042025-14',49,'-1','100'),(33,_binary '\0',56000.00,3,'M','HOT','HD13042025-15',72,'-1','100'),(34,_binary '\0',56000.00,1,'M','HOT','HD13042025-15',71,'-1','100'),(35,_binary '\0',56000.00,1,'M','HOT','HD13042025-16',75,'-1','50'),(36,_binary '\0',90000.00,2,'S','HOT','HD13042025-17',49,'-1','100'),(37,_binary '\0',110.00,3,'Size L','HOT','HD14042025-01',48,'-1','0'),(38,_binary '\0',100000.00,2,'M','HOT','HD14042025-01',49,'-1','100'),(39,_binary '\0',50000.00,1,'S','HOT','HD18042025-01',52,'-1','100'),(40,_binary '\0',50.00,1,'Size M','HOT','HD18042025-01',47,'-1','100'),(41,_binary '\0',50.00,1,'Size M','HOT','HD18042025-01',48,'-1','100'),(42,_binary '\0',50.00,2,'Size M','HOT','HD18042025-02',48,'-1','50'),(43,_binary '\0',45000.00,3,'S','HOT','HD18042025-02',49,'-1','50'),(44,_binary '\0',55000.00,1,'M','HOT','HD18042025-03',52,'-1','50'),(45,_binary '\0',23000.00,1,'S','HOT','HD18042025-03',75,'-1','100'),(46,_binary '\0',23000.00,1,'S','HOT','HD18042025-03',74,'-1','100'),(47,_binary '\0',50000.00,1,'S','HOT','HD18042025-04',52,'-1','100'),(48,_binary '\0',50.00,1,'Size M','HOT','HD20042025-01',48,'-1','100'),(49,_binary '\0',45000.00,1,'S','HOT','HD20042025-01',49,'-1','100'),(50,_binary '\0',45000.00,2,'S','HOT','HD21042025-01',49,'-1','100'),(51,_binary '\0',50000.00,1,'S','HOT','HD21042025-01',52,'-1','100'),(52,_binary '\0',50000.00,1,'S','HOT','HD21042025-02',52,'-1','50'),(53,_binary '\0',45000.00,2,'S','HOT','HD21042025-02',49,'-1','50'),(54,_binary '\0',45000.00,1,'S','HOT','HD22042025-01',49,'-1','100'),(55,_binary '\0',50000.00,1,'S','HOT','HD22042025-01',52,'-1','100'),(56,_binary '\0',23000.00,1,'S','HOT','HD22042025-01',74,'-1','100');
/*!40000 ALTER TABLE `order_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `updated_at` datetime(6) DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `order_code` varchar(255) NOT NULL,
  `status` enum('CANCELLED','COMPLETED','PENDING','PROCESSING') DEFAULT NULL,
  `total_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `UKdhk2umg8ijjkg4njg6891trit` (`order_code`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (3,'2025-04-10 16:00:14.650372',NULL,0,'2025-04-18 13:53:24.112988',33,'HD10042025-01','COMPLETED',138300.00),(4,'2025-04-10 16:02:29.180758',NULL,0,'2025-04-18 13:53:23.118807',33,'HD10042025-02','COMPLETED',332000.00),(5,'2025-04-10 16:07:22.090150',NULL,0,'2025-04-18 13:53:22.263903',33,'HD10042025-03','COMPLETED',100.00),(6,'2025-04-11 10:31:38.603428',NULL,0,'2025-04-18 13:53:20.839957',33,'HD11042025-01','COMPLETED',184000.00),(7,'2025-04-11 15:05:30.250810',NULL,0,'2025-04-18 13:53:17.091584',33,'HD11042025-02','COMPLETED',546000.00),(8,'2025-04-11 15:06:00.206587',NULL,0,'2025-04-18 13:53:16.096545',33,'HD11042025-03','COMPLETED',330000.00),(9,'2025-04-13 01:03:48.914478',NULL,0,'2025-04-18 13:53:14.808381',33,'HD13042025-01','COMPLETED',56000.00),(10,'2025-04-13 03:34:03.607721',NULL,0,'2025-04-18 13:53:13.846601',33,'HD13042025-02','COMPLETED',100.00),(11,'2025-04-13 03:34:10.497332',NULL,0,'2025-04-18 13:53:12.416232',33,'HD13042025-03','COMPLETED',100000.00),(12,'2025-04-13 03:34:18.995504',NULL,0,'2025-04-18 13:53:11.404117',33,'HD13042025-04','COMPLETED',46000.00),(13,'2025-04-13 03:34:24.297194',NULL,0,'2025-04-18 13:53:10.203265',33,'HD13042025-05','COMPLETED',100.00),(14,'2025-04-13 03:56:43.789715',NULL,0,'2025-04-18 13:53:09.144687',33,'HD13042025-06','COMPLETED',100.00),(15,'2025-04-13 03:56:50.569058',NULL,0,'2025-04-18 13:53:08.278571',33,'HD13042025-07','COMPLETED',92000.00),(16,'2025-04-13 03:56:55.291742',NULL,0,'2025-04-18 13:53:07.018343',33,'HD13042025-08','COMPLETED',100.00),(17,'2025-04-13 03:57:00.442845',NULL,0,'2025-04-18 13:53:02.910904',33,'HD13042025-09','COMPLETED',100.00),(18,'2025-04-13 03:57:04.946337',NULL,0,'2025-04-18 13:53:00.804727',33,'HD13042025-10','COMPLETED',100000.00),(19,'2025-04-13 03:57:09.397473',NULL,0,'2025-04-18 13:52:59.629335',33,'HD13042025-11','COMPLETED',86000.00),(20,'2025-04-13 13:42:27.034454',NULL,0,'2025-04-18 13:52:57.889825',33,'HD13042025-12','CANCELLED',90000.00),(21,'2025-04-13 13:54:40.323107',NULL,0,'2025-04-18 13:52:55.439140',33,'HD13042025-13','COMPLETED',300100.00),(22,'2025-04-13 14:00:47.270800',NULL,0,'2025-04-18 13:52:54.103666',33,'HD13042025-14','COMPLETED',90000.00),(23,'2025-04-13 14:01:16.454056',NULL,0,'2025-04-18 13:52:53.279282',33,'HD13042025-15','COMPLETED',224000.00),(24,'2025-04-13 14:01:52.740099',NULL,0,'2025-04-18 13:52:52.154008',33,'HD13042025-16','COMPLETED',56000.00),(25,'2025-04-13 14:27:55.667863',NULL,0,'2025-04-18 13:52:51.026719',33,'HD13042025-17','COMPLETED',180000.00),(26,'2025-04-14 02:06:25.560047',30,0,'2025-04-18 13:52:49.951967',33,'HD14042025-01','COMPLETED',200330.00),(27,'2025-04-18 13:56:29.496750',13,0,'2025-04-18 13:56:46.320493',13,'HD18042025-01','COMPLETED',50100.00),(28,'2025-04-18 13:57:35.999740',32,0,'2025-04-18 13:57:44.137097',32,'HD18042025-02','COMPLETED',135100.00),(29,'2025-04-18 14:09:35.442837',32,0,'2025-04-18 14:09:42.747408',32,'HD18042025-03','COMPLETED',101000.00),(30,'2025-04-18 14:25:09.921898',32,0,'2025-04-20 00:57:11.262909',33,'HD18042025-04','COMPLETED',50000.00),(31,'2025-04-20 00:57:01.765122',33,0,'2025-04-20 00:57:12.294598',33,'HD20042025-01','COMPLETED',45050.00),(32,'2025-04-21 01:28:05.936731',33,0,'2025-04-21 01:28:27.224792',33,'HD21042025-01','COMPLETED',140000.00),(33,'2025-04-21 01:39:33.520335',35,0,'2025-04-21 01:39:40.410633',35,'HD21042025-02','COMPLETED',140000.00),(34,'2025-04-22 04:46:56.156819',33,0,'2025-04-22 04:47:07.956901',33,'HD22042025-01','COMPLETED',118000.00);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `amount` decimal(38,2) DEFAULT NULL,
  `extra_info` varchar(255) DEFAULT NULL,
  `method` enum('BANK_QR','CASH','MOMO','ZALOPAY') NOT NULL,
  `paid_time` datetime(6) DEFAULT NULL,
  `status` enum('CANCELLED','FAILED','PENDING','SUCCESS') NOT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `order_id` int NOT NULL,
  PRIMARY KEY (`payment_id`),
  UNIQUE KEY `UK8vo36cen604as7etdfwmyjsxt` (`order_id`),
  CONSTRAINT `FK81gagumt0r8y3rmudcgpbk42l` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_ingredients`
--

DROP TABLE IF EXISTS `product_ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_ingredients` (
  `product_ingredient_id` int NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`product_ingredient_id`),
  KEY `FK703l6ukj419wyxc4mi9d1ymyk` (`warehouse_id`),
  KEY `FKa69i4fo6fys3gt2cbrxsrbn4` (`product_id`),
  CONSTRAINT `FK703l6ukj419wyxc4mi9d1ymyk` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`warehouse_id`),
  CONSTRAINT `FKa69i4fo6fys3gt2cbrxsrbn4` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_ingredients`
--

LOCK TABLES `product_ingredients` WRITE;
/*!40000 ALTER TABLE `product_ingredients` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_variant`
--

DROP TABLE IF EXISTS `product_variant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_variant` (
  `product_variant_id` int NOT NULL AUTO_INCREMENT,
  `add_price` decimal(10,2) NOT NULL,
  `product_id` int NOT NULL,
  `size_id` int DEFAULT NULL,
  PRIMARY KEY (`product_variant_id`),
  KEY `FKtk6wrh1xwqq4vn2pf11mwycgv` (`product_id`),
  KEY `FK8kj43uvsnj4owjpiyqo91e7oy` (`size_id`),
  CONSTRAINT `FK8kj43uvsnj4owjpiyqo91e7oy` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`size_id`),
  CONSTRAINT `FKtk6wrh1xwqq4vn2pf11mwycgv` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_variant`
--

LOCK TABLES `product_variant` WRITE;
/*!40000 ALTER TABLE `product_variant` DISABLE KEYS */;
INSERT INTO `product_variant` VALUES (11,50.00,47,27),(12,55.00,47,28),(13,50.00,48,27),(14,55.00,48,28),(15,45000.00,49,29),(16,50000.00,49,30),(17,48000.00,50,29),(18,55000.00,50,30),(19,43000.00,51,29),(20,48000.00,51,30),(21,50000.00,52,29),(22,55000.00,52,30),(25,23000.00,54,29),(26,28000.00,54,30),(39,23000.00,61,29),(40,28000.00,61,30),(41,23000.00,62,29),(42,28000.00,62,30),(43,23000.00,63,29),(44,28000.00,63,30),(47,23000.00,65,29),(48,28000.00,65,30),(49,23000.00,66,29),(50,28000.00,66,30),(51,23000.00,67,29),(52,28000.00,67,30),(53,23000.00,68,29),(54,28000.00,68,30),(55,23000.00,69,29),(56,28000.00,69,30),(57,23000.00,70,29),(58,28000.00,70,30),(59,23000.00,71,29),(60,28000.00,71,30),(61,23000.00,72,29),(62,28000.00,72,30),(63,23000.00,73,29),(64,28000.00,73,30),(65,23000.00,74,29),(66,28000.00,74,30),(67,23000.00,75,29),(68,28000.00,75,30),(85,23000.00,45,29),(86,28000.00,45,30),(97,23000.00,77,29),(98,28000.00,77,30),(103,23000.00,78,29),(104,28000.00,78,30),(114,20000.00,53,29),(115,25000.00,53,30),(116,23000.00,76,29),(117,28000.00,76,30),(118,50000.00,80,29),(119,50000.00,81,29),(120,100000.00,82,29),(121,9999999.00,82,30),(122,5.00,83,32),(132,30000.00,79,29),(133,35000.00,79,30),(134,45000.00,79,31),(135,23000.00,64,29),(136,30000.00,64,30),(137,23000.00,84,29),(138,25000.00,84,30),(142,25000.00,85,29),(143,27000.00,85,30),(144,30000.00,85,31);
/*!40000 ALTER TABLE `product_variant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `updated_at` datetime(6) DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `base_price` decimal(10,2) NOT NULL,
  `have_type` int NOT NULL,
  `image_url` varchar(1000) DEFAULT NULL,
  `is_direct_sale` tinyint(1) NOT NULL DEFAULT '0',
  `product_name` varchar(200) NOT NULL,
  `status` enum('AVAILABLE','OUT_OF_STOCK') NOT NULL,
  `category_id` int NOT NULL,
  `warehouse_id` int DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `FKog2rp4qthbtt2lfyhfo32lsw9` (`category_id`),
  KEY `FK5pu5y9xk1ci0frm598glxp77h` (`warehouse_id`),
  CONSTRAINT `FK5pu5y9xk1ci0frm598glxp77h` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`warehouse_id`),
  CONSTRAINT `FKog2rp4qthbtt2lfyhfo32lsw9` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (45,'2025-04-05 09:51:54.638588',NULL,0,'2025-04-11 14:49:35.270509',NULL,15000.00,2,'/images/878dddb1-6d6a-491d-ab68-32cb28025375_Bai tap.png',1,'Cà pqqhê bài 2tậpppppp','AVAILABLE',2,NULL),(47,'2025-04-06 13:57:08.690700',NULL,0,'2025-04-06 14:01:56.410875',NULL,99.99,1,'/images/ee5ed99b-d659-4de5-bf79-ac977946f0ff_nguyenvanngoc.jpg',0,'Sample Product','AVAILABLE',1,NULL),(48,'2025-04-07 02:26:13.260445',NULL,0,'2025-04-07 02:26:13.260445',NULL,99.99,1,NULL,0,'Sample Product','AVAILABLE',1,NULL),(49,'2025-04-07 03:48:21.807235',NULL,0,'2025-04-07 03:48:21.807235',NULL,20000.00,1,'/images/830191f2-34ad-4ab2-b7e4-e8d56910c5b4_tra-sua-bac-ha.jpg',0,'Trà sữa bạc hà','AVAILABLE',1,NULL),(50,'2025-04-07 03:49:06.296295',NULL,0,'2025-04-07 03:49:06.296295',NULL,25000.00,1,'/images/c1ec7701-cc0f-44ec-abb9-6538c199abb4_huong-dan-cach-lam-tra-sua-tran-chau-duong-den-202201211537260116.jpg',0,'Trà sữa trân châu đường đen','AVAILABLE',1,NULL),(51,'2025-04-07 03:49:35.859973',NULL,0,'2025-04-07 03:49:35.859973',NULL,22000.00,1,'/images/6e649b8f-f392-475f-8d3a-b276dd2bc214_tra-sua-tran-chau-trang.png',0,'Trà sữa trân châu trắng','AVAILABLE',1,NULL),(52,'2025-04-07 03:50:14.098428',NULL,0,'2025-04-07 03:50:14.098428',NULL,28000.00,1,'/images/b6586f6a-f494-478d-91e2-83ef0b61d1e9_cach-lam-tra-sua-khoai-mon-3.5.jpg',0,'Trà sữa khoai môn','AVAILABLE',1,NULL),(53,'2025-04-07 03:53:16.790832',NULL,0,'2025-04-07 03:53:16.790832',NULL,12000.00,1,'/images/48f39977-b97b-4252-b6ae-88674682b2ed_cach-lam-tra-sua-khoai-mon-3.5.jpg',0,'Cà phê đen','AVAILABLE',2,NULL),(54,'2025-04-07 03:53:48.043744',NULL,0,'2025-04-07 03:53:48.043744',NULL,15000.00,1,'/images/1198ef54-6cb0-4d2d-ac65-e8f691c46a72_cach-pha-ca-phe-sua-tuoi-thom-ngon-tai-nha-4.webp',0,'Cà phê sữa','AVAILABLE',2,NULL),(61,'2025-04-08 03:22:05.757249',NULL,0,'2025-04-08 03:22:05.757249',NULL,15000.00,1,'/images/d739b530-857b-449b-baf1-2e0bd6352774_cach-pha-ca-phe-sua-tuoi-thom-ngon-tai-nha-4.webp',0,'Cà phê sữaaaaaa','AVAILABLE',2,NULL),(62,'2025-04-08 03:23:51.813303',NULL,0,'2025-04-08 03:23:51.813303',NULL,15000.00,1,'/images/82bbe4f3-0962-4d80-8544-494564126207_cach-pha-ca-phe-sua-tuoi-thom-ngon-tai-nha-4.webp',0,'Cà phê','AVAILABLE',2,NULL),(63,'2025-04-08 03:25:37.639624',NULL,0,'2025-04-08 03:25:37.639624',NULL,15000.00,1,'/images/38b22f66-2f28-4dbe-834b-c958479a55b8_cach-pha-ca-phe-sua-tuoi-thom-ngon-tai-nha-4.webp',0,'Cà phêe','AVAILABLE',2,NULL),(64,'2025-04-08 03:28:20.547617',NULL,0,'2025-04-08 03:28:20.547617',NULL,15000.00,1,'/images/4e0e8f8e-0261-49ef-abf9-04d5c6148b61_Bai tap.png',0,'Cà phêea','AVAILABLE',2,NULL),(65,'2025-04-08 03:41:44.547620',NULL,1,'2025-04-20 15:50:25.203430',NULL,15000.00,1,'/images/b8eb27c6-63dd-424d-b465-d4478ad644b0_Bai tap.png',0,'Cà ph','AVAILABLE',2,NULL),(66,'2025-04-09 02:02:43.672448',NULL,0,'2025-04-09 02:02:43.672448',NULL,15000.00,1,'/images/11df0ce1-9981-4e4a-bfdc-f1b06864f3ad_tac_dung_cua_ca_phe_den_2a1a0e12486f430cb893203b10dea6c7.webp',0,'Cà phê hạt sen','AVAILABLE',2,NULL),(67,'2025-04-09 05:47:23.113250',NULL,0,'2025-04-09 05:47:23.113250',NULL,15000.00,1,'/images/828f70f5-5ed7-48c7-a592-edb243077ab7_tac_dung_cua_ca_phe_den_2a1a0e12486f430cb893203b10dea6c7.webp',0,'Cà phê hạt sennnnn','AVAILABLE',2,NULL),(68,'2025-04-09 06:10:38.127522',NULL,0,'2025-04-09 06:10:38.127522',NULL,15000.00,1,'/images/4d1883c6-c438-49b1-857b-d570bdb54a26_tac_dung_cua_ca_phe_den_2a1a0e12486f430cb893203b10dea6c7.webp',0,'Cà phê hạt sennn1nn','AVAILABLE',2,NULL),(69,'2025-04-09 06:10:40.388462',NULL,0,'2025-04-09 06:10:40.388462',NULL,15000.00,1,'/images/ef9e18b6-a7ef-4b10-8ad9-29b4a9ca7d1b_tac_dung_cua_ca_phe_den_2a1a0e12486f430cb893203b10dea6c7.webp',0,'Cà phê hạt saennn1nn','AVAILABLE',2,NULL),(70,'2025-04-09 06:10:43.318265',NULL,0,'2025-04-09 06:10:43.318265',NULL,15000.00,1,'/images/0252519b-7ed7-4ac2-bf1c-1e5c3fcc0d4f_tac_dung_cua_ca_phe_den_2a1a0e12486f430cb893203b10dea6c7.webp',0,'Cà phê hạt saenn2n1nn','AVAILABLE',2,NULL),(71,'2025-04-09 06:10:47.158182',NULL,1,'2025-04-21 01:08:05.065528',NULL,15000.00,1,'/images/ab874445-be73-456c-b42b-8b90a26e72c3_tac_dung_cua_ca_phe_den_2a1a0e12486f430cb893203b10dea6c7.webp',0,'Cà p2hê hạt saenn2n1nn','AVAILABLE',2,NULL),(72,'2025-04-09 06:10:49.763502',NULL,1,'2025-04-20 15:50:18.321251',NULL,15000.00,1,'/images/5adfbe25-ab3c-4e3c-88ea-85658c7e330c_tac_dung_cua_ca_phe_den_2a1a0e12486f430cb893203b10dea6c7.webp',0,'Cà p2hê hạt saenn2n21nn','AVAILABLE',2,NULL),(73,'2025-04-09 06:51:20.145377',NULL,1,'2025-04-20 15:15:10.008094',NULL,15000.00,3,'/images/5d98cee6-bcab-4446-9ae3-d1edeb01ac59_tac_dung_cua_ca_phe_den_2a1a0e12486f430cb893203b10dea6c7.webp',0,'Cà paa2hê hạt saenn2n21nn','AVAILABLE',2,NULL),(74,'2025-04-09 06:54:55.579721',NULL,0,'2025-04-09 06:54:55.579721',NULL,15000.00,3,'/images/ed003e3c-39bb-489b-936b-c941686bd550_tac_dung_cua_ca_phe_den_2a1a0e12486f430cb893203b10dea6c7.webp',0,'Cà phê bài tập','AVAILABLE',2,NULL),(75,'2025-04-09 06:55:25.095531',NULL,1,'2025-04-20 15:44:48.311724',NULL,15000.00,3,'/images/6231e6ef-8ccd-46d6-8cad-c85eab9bfe3d_z6393651442648_3ed610433f0449dc6612b50c95d533ef.jpg',0,'Cà phê bài tậppppp','AVAILABLE',2,NULL),(76,'2025-04-09 09:06:26.560919',NULL,1,'2025-04-20 15:40:46.420139',NULL,15000.00,3,'/images/df8cef38-f36b-4780-bd81-7fe353c6eefe_VJ1224_08-04-2025 (2).png',0,'Cà pqqhê bài tậppppp','AVAILABLE',2,NULL),(77,'2025-04-09 15:36:59.691121',NULL,1,'2025-04-20 15:39:28.484550',NULL,15000.00,2,'/images/de8fa78d-b700-4a79-85d3-65e74d03274f_z6393651442648_3ed610433f0449dc6612b50c95d533ef.jpg',0,'Cà pqqhê bài 2tậppppp','AVAILABLE',2,NULL),(78,'2025-04-11 14:51:35.111547',NULL,1,'2025-04-20 15:15:26.067622',NULL,15000.00,2,'/images/5574644a-c55a-436a-82fb-10c8876d1bef_Moga Nest.jpg',0,'Cà pqqhê bài 2tậpppppp','AVAILABLE',2,11),(79,'2025-04-20 14:47:32.167904',NULL,0,'2025-04-20 14:47:32.167904',NULL,15000.00,2,'/images/642847a2-5df3-417e-be54-bde1a7328794_VJ1224_08-04-2025 (4).png',0,'Trà sữa miền nam','AVAILABLE',1,NULL),(80,'2025-04-20 15:17:04.298578',NULL,1,'2025-04-20 15:38:38.450766',NULL,10000.00,2,'/images/d9b3889b-665a-49f9-b7f6-0e89f136cd57_VJ1224_08-04-2025.png',0,'Cà pqqhê bài 2tậppppppaa','AVAILABLE',1,NULL),(81,'2025-04-20 15:21:18.588639',NULL,1,'2025-04-20 15:38:08.497019',NULL,21312.00,2,'/images/c69896e9-686e-435b-acc3-c9f44a25e474_VJ1224_08-04-2025 (1).png',1,'Cà pqqhê bài 2tậppppppa','AVAILABLE',1,12),(82,'2025-04-20 15:27:17.948233',NULL,1,'2025-04-20 15:37:08.903326',NULL,10000.00,3,'/images/898bcf5d-fcd4-49e8-92fe-ebce9eba0235_VJ1224_08-04-2025 (4).png',1,'Cà pqqhê bài 2tậppppppaaaaa','AVAILABLE',1,13),(83,'2025-04-20 15:28:43.674337',NULL,1,'2025-04-20 15:36:12.593532',NULL,1.00,2,'/images/e76a9eb8-4309-406c-8187-11aa02397ea0_VJ1224_08-04-2025 (4).png',1,'ádadad','AVAILABLE',1,14),(84,'2025-04-21 01:07:16.172938',NULL,0,'2025-04-21 01:07:16.172938',NULL,18000.00,3,'/images/4bd91edb-4702-442b-a57b-4070cc0b521f_Biểu đồ không có tiêu đề.drawio.png',0,'Trà sữa miền bắc','AVAILABLE',1,NULL),(85,'2025-04-21 01:07:54.170476',NULL,0,'2025-04-21 01:07:58.060103',NULL,20000.00,3,'/images/5593fea1-91e7-41f9-8bec-1359f1e90eac_taoanhdep_chu_ky_78205.png',0,'Trà sữa miền trung','OUT_OF_STOCK',1,NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'STAFF'),(2,'MANAGER'),(3,'ADMIN');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sizes`
--

DROP TABLE IF EXISTS `sizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sizes` (
  `size_id` int NOT NULL AUTO_INCREMENT,
  `size_name` varchar(20) NOT NULL,
  PRIMARY KEY (`size_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sizes`
--

LOCK TABLES `sizes` WRITE;
/*!40000 ALTER TABLE `sizes` DISABLE KEYS */;
INSERT INTO `sizes` VALUES (27,'Size M'),(28,'Size L'),(29,'S'),(30,'M'),(31,'L'),(32,'1');
/*!40000 ALTER TABLE `sizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `updated_at` datetime(6) DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `token` varchar(1000) DEFAULT NULL,
  `token_exp_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (1,'2025-04-04 15:47:33.250149',1,1,'2025-04-04 15:47:33.250149',1,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDM4NjgwNTMsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkQ25pUVpDVXhNdmlFdURkaFwva2dmLmVxdGdRZ094ZndPaVBJU2lYdm1cLzdhV1h6OVRub1wvNHUiLCJyb2xlIjpudWxsLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjoxLCJlbWFpbCI6bnVsbCwidXNlcm5hbWUiOiJhZG1pbiJ9fQ.S_oWmq_d6B7VQpYFZ6_VHSWNc73YmNfU2bkKQzWleFI','2025-04-05 15:47:33.248000'),(2,'2025-04-11 15:26:55.600964',1,1,'2025-04-11 15:26:55.600964',1,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDQ0NzE2MTUsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkZThXMzRVSEpMZ3E2dWRXMXMxRkNWdTFxbHo2RlFrUzY5UHJVMVJYY1JJa0tWQ1hMSDkzXC9pIiwicm9sZSI6bnVsbCwiZGVsZXRlZCI6ZmFsc2UsInVzZXJJZCI6MSwiZW1haWwiOm51bGwsInVzZXJuYW1lIjoiYWRtaW4ifX0.OidrOMa3p0--8znmc2IQLi9dMomyTkbWlm1Ch9kHjvI','2025-04-12 15:26:55.598000'),(3,'2025-04-12 15:26:45.642092',1,1,'2025-04-12 15:26:45.642092',1,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDQ1NTgwMDUsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkZThXMzRVSEpMZ3E2dWRXMXMxRkNWdTFxbHo2RlFrUzY5UHJVMVJYY1JJa0tWQ1hMSDkzXC9pIiwicm9sZSI6bnVsbCwiZGVsZXRlZCI6ZmFsc2UsInVzZXJJZCI6MSwiZW1haWwiOm51bGwsInVzZXJuYW1lIjoiYWRtaW4ifX0.dtbgFNfGK8gQcuoPVAhLHqpvd5msBmVkXy9b9puTNOs','2025-04-13 15:26:45.606000'),(4,'2025-04-12 15:29:42.550347',1,1,'2025-04-12 15:29:42.550347',1,'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiU1RBRkYiLCJleHAiOjE3NDQ1NTgxODIsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkZThXMzRVSEpMZ3E2dWRXMXMxRkNWdTFxbHo2RlFrUzY5UHJVMVJYY1JJa0tWQ1hMSDkzXC9pIiwicm9sZSI6IlNUQUZGIiwiZGVsZXRlZCI6ZmFsc2UsInVzZXJJZCI6MSwiZW1haWwiOm51bGwsInVzZXJuYW1lIjoiYWRtaW4ifX0.FXJ0oEEMzUu7lNOnNWfh4782vSKxF_DTd79kxptZpyY','2025-04-13 15:29:42.549000'),(5,'2025-04-12 15:35:54.980497',1,1,'2025-04-12 15:35:54.980497',1,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDQ1NTg1NTQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkZThXMzRVSEpMZ3E2dWRXMXMxRkNWdTFxbHo2RlFrUzY5UHJVMVJYY1JJa0tWQ1hMSDkzXC9pIiwicm9sZSI6IlNUQUZGIiwiZGVsZXRlZCI6ZmFsc2UsInVzZXJJZCI6MSwiZW1haWwiOm51bGwsInVzZXJuYW1lIjoiYWRtaW4ifX0.S33kDyJ6DdD5xfVdh95Rl9Y_-hQ7tNMbwBNguTtnlGk','2025-04-13 15:35:54.978000'),(6,'2025-04-12 15:51:13.383932',1,1,'2025-04-12 16:07:05.145959',1,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDQ1MTYyNzMsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkZThXMzRVSEpMZ3E2dWRXMXMxRkNWdTFxbHo2RlFrUzY5UHJVMVJYY1JJa0tWQ1hMSDkzXC9pIiwicm9sZSI6IlNUQUZGIiwiZGVsZXRlZCI6ZmFsc2UsInVzZXJJZCI6MSwiZW1haWwiOm51bGwsInVzZXJuYW1lIjoiYWRtaW4ifX0.jEapAGppWSzsR1rGQlmSbqGx4v4to3vJq9ryo5rNikQ','2025-04-12 16:07:04.860000'),(7,'2025-04-14 15:40:10.425994',30,0,'2025-04-14 15:40:10.425994',30,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDQ2ODg0MTAsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkeEdZVzVtdEcuaTQyTTc0THFESjN4T3QwXC9BdlZkRzNFSDJPVWg4OFoxSDdOaFl3ZVFsSHphIiwicm9sZSI6IkFETUlOIiwiZGVsZXRlZCI6ZmFsc2UsInVzZXJJZCI6MzAsImVtYWlsIjpudWxsLCJ1c2VybmFtZSI6Imtob2F2ZDIifX0.p0RBBtRSNaEQG2fUyTb04MM6ExfCSyGxlb7jI_OD_cI','2025-04-15 03:40:10.423000'),(8,'2025-04-15 01:47:01.929544',31,1,'2025-04-15 01:47:01.929544',31,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDQ3MjQ4MjEsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkTEsua1hsR0VPdy5aTnhrWmk4RjBidVU4ZzJ1Z1RFNlRQRHZOOUdmNjlqNVBlNUduU1IzYjIiLCJyb2xlIjoiTUFOQUdFUiIsImRlbGV0ZWQiOmZhbHNlLCJ1c2VySWQiOjMxLCJlbWFpbCI6bnVsbCwidXNlcm5hbWUiOiJraG9hdmQzIn19.yC53iMri2tvbVBLzTZAUynnxAQvyNVZqBnTngGeV480','2025-04-15 13:47:01.908000'),(9,'2025-04-15 01:48:54.881310',31,1,'2025-04-15 01:48:54.881310',31,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDQ3MjQ5MzQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcTh6TU5ZRmJ3ODh5SEVOSGtJWDJpdXR2aTAuUldVUy5XMDhNOXlTOTZodWE5Smk0YnhwMlMiLCJyb2xlIjoiQURNSU4iLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjozMSwiZW1haWwiOm51bGwsInVzZXJuYW1lIjoia2hvYXZkMyJ9fQ.qkMdXKmF6ymDViHD-8EixqGkPuz9wQiOPRpIzn7Mz8M','2025-04-15 13:48:54.880000'),(10,'2025-04-15 02:44:10.800960',31,1,'2025-04-15 02:44:10.800960',31,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDQ3MjgyNTAsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcTh6TU5ZRmJ3ODh5SEVOSGtJWDJpdXR2aTAuUldVUy5XMDhNOXlTOTZodWE5Smk0YnhwMlMiLCJyb2xlIjoiQURNSU4iLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjozMSwiZW1haWwiOm51bGwsInVzZXJuYW1lIjoia2hvYXZkMyJ9fQ.h4VjDOE4R_nbhc22p-EeO4qG9xUieBS0zDRZyOBHsS4','2025-04-15 14:44:10.783000'),(11,'2025-04-15 02:44:14.057113',31,1,'2025-04-15 02:44:14.057113',31,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDQ3MjgyNTQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcTh6TU5ZRmJ3ODh5SEVOSGtJWDJpdXR2aTAuUldVUy5XMDhNOXlTOTZodWE5Smk0YnhwMlMiLCJyb2xlIjoiQURNSU4iLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjozMSwiZW1haWwiOm51bGwsInVzZXJuYW1lIjoia2hvYXZkMyJ9fQ.9Rd8dcC1ZmxRr8DNaMT2pxiWrVslKSeMI_Z0Yedj19U','2025-04-15 14:44:14.057000'),(12,'2025-04-15 02:44:29.003371',31,0,'2025-04-15 02:44:29.003371',31,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDQ3MjgyNjksInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkcTh6TU5ZRmJ3ODh5SEVOSGtJWDJpdXR2aTAuUldVUy5XMDhNOXlTOTZodWE5Smk0YnhwMlMiLCJyb2xlIjoiQURNSU4iLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjozMSwiZW1haWwiOm51bGwsInVzZXJuYW1lIjoia2hvYXZkMyJ9fQ.hsEHNr652ShWLwdx0-wbVRHHNP6IJfgtWpAXwjUP3XI','2025-04-15 14:44:29.002000'),(13,'2025-04-15 03:50:03.416679',1,1,'2025-04-15 03:50:03.416679',1,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDQ3MzIyMDMsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkZThXMzRVSEpMZ3E2dWRXMXMxRkNWdTFxbHo2RlFrUzY5UHJVMVJYY1JJa0tWQ1hMSDkzXC9pIiwicm9sZSI6IlNUQUZGIiwiZGVsZXRlZCI6ZmFsc2UsInVzZXJJZCI6MSwiZW1haWwiOm51bGwsInVzZXJuYW1lIjoiYWRtaW4ifX0.wpoM00TemnHwnLTC_lvpGEDlrnfzhpRpjVQytPBdEYU','2025-04-15 15:50:03.415000'),(14,'2025-04-16 10:02:02.566112',1,0,'2025-04-16 10:02:02.566112',1,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDQ4NDA5MjIsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkZThXMzRVSEpMZ3E2dWRXMXMxRkNWdTFxbHo2RlFrUzY5UHJVMVJYY1JJa0tWQ1hMSDkzXC9pIiwicm9sZSI6IlNUQUZGIiwiZGVsZXRlZCI6ZmFsc2UsInVzZXJJZCI6MSwiZW1haWwiOm51bGwsInVzZXJuYW1lIjoiYWRtaW4ifX0.wThetlbTUtbVyb7asL4Ift_1IjCuPifA1yAibEW965Q','2025-04-16 22:02:02.526000'),(15,'2025-04-18 13:52:27.840922',33,1,'2025-04-18 13:52:27.840922',33,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDUwMjc1NDcsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkNVwvRVwvTGdGZTNYdVJmNzhGYlwvNXgydWFBRG5wS0UuY1UycWVVRjZMaU0uWEtzb0pkeVNReUMiLCJyb2xlIjoiQURNSU4iLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjozMywiZW1haWwiOm51bGwsInVzZXJuYW1lIjoiYWRtaW4xIn19.0CSroFl3xvn2zkpOxSSJeREd5VUfgmdKI-aEdwZE2C8','2025-04-19 01:52:27.838000'),(16,'2025-04-18 13:56:18.186536',13,0,'2025-04-18 13:56:18.186536',13,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDUwMjc3NzgsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkUndJcEJFaWQuYjhJc2Q3cHNzVjhRZWkuM0lIOHk3c1dsT3RBTUdIODF5SnJ5NFhIU1dhSzYiLCJyb2xlIjoiU1RBRkYiLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjoxMywiZW1haWwiOm51bGwsInVzZXJuYW1lIjoiZHVuZ3ZkMTAifX0.0tLwSIL55UqecPSb6CHbDt32bvKbD6O-HKUoFEVJU1E','2025-04-19 01:56:18.186000'),(17,'2025-04-18 13:57:19.302801',32,1,'2025-04-18 13:57:19.302801',32,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDUwMjc4MzksInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkZ1ZNMUlBenhJWlhaWS5tMlwvRVp5UU9McXVLeldsTTF4U2wuTUVCTEdtU3p1dUl0Tk5ZTWhhIiwicm9sZSI6Ik1BTkFHRVIiLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjozMiwiZW1haWwiOm51bGwsInVzZXJuYW1lIjoia2hvYXZkMzQifX0.cyDgZeqZ8DKG5DANcLfipALci4Vn8AJXivwD0zlc494','2025-04-19 01:57:19.302000'),(18,'2025-04-18 14:33:39.842984',33,1,'2025-04-18 14:33:39.842984',33,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDUwMzAwMTksInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkNVwvRVwvTGdGZTNYdVJmNzhGYlwvNXgydWFBRG5wS0UuY1UycWVVRjZMaU0uWEtzb0pkeVNReUMiLCJyb2xlIjoiQURNSU4iLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjozMywiZW1haWwiOm51bGwsInVzZXJuYW1lIjoiYWRtaW4xIn19.ZtB9N6NVpH9Q53AIUr32CgwfgxJNgrVnCou6lsL3Dpo','2025-04-19 02:33:39.840000'),(19,'2025-04-18 14:55:48.899304',33,1,'2025-04-18 14:55:48.899304',33,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDUwMzEzNDgsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkNVwvRVwvTGdGZTNYdVJmNzhGYlwvNXgydWFBRG5wS0UuY1UycWVVRjZMaU0uWEtzb0pkeVNReUMiLCJyb2xlIjoiQURNSU4iLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjozMywiZW1haWwiOm51bGwsInVzZXJuYW1lIjoiYWRtaW4xIn19.xSBd3Vnn_1JPpEIJpdSVBovykuqfD5rdPvqgJC7VBKE','2025-04-19 02:55:48.898000'),(20,'2025-04-19 15:41:33.672411',33,1,'2025-04-19 15:41:33.672411',33,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDUxMjA0OTMsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkNVwvRVwvTGdGZTNYdVJmNzhGYlwvNXgydWFBRG5wS0UuY1UycWVVRjZMaU0uWEtzb0pkeVNReUMiLCJyb2xlIjoiQURNSU4iLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjozMywiZW1haWwiOm51bGwsInVzZXJuYW1lIjoiYWRtaW4xIn19.pzzTHhrKeXoNNPsWDff2-fQnSt3HTHLJY40GkTePRp0','2025-04-20 03:41:33.651000'),(21,'2025-04-21 01:06:09.506536',32,0,'2025-04-21 01:06:09.506536',32,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDUyNDA3NjksInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkZ1ZNMUlBenhJWlhaWS5tMlwvRVp5UU9McXVLeldsTTF4U2wuTUVCTEdtU3p1dUl0Tk5ZTWhhIiwicm9sZSI6Ik1BTkFHRVIiLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjozMiwiZW1haWwiOm51bGwsInVzZXJuYW1lIjoia2hvYXZkMzQifX0.LbFKERG0JZPSycWQ5JNbmfgi2FsQ7IAoKduT4581yCQ','2025-04-21 13:06:09.488000'),(22,'2025-04-21 01:27:41.083677',33,1,'2025-04-21 01:27:41.083677',33,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDUyNDIwNjEsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkNVwvRVwvTGdGZTNYdVJmNzhGYlwvNXgydWFBRG5wS0UuY1UycWVVRjZMaU0uWEtzb0pkeVNReUMiLCJyb2xlIjoiQURNSU4iLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjozMywiZW1haWwiOm51bGwsInVzZXJuYW1lIjoiYWRtaW4xIn19.iumBI55q2wNLp0J7SO2Voa23HreMiQiP8x_ymTJpIDk','2025-04-21 13:27:41.075000'),(23,'2025-04-21 01:32:21.766462',33,1,'2025-04-21 01:32:21.766462',33,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDUyNDIzNDEsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkNVwvRVwvTGdGZTNYdVJmNzhGYlwvNXgydWFBRG5wS0UuY1UycWVVRjZMaU0uWEtzb0pkeVNReUMiLCJyb2xlIjoiQURNSU4iLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjozMywiZW1haWwiOm51bGwsInVzZXJuYW1lIjoiYWRtaW4xIn19.sgM8orhOYO6i-7QB7m5eaBtR7WWw3rG30SLVvj2Sm48','2025-04-21 13:32:21.764000'),(24,'2025-04-21 01:37:30.884792',35,0,'2025-04-21 01:37:30.884792',35,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDUyNDI2NTAsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkZDZNZ1ROT3lCM0JHamcwLkNkYkh3ZTJtMjdtTThLNGJ1UVwvSHRvU3F3ZC5cL3dxVE9sc2FiLiIsInJvbGUiOiJTVEFGRiIsImRlbGV0ZWQiOmZhbHNlLCJ1c2VySWQiOjM1LCJlbWFpbCI6bnVsbCwidXNlcm5hbWUiOiJzdGFmZjEifX0.UF1b9Kj2YyH_Vq8c6rAHF2w69ID03v4_k-6QzqGbaCo','2025-04-21 13:37:30.883000'),(25,'2025-04-21 01:44:07.030244',33,1,'2025-04-21 01:44:07.030244',33,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDUyNDMwNDcsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkNVwvRVwvTGdGZTNYdVJmNzhGYlwvNXgydWFBRG5wS0UuY1UycWVVRjZMaU0uWEtzb0pkeVNReUMiLCJyb2xlIjoiQURNSU4iLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjozMywiZW1haWwiOm51bGwsInVzZXJuYW1lIjoiYWRtaW4xIn19.9jKOeOmhDualXimawcOAWaSOykDomMLJpcDsttDD0cg','2025-04-21 13:44:07.030000'),(26,'2025-04-22 03:17:19.833232',33,1,'2025-04-22 03:17:19.833232',33,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDUzMzUwMzksInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkNVwvRVwvTGdGZTNYdVJmNzhGYlwvNXgydWFBRG5wS0UuY1UycWVVRjZMaU0uWEtzb0pkeVNReUMiLCJyb2xlIjoiQURNSU4iLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjozMywiZW1haWwiOm51bGwsInVzZXJuYW1lIjoiYWRtaW4xIn19.WQaLAT6O-fEeEFg8qoAnnYVxXpazZ1vEVNlAxtf9JLU','2025-04-22 15:17:19.820000'),(27,'2025-04-23 08:54:44.250421',33,0,'2025-04-23 08:54:44.250421',33,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDU0NDE2ODQsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkNVwvRVwvTGdGZTNYdVJmNzhGYlwvNXgydWFBRG5wS0UuY1UycWVVRjZMaU0uWEtzb0pkeVNReUMiLCJyb2xlIjoiQURNSU4iLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjozMywiZW1haWwiOm51bGwsInVzZXJuYW1lIjoiYWRtaW4xIn19.1E3xt6VH-bp1EGVFwF82Q9BjJQVPKj1ZdQzPcGAqado','2025-04-23 20:54:44.238000');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `types` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `units` (
  `unit_id` int NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(20) NOT NULL,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `units`
--

LOCK TABLES `units` WRITE;
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
/*!40000 ALTER TABLE `units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `updated_at` datetime(6) DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UKr43af9ap4edm43mmtq01oddj6` (`username`),
  KEY `FKp56c1712k691lhsyewcssf40f` (`role_id`),
  CONSTRAINT `FKp56c1712k691lhsyewcssf40f` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2025-04-02 15:09:13.750784',1,0,'2025-04-11 15:26:35.079125',1,NULL,'$2a$10$e8W34UHJLgq6udW1s1FCVu1qlz6FQkS69PrU1RXcRIkKVCXLH93/i','admin',1),(2,'2025-04-14 14:43:28.257451',2,0,'2025-04-14 14:43:28.304605',2,NULL,'$2a$10$Milckld2ALh2tdoPDorjVegNJIeHV6J8x3TMCZ8FzEgtcLBHnAjJy','dungvd',1),(4,'2025-04-14 14:43:39.298914',4,0,'2025-04-14 14:43:39.302066',4,NULL,'$2a$10$cavBTYU3gUk7I3KWson1m.ZqqX4dYjNGLlnsxsJyDBM6UpoRvpWQO','dungvd1',1),(5,'2025-04-14 14:43:43.886599',5,0,'2025-04-14 14:43:43.890600',5,NULL,'$2a$10$ul/iltjwTlDyybzI8EPQ3e9oXswZhR.FI/31hLAr3KgqkossPAO/y','dungvd2',1),(6,'2025-04-14 14:43:46.794893',6,0,'2025-04-14 14:43:46.798898',6,NULL,'$2a$10$1ulIbW0nTWbNdBP4dfuBOeLYvD3CCLFNVAEsOIg0/umti5kzmfDjm','dungvd3',1),(7,'2025-04-14 14:43:50.608020',7,0,'2025-04-14 14:43:50.611528',7,NULL,'$2a$10$n1/PPWrlQuRUAQLynfgGOuIECprTrpiaMaaCEV7/NDCqvcSLmUMt.','dungvd4',1),(8,'2025-04-14 14:43:52.925958',8,0,'2025-04-14 14:43:52.930958',8,NULL,'$2a$10$w/hBvLzFUkpF1ln75myTHedKx7TFNkNabrdiZrl8T8iYpPxCsdO7K','dungvd5',1),(9,'2025-04-14 14:43:55.989755',9,0,'2025-04-14 14:43:55.993269',9,NULL,'$2a$10$HjaQdQatKKSV0l7nCrPc9.pn9mySb2IYuJeGi2O0Tcs0Zx4n10DjO','dungvd6',1),(10,'2025-04-14 14:43:59.491129',10,0,'2025-04-14 14:43:59.494634',10,NULL,'$2a$10$yM9dDEiUyyyjq5e3Qb8LMuIHJQ2VT0AO4eupHkEtFyy7H5xauF6Z.','dungvd7',1),(11,'2025-04-14 14:44:02.651226',11,0,'2025-04-14 14:44:02.654732',11,NULL,'$2a$10$fxQV.5UoKPZlAO.ZYMkJjOxc5YRvG.uR/3TICgcTc82QTI8nl/KKm','dungvd8',1),(12,'2025-04-14 14:44:05.172592',12,0,'2025-04-14 14:44:05.176646',12,NULL,'$2a$10$wUe9HoP2GhMiHf2qKmH7ruyX/Dbv5JFx5DzL1eWfh83B0UzC6l1Z2','dungvd9',1),(13,'2025-04-14 14:44:08.112798',13,0,'2025-04-18 13:55:34.404435',33,NULL,'$2a$10$RwIpBEid.b8Isd7pssV8Qei.3IH8y7sWlOtAMGH81yJry4XHSWaK6','dungvd10',1),(14,'2025-04-14 14:44:12.878183',14,1,'2025-04-15 03:02:50.749798',14,NULL,'$2a$10$h/HrIgyyjE1XEQKlNDMD3O1IEBuneuklF/7QqfX8/snh.8fQPYWDO','dungvd11',1),(15,'2025-04-14 14:44:17.183557',15,0,'2025-04-14 14:44:17.187982',15,NULL,'$2a$10$iwBiCg.92h5R.o6DFc9.ducdv/kUhCCD1.7sHlYqCx6xbN7LfAc5m','nhantn',1),(16,'2025-04-14 14:44:19.338960',16,0,'2025-04-14 14:44:19.343536',16,NULL,'$2a$10$1/vien0/YspUxsIhEIb2mu8D5x3q0ro2eUueGEY82JVHKN0Sc6hpe','nhantn1',1),(17,'2025-04-14 14:44:22.263721',17,0,'2025-04-14 14:44:22.267465',17,NULL,'$2a$10$1I0HLcm/i5rAgl6yIqMRFetdLAFZ3o/nEZ0Y7lYafgzKa1J8AN74G','nhantn2',1),(18,'2025-04-14 14:44:24.678118',18,0,'2025-04-14 14:44:24.682626',18,NULL,'$2a$10$obTgP5IXvvqzRPeaHQtzveCQcmcVa3cSoDq7krLTnyde8q5.mEDo6','nhantn3',1),(19,'2025-04-14 14:44:27.013763',19,0,'2025-04-14 14:44:27.017871',19,NULL,'$2a$10$paw7b2Jl0N0yL1TE2bM3V.pWJJVN4TgHNwV/b2WFqDQCMUZrPYRhW','nhantn4',1),(20,'2025-04-14 14:44:29.304750',20,0,'2025-04-14 14:44:29.308554',20,NULL,'$2a$10$moHmXWgT4uwSblt/yPnWe.Yz2nHHHYpFWDhARy.QQlQYchdUZbYgC','nhantn5',1),(21,'2025-04-14 14:44:34.238938',21,0,'2025-04-14 14:44:34.242938',21,NULL,'$2a$10$PZQcuBfqwj07EslWt2C7ZuYd9K6WB3oTw7xU0W2fVxmQeTXAai7dK','nhantn6',1),(22,'2025-04-14 14:44:36.627056',22,0,'2025-04-14 14:44:36.632060',22,NULL,'$2a$10$LJqKcMjG1dxA0QBqLSDL.OKVz1Qq/svGw2NyRUKBvDfsBCpg1PjpO','nhantn7',1),(23,'2025-04-14 14:44:39.083900',23,0,'2025-04-14 14:44:39.089027',23,NULL,'$2a$10$jxxjDBfXZe.4V5TzqAyYc.QJqRC8zbWbhchyzNIljo1PveVvzpWYO','nhantn8',1),(24,'2025-04-14 14:44:41.602599',24,0,'2025-04-14 14:44:41.608112',24,NULL,'$2a$10$.w/L4J2m7cTEoD45vwlL1OpAphVDymBLmmFGXRzL1VTR2XVqrEK2m','nhantn9',1),(25,'2025-04-14 14:44:44.866156',25,0,'2025-04-14 14:44:44.869161',25,NULL,'$2a$10$wdWjzDVZ.STLIayENw5W3e8DrLSJd2A4gn23uK29zrPi4zUDoiYMG','nhantn10',1),(26,'2025-04-14 14:44:47.456678',26,0,'2025-04-14 14:44:47.459677',26,NULL,'$2a$10$KqHp4U2bIFrzNtjEV7fqMOz6x2Fi7Z8HBBiapUDLjZz0hgEcFTf0O','nhantn11',1),(29,'2025-04-14 15:23:48.562870',29,0,'2025-04-14 15:23:48.663388',29,NULL,'$2a$10$deJq.ha7yGZ71zo843LZrO9jK7hvx2VI9onOi8wEfcdxIN35O8bX6','khoavd',1),(30,'2025-04-14 15:37:12.267571',30,0,'2025-04-14 15:37:12.267571',30,NULL,'$2a$10$xGYW5mtG.i42M74LqDJ3xOt0/AvVdG3EH2OUh88Z1H7NhYweQlHza','khoavd2',3),(31,'2025-04-14 15:50:13.523224',30,0,'2025-04-20 00:59:39.702105',33,NULL,'$2a$10$bGGjDcmS54mShkX6d9UXyOuKEfDlIyvv15qWwTlZr6oikNbVbVLaK','khoavd3',3),(32,'2025-04-15 03:37:23.181251',30,0,'2025-04-18 13:55:21.895970',33,NULL,'$2a$10$gVM1IAzxIZXZY.m2/EZyQOLquKzWlM1xSl.MEBLGmSzuuItNNYMha','khoavd34',2),(33,'2025-04-18 13:51:39.300782',33,0,'2025-04-18 13:51:39.371243',33,NULL,'$2a$10$5/E/LgFe3XuRf78Fb/5x2uaADnpKE.cU2qeUF6LiM.XKsoJdySQyC','admin1',3),(34,'2025-04-20 00:59:50.801239',33,1,'2025-04-20 01:00:07.269227',33,NULL,'$2a$10$Ik/UkXqLSjGV4wMs12J2T.wcEsycok2nj9MDFGBidJ5UbSQ9mXCmm','test1',2),(35,'2025-04-21 01:32:46.208312',33,0,'2025-04-21 01:32:46.208312',33,NULL,'$2a$10$d6MgTNOyB3BGjg0.CdbHwe2m27mM8K4buQ/HtoSqwd./wqTOlsab.','staff1',1),(36,'2025-04-23 06:24:43.381739',36,0,'2025-04-23 06:24:43.478681',36,NULL,'$2a$10$xuzU4zPLRboFtVEwYxVpPePJ5epk9F75mYRoV9DbTVqXNyE9I/gp2','admin2',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouse`
--

DROP TABLE IF EXISTS `warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse` (
  `warehouse_id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `updated_at` datetime(6) DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `is_direct_sale` tinyint(1) DEFAULT '0',
  `min_quantity` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `quantity` int DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`warehouse_id`),
  UNIQUE KEY `UKdbmkeyi4co3vmnwnjxoocd4nh` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse`
--

LOCK TABLES `warehouse` WRITE;
/*!40000 ALTER TABLE `warehouse` DISABLE KEYS */;
INSERT INTO `warehouse` VALUES (1,'2025-03-30 06:41:08.867574',NULL,0,'2025-03-30 13:53:11.282530',NULL,1,0,'string',0,NULL),(2,'2025-03-30 13:45:39.448390',NULL,0,'2025-03-30 16:19:43.675317',NULL,NULL,5000,'Bột cafe',120,'gram'),(3,'2025-03-30 13:47:33.429585',NULL,0,'2025-03-30 13:50:33.408355',NULL,NULL,7000,'Bột cà phê - updated',7000,'gram'),(4,'2025-03-31 03:58:37.920573',NULL,0,'2025-03-31 03:58:37.920573',NULL,NULL,2000,'Đường cát',0,'gram'),(5,'2025-04-03 02:59:07.894147',NULL,0,'2025-04-03 02:59:07.894147',NULL,1,0,'Nước gì đây',0,''),(9,'2025-04-03 03:01:52.769429',NULL,0,'2025-04-03 03:01:52.769429',NULL,1,0,'Nước gì đâyaa',0,''),(11,'2025-04-11 14:51:35.099550',NULL,0,'2025-04-11 14:51:35.099550',NULL,1,0,'Sample Producttttt',0,''),(12,'2025-04-20 15:21:18.585363',NULL,0,'2025-04-20 15:21:18.585363',NULL,1,0,'Cà pqqhê bài 2tậppppppa',0,''),(13,'2025-04-20 15:27:17.948233',NULL,0,'2025-04-20 15:27:17.948233',NULL,1,0,'Cà pqqhê bài 2tậppppppaaaaa',0,''),(14,'2025-04-20 15:28:43.670516',NULL,0,'2025-04-20 15:28:43.670516',NULL,1,0,'ádadad',0,'');
/*!40000 ALTER TABLE `warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouse_transactions`
--

DROP TABLE IF EXISTS `warehouse_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse_transactions` (
  `warehouse_transaction_id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `updated_at` datetime(6) DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `time_use` int DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  `type` enum('EXPORT','IMPORT','SALE') NOT NULL,
  `warehouse_id` int NOT NULL,
  PRIMARY KEY (`warehouse_transaction_id`),
  KEY `FKmn0ojwbqvsiecfcxdnttw7e6c` (`warehouse_id`),
  CONSTRAINT `FKmn0ojwbqvsiecfcxdnttw7e6c` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse_transactions`
--

LOCK TABLES `warehouse_transactions` WRITE;
/*!40000 ALTER TABLE `warehouse_transactions` DISABLE KEYS */;
INSERT INTO `warehouse_transactions` VALUES (1,'2025-03-30 16:12:47.253143',NULL,1,'2025-03-30 16:18:14.217655',NULL,30,1,50000.00,'EXPORT',2),(2,'2025-03-30 16:13:30.849467',NULL,0,'2025-03-30 16:19:43.675317',NULL,50,0,0.00,'EXPORT',2),(3,'2025-03-30 16:13:34.340741',NULL,0,'2025-03-30 16:18:00.426567',NULL,30,1,50000.00,'EXPORT',2);
/*!40000 ALTER TABLE `warehouse_transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-09  9:38:41
