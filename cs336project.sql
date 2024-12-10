-- Database Initialization
CREATE DATABASE IF NOT EXISTS `cs336project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cs336project`;

-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: cs336project
-- ------------------------------------------------------
-- Server version	8.0.40

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

-- Table structure for table `customer`
DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `email_address` varchar(50) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;



-- Dumping data for table `customer`
LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

-- Table structure for table `employee`
DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `ssn` int NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `password` varchar(15) DEFAULT NULL,
  `role` varchar(20) DEFAULT 'employee',
  PRIMARY KEY (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Dumping data for table `employee`
LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

-- Table structure for table `reservationportfolio_transactedit`
DROP TABLE IF EXISTS `reservationportfolio_transactedit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservationportfolio_transactedit` (
  `email_address` varchar(50) NOT NULL,
  PRIMARY KEY (`email_address`),
  CONSTRAINT `reservationportfolio_transactedit_ibfk_1` FOREIGN KEY (`email_address`) REFERENCES `customer` (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Dumping data for table `reservationportfolio_transactedit`
LOCK TABLES `reservationportfolio_transactedit` WRITE;
/*!40000 ALTER TABLE `reservationportfolio_transactedit` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservationportfolio_transactedit` ENABLE KEYS */;
UNLOCK TABLES;

-- Table structure for table `reservations_for_associatedwith_contains`
DROP TABLE IF EXISTS `reservations_for_associatedwith_contains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations_for_associatedwith_contains` (
  `reservation_number` int NOT NULL,
  `total_fare` double DEFAULT NULL,
  `reservation_date` date NOT NULL,
  `passenger` varchar(50) DEFAULT NULL,
  `transitline` varchar(50) DEFAULT NULL,
  `train` varchar(50) DEFAULT NULL,
  `origin_station` varchar(50) DEFAULT NULL,
  `destination_station` varchar(50) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `is_round_trip` BOOLEAN DEFAULT FALSE,
  `return_date` DATE DEFAULT NULL,
  `status` ENUM('active', 'cancelled') DEFAULT 'active',
  PRIMARY KEY (`reservation_number`, `reservation_date`),
  CONSTRAINT `reservations_for_associatedwith_contains_ibfk_1` FOREIGN KEY (`email_address`) REFERENCES `customer` (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

Select *
From reservations_for_associatedwith_contains
-- Dumping data for table `reservations_for_associatedwith_contains`
LOCK TABLES `reservations_for_associatedwith_contains` WRITE;
/*!40000 ALTER TABLE `reservations_for_associatedwith_contains` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservations_for_associatedwith_contains` ENABLE KEYS */;
UNLOCK TABLES;

-- Table structure for table `stations`
DROP TABLE IF EXISTS `stations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stations` (
  `station_id` int NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Dumping data for table `stations`
LOCK TABLES `stations` WRITE;
/*!40000 ALTER TABLE `stations` DISABLE KEYS */;
/*!40000 ALTER TABLE `stations` ENABLE KEYS */;
UNLOCK TABLES;

-- Table structure for table `support`
DROP TABLE IF EXISTS `support`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support` (
  `ssn` int NOT NULL,
  `email_address` varchar(50) NOT NULL,
  PRIMARY KEY (`ssn`,`email_address`),
  KEY `email_address` (`email_address`),
  CONSTRAINT `support_ibfk_1` FOREIGN KEY (`ssn`) REFERENCES `employee` (`ssn`),
  CONSTRAINT `support_ibfk_2` FOREIGN KEY (`email_address`) REFERENCES `customer` (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Dumping data for table `support`
LOCK TABLES `support` WRITE;
/*!40000 ALTER TABLE `support` DISABLE KEYS */;
/*!40000 ALTER TABLE `support` ENABLE KEYS */;
UNLOCK TABLES;

-- Table structure for table `train`
DROP TABLE IF EXISTS `train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train` (
  `train_id` int NOT NULL,
  `transit_line` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`train_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Dumping data for table `train`
LOCK TABLES `train` WRITE;
/*!40000 ALTER TABLE `train` DISABLE KEYS */;
/*!40000 ALTER TABLE `train` ENABLE KEYS */;
UNLOCK TABLES;

-- Table structure for table `train_schedules_has`
DROP TABLE IF EXISTS `train_schedules_has`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train_schedules_has` (
  `transitline` varchar(50) NOT NULL,
  `train` varchar(50) NOT NULL,
  `origin` varchar(50) DEFAULT NULL,
  `destination` varchar(50) DEFAULT NULL,
  `stops` varchar(500) DEFAULT NULL,
  `stop_times` varchar(500) DEFAULT NULL,
  `departure_time` datetime DEFAULT NULL,
  `arrival_time` datetime DEFAULT NULL,
  `travel_time` double DEFAULT NULL,
  `fare` double DEFAULT NULL,
  `train_id` int NOT NULL,
  PRIMARY KEY (`transitline`, `train`),
  CONSTRAINT `train_schedules_has_ibfk_1` FOREIGN KEY (`train_id`) REFERENCES `train` (`train_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

Select *
From train_schedules_has
-- Table structure for table `customer_searches`
DROP TABLE IF EXISTS `customer_searches`;
CREATE TABLE `customer_searches` (
    `search_id` INT AUTO_INCREMENT PRIMARY KEY,
    `email_address` VARCHAR(50) NOT NULL,
    `transitline` VARCHAR(50),
    `train` VARCHAR(50),
    `origin` VARCHAR(50),
    `destination` VARCHAR(50),
    `travel_date` DATE,
    `search_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`email_address`) REFERENCES `customer`(`email_address`),
    FOREIGN KEY (`transitline`, `train`) REFERENCES `train_schedules_has`(`transitline`, `train`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Select * 
From customer_searches
-- Dumping data for table `customer_searches`
LOCK TABLES `customer_searches` WRITE;
/*!40000 ALTER TABLE `customer_searches` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_searches` ENABLE KEYS */;
UNLOCK TABLES;

-- Dump completed on 2024-12-09
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

Select * 
From train_schedules_has

-- Insert data for Train A
INSERT INTO train_schedules_has (
    transitline, 
    train, 
    origin, 
    destination, 
    stops, 
    stop_times, 
    departure_time, 
    arrival_time, 
    travel_time, 
    fare, 
    train_id
) VALUES (
    'Blue Line', 
    'Train A', 
    'Station A', 
    'Station Z', 
    'Station B, Station C, Station D', 
    '08:30:00, 09:00:00, 09:30:00', 
    '2024-12-10 08:00:00', 
    '2024-12-10 10:00:00', 
    120, 
    25.00, 
    1
);

-- Insert data for Train B
INSERT INTO train_schedules_has (
    transitline, 
    train, 
    origin, 
    destination, 
    stops, 
    stop_times, 
    departure_time, 
    arrival_time, 
    travel_time, 
    fare, 
    train_id
) VALUES (
    'Red Line', 
    'Train B', 
    'Station X', 
    'Station Y', 
    'Station M, Station N, Station O', 
    '14:00:00, 14:30:00, 15:00:00', 
    '2024-12-10 13:30:00', 
    '2024-12-10 16:00:00', 
    150, 
    30.00, 
    2
);
INSERT INTO train_schedules_has (
    transitline, 
    train, 
    origin, 
    destination, 
    stops, 
    stop_times, 
    departure_time, 
    arrival_time, 
    travel_time, 
    fare, 
    train_id
) VALUES (
    'Newarkpress', 
    'Train C', 
    'Newark Penn', 
    'Trenton', 
    'Station A, Station C, Station O', 
    '14:00:00, 14:30:00, 15:00:00', 
    '2024-12-04 13:30:00', 
    '2024-12-04 16:00:00', 
    150, 
    30.00, 
    2
);

Select * 
From reservations_associated_with



