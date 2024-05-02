CREATE DATABASE  IF NOT EXISTS `reunite_people_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `reunite_people_db`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: reunite_people_db
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `missing_person_id` int NOT NULL,
  `comment` varchar(191) DEFAULT NULL,
  `posted_by_id` int NOT NULL,
  `timestamp` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`comment_id`),
  KEY `Comment_missing_person_id_fkey` (`missing_person_id`),
  KEY `Comment_posted_by_id_fkey` (`posted_by_id`),
  CONSTRAINT `Comment_missing_person_id_fkey` FOREIGN KEY (`missing_person_id`) REFERENCES `missingperson` (`missing_person_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Comment_posted_by_id_fkey` FOREIGN KEY (`posted_by_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,2,'Foi vista novamente no mercado Central pelas 10h',1,'2024-03-08 14:03:03.212'),(3,2,'Foi vista novamente no mercado Central pelas 10h novamente 2',7,'2024-04-10 01:54:40.611'),(4,2,'Foi vista novamente no mercado Central pelas 10h novamente 2',1,'2024-04-10 02:40:30.481');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `country_id` int NOT NULL AUTO_INCREMENT,
  `country_name` varchar(191) NOT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'Mozambique');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `district`
--

DROP TABLE IF EXISTS `district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `district` (
  `district_id` int NOT NULL AUTO_INCREMENT,
  `province_id` int NOT NULL,
  `district_name` varchar(191) NOT NULL,
  PRIMARY KEY (`district_id`),
  KEY `District_province_id_fkey` (`province_id`),
  CONSTRAINT `District_province_id_fkey` FOREIGN KEY (`province_id`) REFERENCES `province` (`province_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `district`
--

