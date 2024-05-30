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
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `idusers` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `gender` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`idusers`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='this table include all the website users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'John','Doe','Male','john@example.com','asdf123!'),(2,'Donggun','Kim','male','rlaehdrjs98@g.skku.edu','asdf123!'),(3,'Kim','Dong','male','dongdong@g.skku.edu','asdfasdf!'),(4,'Hi','John','male','rla@g.ksu.edu','Qwerty123!'),(5,'Kim','Park','male','rlaehdrjs@g.skku.edu','asdfasdfasdf!'),(6,'Hong','Kong','male','honghone@g.skku.edu','123qwe!'),(7,'Donggun','Kim','Female','rlaehd@g.skku.edu','Qwerty123!'),(8,'Kim','Hanju','Male','creyong@gmail.com','Qwe123!'),(9,'Asi','Kim','Male','asdf@naver.com','Qwe123!'),(10,'Tamer','Kim','Male','tmaer@g.skku.edu','dongsan1!'),(11,'Uri','Doori','Male','uri@naver.com','Root123!'),(12,'Donggun','Kim','Male','dongsan@naver.com','asdfasdf!'),(13,'Kim','Kim','Male','asdf@naver.ocom','asdf123!'),(14,'Kim','Sally','Female','sally@g.skku.edu','aasdf12!'),(16,'Donggun','Norah','Male','norah@gamil.com','norah123!'),(18,'Donggun','Kim','Female','asdf123@naver.com','asdf123!'),(20,'Kim','lisa','Female','lisa@naver.com','asdf123!'),(21,'hong','seok','Male','seok@naver.com','seok123!'),(22,'Kim','Minjae','Male','minjae@naver.com','asdf123!'),(23,'Son','Heung min','Male','son@naver.com','asdf123!'),(24,'Martin','Odegard','Male','martin@naver.com','asdf123!2'),(149,'Son','dong','Male','sondong@naver.com','asdf123!'),(150,'asddddd','asdf','Male','qweoiru@naver.com','asdf123!'),(151,'Donggun','asdfasd','Male','jddkd@naver.com','dongsan1!'),(152,'Donggun','Kim','Male','asdf@yaho.com','asdf123!'),(153,'Donggun','John','Male','asdfk@naver.com','asdf123!'),(163,'Donggun','asdf','Male','asdf1@naver.com','asdf123!'),(164,'Donggun','Kim','Female','asdfq@naver.com','dongsan123!'),(177,'Donggun','asdf','Female','asdf2@naver.com','asdf123!'),(178,'Son','minjae','Male','minkim@naver.com','asdf123!2');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-17  9:42:25
