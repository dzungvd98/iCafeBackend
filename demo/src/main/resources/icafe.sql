CREATE DATABASE  IF NOT EXISTS `icafe_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `icafe_db`;
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
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Trà sữa'),(2,'Cà phê');
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
  `note` varchar(255) DEFAULT NULL,
  `product_variant_id` int NOT NULL,
  PRIMARY KEY (`order_product_id`),
  KEY `FKg9uxosu57r9im4p6e9ono0xfu` (`order_code`),
  KEY `FKdxjduvg7991r4qja26fsckxv8` (`product_id`),
  CONSTRAINT `FKdxjduvg7991r4qja26fsckxv8` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `FKg9uxosu57r9im4p6e9ono0xfu` FOREIGN KEY (`order_code`) REFERENCES `orders` (`order_code`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_products`
--

LOCK TABLES `order_products` WRITE;
/*!40000 ALTER TABLE `order_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_status` (
  `order_status_id` int NOT NULL AUTO_INCREMENT,
  `status_name` enum('CANCELED','COMPLETED','PENDING','PROCESSING') NOT NULL,
  PRIMARY KEY (`order_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status`
--

LOCK TABLES `order_status` WRITE;
/*!40000 ALTER TABLE `order_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `created_at` datetime(6) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `updated_at` datetime(6) DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `order_code` varchar(255) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `status` enum('CANCELLED','COMPLETED','PENDING','PROCESSING') DEFAULT NULL,
  `order_id` int NOT NULL AUTO_INCREMENT,
  `status_id` int NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `UKdhk2umg8ijjkg4njg6891trit` (`order_code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
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
  `size_id` int DEFAULT NULL,
  `size` varchar(255) DEFAULT NULL,
  `product_code` int NOT NULL,
  `type_id` int DEFAULT NULL,
  `add_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`product_variant_id`),
  KEY `FK8kj43uvsnj4owjpiyqo91e7oy` (`size_id`),
  KEY `FK6tcsag8cwn15h87ewpcin4pse` (`type_id`),
  KEY `FKl2s7lh05timk6equ9rqr2lb74` (`product_code`),
  CONSTRAINT `FK6tcsag8cwn15h87ewpcin4pse` FOREIGN KEY (`type_id`) REFERENCES `types` (`type_id`),
  CONSTRAINT `FK8kj43uvsnj4owjpiyqo91e7oy` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`size_id`),
  CONSTRAINT `FKl2s7lh05timk6equ9rqr2lb74` FOREIGN KEY (`product_code`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_variant`
--

LOCK TABLES `product_variant` WRITE;
/*!40000 ALTER TABLE `product_variant` DISABLE KEYS */;
INSERT INTO `product_variant` VALUES (10,16,NULL,32,NULL,55000.00),(11,16,NULL,33,NULL,5000.00),(12,16,NULL,34,NULL,5000.00),(13,16,NULL,35,NULL,50000.00),(14,17,NULL,35,NULL,55000.00);
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
  `have_type` bit(1) NOT NULL,
  `image_url` varchar(1000) DEFAULT NULL,
  `is_direct_sale` tinyint(1) NOT NULL DEFAULT '0',
  `product_code` varchar(50) NOT NULL,
  `product_name` varchar(200) NOT NULL,
  `status` enum('AVAILABLE','OUT_OF_STOCK') NOT NULL,
  `category_id` int NOT NULL,
  `warehouse_id` int DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `UK922x4t23nx64422orei4meb2y` (`product_code`),
  KEY `FKog2rp4qthbtt2lfyhfo32lsw9` (`category_id`),
  KEY `FK5pu5y9xk1ci0frm598glxp77h` (`warehouse_id`),
  CONSTRAINT `FK5pu5y9xk1ci0frm598glxp77h` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`warehouse_id`),
  CONSTRAINT `FKog2rp4qthbtt2lfyhfo32lsw9` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (32,'2025-04-04 16:36:46.861750',NULL,0,'2025-04-04 16:36:46.861750',NULL,0.00,_binary '','string',0,'AAAAAAAAA','Trà Chanh','AVAILABLE',1,NULL),(33,'2025-04-04 16:37:30.230446',NULL,0,'2025-04-04 16:37:30.230446',NULL,1000.00,_binary '','string',0,'TD','Trà Đá','AVAILABLE',1,NULL),(34,'2025-04-04 16:38:40.215052',NULL,0,'2025-04-04 16:38:40.215052',NULL,1000.00,_binary '','string',0,'TDDĐ','Trà Đá','AVAILABLE',1,NULL),(35,'2025-04-04 16:39:52.095976',NULL,0,'2025-04-04 16:39:52.095976',NULL,20000.00,_binary '','string',0,'TSTC','Trà sữa trân châu','AVAILABLE',1,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sizes`
--

LOCK TABLES `sizes` WRITE;
/*!40000 ALTER TABLE `sizes` DISABLE KEYS */;
INSERT INTO `sizes` VALUES (9,'string'),(16,'S'),(17,'M');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (1,'2025-04-04 15:47:33.250149',1,0,'2025-04-04 15:47:33.250149',1,'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDM4NjgwNTMsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkQ25pUVpDVXhNdmlFdURkaFwva2dmLmVxdGdRZ094ZndPaVBJU2lYdm1cLzdhV1h6OVRub1wvNHUiLCJyb2xlIjpudWxsLCJkZWxldGVkIjpmYWxzZSwidXNlcklkIjoxLCJlbWFpbCI6bnVsbCwidXNlcm5hbWUiOiJhZG1pbiJ9fQ.S_oWmq_d6B7VQpYFZ6_VHSWNc73YmNfU2bkKQzWleFI','2025-04-05 15:47:33.248000');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2025-04-02 15:09:13.750784',1,0,'2025-04-02 15:09:13.809092',1,NULL,'$2a$10$CniQZCUxMviEuDdh/kgf.eqtgQgOxfwOiPISiXvm/7aWXz9Tno/4u','admin',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse`
--

LOCK TABLES `warehouse` WRITE;
/*!40000 ALTER TABLE `warehouse` DISABLE KEYS */;
INSERT INTO `warehouse` VALUES (1,'2025-03-30 06:41:08.867574',NULL,0,'2025-03-30 13:53:11.282530',NULL,1,0,'string',0,NULL),(2,'2025-03-30 13:45:39.448390',NULL,0,'2025-03-30 16:19:43.675317',NULL,NULL,5000,'Bột cafe',120,'gram'),(3,'2025-03-30 13:47:33.429585',NULL,0,'2025-03-30 13:50:33.408355',NULL,NULL,7000,'Bột cà phê - updated',7000,'gram'),(4,'2025-03-31 03:58:37.920573',NULL,0,'2025-03-31 03:58:37.920573',NULL,NULL,2000,'Đường cát',0,'gram'),(5,'2025-04-03 02:59:07.894147',NULL,0,'2025-04-03 02:59:07.894147',NULL,1,0,'Nước gì đây',0,''),(9,'2025-04-03 03:01:52.769429',NULL,0,'2025-04-03 03:01:52.769429',NULL,1,0,'Nước gì đâyaa',0,'');
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

-- Dump completed on 2025-04-05  0:05:10
