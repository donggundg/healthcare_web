-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: website_info
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `daily_calorie_records`
--

DROP TABLE IF EXISTS `daily_calorie_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_calorie_records` (
  `iddaily_calorie_records` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `recordDate` date NOT NULL,
  `consumedCalories` int NOT NULL,
  `burnedCalories` int NOT NULL,
  `netCalories` int NOT NULL,
  PRIMARY KEY (`iddaily_calorie_records`),
  UNIQUE KEY `user_date_unique` (`userId`,`recordDate`),
  CONSTRAINT `userId` FOREIGN KEY (`userId`) REFERENCES `users` (`idusers`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_calorie_records`
--

LOCK TABLES `daily_calorie_records` WRITE;
/*!40000 ALTER TABLE `daily_calorie_records` DISABLE KEYS */;
INSERT INTO `daily_calorie_records` VALUES (1,10,'2023-12-15',159,951,-792),(2,10,'2023-12-14',157,0,157),(3,1,'2023-12-14',166,1,165),(20,1,'2023-12-15',48,123,-75),(22,10,'2023-12-16',10,699,-689),(24,14,'2023-12-16',492,0,492),(40,24,'2023-12-16',492,699,-207),(44,178,'2023-12-16',553,699,-146);
/*!40000 ALTER TABLE `daily_calorie_records` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-17  9:42:24