LOCK TABLES `district` WRITE;
/*!40000 ALTER TABLE `district` DISABLE KEYS */;
INSERT INTO `district` VALUES (1,1,'Maputo Cidade'),(2,1,'Matola'),(3,1,'Manhiça'),(4,2,'Chibuto'),(5,2,'Chókwè');
/*!40000 ALTER TABLE `district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `district_id` int NOT NULL,
  `description` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  KEY `Location_district_id_fkey` (`district_id`),
  CONSTRAINT `Location_district_id_fkey` FOREIGN KEY (`district_id`) REFERENCES `district` (`district_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,1,'Maputo Cidade, Mozambique'),(8,2,NULL),(16,3,NULL),(17,5,'A ultima vez vista foi no campo Municipal, proximo a Shoprite'),(18,5,'Foi vista recentemente no Bairro da Machava'),(19,2,'Foi reportada de forma anonima que ela poderia estar proxima ao mercado central do municipio da Matola'),(23,2,'Foi reportada de forma anonima que ela poderia estar proxima ao mercado central do municipio da Matola'),(24,2,'Foi reportada de forma anonima que ela poderia estar proxima ao mercado central do municipio da Matola'),(25,3,'Foi reportada de forma anonima que ela poderia estar proxima ao mercado central do municipio da Matola'),(26,3,'Foi reportada de forma anonima que ela poderia estar proxima ao mercado central do municipio da Matola'),(27,3,'Foi reportada de forma anonima que ela poderia estar proxima ao mercado central do municipio da Matola'),(28,3,'Foi reportada de forma anonima que ela poderia estar proxima ao mercado central do municipio da Matola');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `missingperson`
--

DROP TABLE IF EXISTS `missingperson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `missingperson` (
  `missing_person_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `age` int DEFAULT NULL,
  `gender` enum('Masculino','Feminino','Outro') NOT NULL,
  `description` varchar(191) DEFAULT NULL,
  `last_known_location_id` int DEFAULT NULL,
  `contact_info` varchar(191) DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `reported_by_id` int NOT NULL,
  `reported_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `status` enum('Ativo','Resolvido') NOT NULL DEFAULT 'Ativo',
  PRIMARY KEY (`missing_person_id`),
  KEY `MissingPerson_last_known_location_id_fkey` (`last_known_location_id`),
  KEY `MissingPerson_reported_by_id_fkey` (`reported_by_id`),
  CONSTRAINT `MissingPerson_last_known_location_id_fkey` FOREIGN KEY (`last_known_location_id`) REFERENCES `location` (`location_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `MissingPerson_reported_by_id_fkey` FOREIGN KEY (`reported_by_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `missingperson`
--

LOCK TABLES `missingperson` WRITE;
/*!40000 ALTER TABLE `missingperson` DISABLE KEYS */;
INSERT INTO `missingperson` VALUES (1,'John Doe',30,'Masculino','Alto, com olhos castanhos e cabelo preto. Vestia uma camisa preta de mangas cumpridas e calca jeans. ',17,'+258 894446515','foto1.png',7,'2024-03-08 03:11:09.129','Ativo'),(2,'Maria Doe',23,'Feminino','Tem +/- 1.60m de altura e muito magra, pele escura. Tem também um brinco no nariz',18,'+258 894446515','foto7.jpg',7,'2024-03-08 08:01:13.201','Ativo'),(3,'Joana Doe',25,'Feminino','Uma senhora muito clara e com carreca. Amarava um lenco preto na cabeca. No dia em que despareceu vestia uma blusa azul com uma capulana com flores vermelhas',19,'+258 894446515','foto10.jpg',1,'2024-03-08 08:46:22.432','Ativo'),(6,'Joana Malema',28,'Feminino','Uma moca muito clara e com carreca. Amarava um lenco preto na cabeca. No dia em que despareceu vestia uma blusa azul com uma capulana com flores vermelhas',23,'+258 894446515','foto8.png',1,'2024-03-18 01:42:40.182','Ativo'),(7,'Carlos Dina',21,'Masculino','Uma moca muito clara e com carreca. Amarava um lenco preto na cabeca. No dia em que despareceu vestia uma blusa azul com uma capulana com flores vermelhas',24,'+258 894446515','foto2.jpg',1,'2024-03-18 01:43:22.581','Ativo'),(8,'Dima Duarte Manobra',71,'Masculino','Uma moca muito clara e com carreca. Amarava um lenco preto na cabeca. No dia em que despareceu vestia uma blusa azul com uma capulana com flores vermelhas',25,'+258 894446515','foto3.jpg',1,'2024-03-18 01:44:23.177','Ativo'),(9,'Felisberto da Costa',85,'Masculino','Uma moca muito clara e com carreca. Amarava um lenco preto na cabeca. No dia em que despareceu vestia uma blusa azul com uma capulana com flores vermelhas',26,'+258 894446515','foto5.png',1,'2024-03-18 01:44:58.333','Ativo'),(10,'Cintia Savele',35,'Feminino','Uma moca muito clara e com carreca. Amarava um lenco preto na cabeca. No dia em que despareceu vestia uma blusa azul com uma capulana com flores vermelhas',27,'+258 894446515','foto9.png',1,'2024-03-18 01:45:40.069','Ativo'),(11,'Sobra Martins',32,'Masculino','Uma moca muito clara e com carreca. Amarava um lenco preto na cabeca. No dia em que despareceu vestia uma blusa azul com uma capulana com flores vermelhas',28,'+258 894446515','foto6.jpg',1,'2024-03-18 01:46:40.318','Ativo');
/*!40000 ALTER TABLE `missingperson` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `province`
--

DROP TABLE IF EXISTS `province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `province` (
  `province_id` int NOT NULL AUTO_INCREMENT,
  `country_id` int NOT NULL,
  `province_name` varchar(191) NOT NULL,
  PRIMARY KEY (`province_id`),
  KEY `Province_country_id_fkey` (`country_id`),
  CONSTRAINT `Province_country_id_fkey` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `province`
--

LOCK TABLES `province` WRITE;
/*!40000 ALTER TABLE `province` DISABLE KEYS */;
INSERT INTO `province` VALUES (1,1,'Maputo'),(2,1,'Gaza'),(3,1,'Inhambane'),(4,1,'Sofala'),(5,1,'Manica'),(6,1,'Zambezia'),(7,1,'Tete'),(8,1,'Niassa'),(9,1,'Cabo Delgado');
/*!40000 ALTER TABLE `province` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_uuid` varchar(191) NOT NULL,
  `full_name` varchar(191) NOT NULL,
  `username` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `type` enum('Individual','Group','Administrator') NOT NULL,
  `organization_name` varchar(191) DEFAULT NULL,
  `organization_type` varchar(191) DEFAULT NULL,
  `organization_contact_info` varchar(191) DEFAULT NULL,
  `contact_address` varchar(191) DEFAULT NULL,
  `contact_phone` varchar(191) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `location_id` int DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `User_user_uuid_key` (`user_uuid`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `User_location_id_fkey` (`location_id`),
  CONSTRAINT `User_location_id_fkey` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'a96886a8-59c2-4dfa-a274-904e43fe23e2','Adjello Garfo','adjellogarfo','adjellogarfo@gmail.com','$2b$10$bPlZhSk.8A0RKw3C0THMEOcvI4zxiqssEiDtke1MI8DmRTPAHY/Aa','Individual',NULL,NULL,NULL,'Bairro do Jardim, Maputo Cidade','849304184',1,'2024-03-02 13:23:34.000',1),(2,'92cc32df-e8c6-4258-94fb-6bf59b2182b2','Mbombo Fraqueza','mbombofraqueza','mbombofraqueza20@gmail.com','$2b$10$8YwVedz69RonvdOLK7ydPeyaAZLsnSsgHBL2yGYcuoEFN5wkSIc.e','Individual',NULL,NULL,NULL,NULL,'849304184',1,'2024-03-07 15:55:31.325',8),(7,'eb07f44e-ed73-412d-8f37-3ccf37f5ef59','Nyusi Francisco','nyusif','nyusif@gmail.com','$2b$10$2JFbWyDt/7Ob5A2oe/i8wuz7TwTcr6.xXBeg7sQcUL9qpr2LQTFEC','Individual',NULL,NULL,NULL,'Bairro Central','864995244',1,'2024-03-07 17:37:49.206',16),(9,'65a0ce21-2df5-46cf-8fa0-abffbc29e9cb','Joao Paulo','jpaulo25','jpaulo25@gmail.com','$2b$10$DJTqoH0tvVB29PrViVfx0Ou/L5MMMEYSRA0F54ZKSZXdm4cKe9ise','Individual',NULL,NULL,NULL,'Mesma morada','865554525',1,'2024-05-01 17:09:31.737',NULL);
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

-- Dump completed on 2024-05-02  4:09:55
