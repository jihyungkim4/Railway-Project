SELECT * from customer;
SELECT * from questions;
SELECT * from employee;
SELECT * from train_schedules_has;
-- SELECT * FROM customer WHERE username='jane' AND password='pass';
SET SQL_SAFE_UPDATES = 0;
USE cs336project;

DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
    question_id INT AUTO_INCREMENT PRIMARY KEY,
    email_address VARCHAR(30),
    body TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (email_address) REFERENCES customer(email_address)
);

DROP TABLE IF EXISTS answers;
DROP TABLE IF EXISTS answers;

CREATE TABLE answers (
    answer_id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT,
    email_address VARCHAR(30),
    body TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (question_id) REFERENCES questions(question_id),
    FOREIGN KEY (email_address) REFERENCES customer(email_address)
);


ALTER TABLE employee
ADD type varchar(30);

-- INSERT INTO customer (email_address, username, first_name, last_name, password)
-- VALUES ("jane@email.com", "jane", "Jane", "Doe", "pass");
INSERT INTO customer (email_address, username, first_name, last_name, password)
VALUES ("jone@email.com", "jone", "Jone", "Doe", "pass");

SELECT


INSERT INTO employee (ssn, username, password, first_name, last_name, type)
VALUES (111111111, 'admin', 'pass', 'Antonio', 'Miranda', 'ADMIN');

INSERT INTO employee (ssn, username, password, first_name, last_name)
VALUES (111111111, 'admin', 'pass', 'Antonio', 'Miranda', 'ADMIN');

INSERT INTO train(train_id, transit_line) 
VALUES(3806, "NEC");

INSERT INTO train(train_id, transit_line) 
VALUES(3808, "NEC");

DELETE FROM train_schedules_has;

SELECT * FROM employee;

INSERT INTO train_schedules_has(transitline, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
VALUES ("NEC", "Trenton", "New York Penn", "Trenton,Hamilton,Princeton Junction,New Brunswick,Edison,Metuchen,Metropark,Rahway,Linden,Elizabeth,North Elizabeth,Newark Penn,Secaucus Junction,New York Penn",
"2024-12-04 03:59:00,2024-12-04 04:13:00,2024-12-04 04:17:00,2024-12-04 04:22:00,2024-12-04 04:26:00,
2024-12-04 04:33:00,2024-12-04 04:37:00,2024-12-04 04:43:00,2024-12-04 04:46:00,2024-12-04 04:56:00
2024-12-04 05:03:00,2024-12-04 05:21:00", '2024-12-04 03:59:00', '2024-12-04 05:21:00', 1.37, 19.25, 3806);

INSERT INTO train_schedules_has(transitline, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
VALUES ("NEC", "Trenton", "New York Penn", "Trenton,Hamilton,Princeton Junction,New Brunswick,Edison,Metuchen,Metropark,Newark Penn,Secaucus Junction,New York Penn",
"2024-12-04 04:30:00,2024-12-04 04:44:00,2024-12-04 04:48:00,2024-12-04 04:53:00,2024-12-04 04:58:00,
2024-12-04 05:19:00,2024-12-04 05:27:00,2024-12-04 05:40:00,", '2024-12-04 04:30:00', '2024-12-04 05:40:00', 1.37, 19.25, 3808);

SELECT * 
FROM train_schedules_has

SELECT * 
FROM customer







old cs336 file:
CREATE DATABASE  IF NOT EXISTS `cs336project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
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

--
-- Table structure for table `customer`
--

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

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `ssn` int NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `password` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservationportfolio_transactedit`
--

DROP TABLE IF EXISTS `reservationportfolio_transactedit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservationportfolio_transactedit` (
  `email_address` varchar(50) NOT NULL,
  PRIMARY KEY (`email_address`),
  CONSTRAINT `reservationportfolio_transactedit_ibfk_1` FOREIGN KEY (`email_address`) REFERENCES `customer` (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservationportfolio_transactedit`
--

LOCK TABLES `reservationportfolio_transactedit` WRITE;
/*!40000 ALTER TABLE `reservationportfolio_transactedit` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservationportfolio_transactedit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations_for_associatedwith_contains`
--

-- DROP TABLE IF EXISTS `reservations_for_associatedwith_contains`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!50503 SET character_set_client = utf8mb4 */;
-- CREATE TABLE `reservations_for_associatedwith_contains` (
--   `reservation_number` int NOT NULL,
--   `total_fare` double DEFAULT NULL,
--   `reservation_date` date NOT NULL,
--   `passenger` varchar(50) DEFAULT NULL,
--   `transitline` varchar(50) DEFAULT NULL,
--   `train` varchar(50) DEFAULT NULL,
--   `origin_station` varchar(50) DEFAULT NULL,
--   `destination_station` varchar(50) DEFAULT NULL,
--   `transit_line` varchar(50) DEFAULT NULL,
--   `train_number` int DEFAULT NULL,
--   `station_id` int DEFAULT NULL,
--   `email_address` varchar(50) DEFAULT NULL,
--   PRIMARY KEY (`reservation_number`,`reservation_date`),
--   KEY `transitline` (`transitline`,`train`),
--   KEY `station_id` (`station_id`),
--   KEY `email_address` (`email_address`),
--   CONSTRAINT `reservations_for_associatedwith_contains_ibfk_1` FOREIGN KEY (`transitline`, `train`) REFERENCES `train_schedules_has` (`transitline`, `train`),
--   CONSTRAINT `reservations_for_associatedwith_contains_ibfk_2` FOREIGN KEY (`station_id`) REFERENCES `stations` (`station_id`),
--   CONSTRAINT `reservations_for_associatedwith_contains_ibfk_3` FOREIGN KEY (`email_address`) REFERENCES `customer` (`email_address`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
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
  `transit_line` varchar(50) DEFAULT NULL,
  `train_number` int DEFAULT NULL,
  `station_id` int DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `is_round_trip` BOOLEAN DEFAULT FALSE, -- For round-trip reservations
  `return_date` DATE DEFAULT NULL,       -- For storing return date
  `status` ENUM('active', 'cancelled') DEFAULT 'active', -- For reservation status
  PRIMARY KEY (`reservation_number`, `reservation_date`),
  KEY `transitline` (`transitline`, `train`),
  KEY `station_id` (`station_id`),
  KEY `email_address` (`email_address`),
  CONSTRAINT `reservations_for_associatedwith_contains_ibfk_1` FOREIGN KEY (`transitline`, `train`) REFERENCES `train_schedules_has` (`transitline`, `train`),
  CONSTRAINT `reservations_for_associatedwith_contains_ibfk_2` FOREIGN KEY (`station_id`) REFERENCES `stations` (`station_id`),
  CONSTRAINT `reservations_for_associatedwith_contains_ibfk_3` FOREIGN KEY (`email_address`) REFERENCES `customer` (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations_for_associatedwith_contains`
--

LOCK TABLES `reservations_for_associatedwith_contains` WRITE;
/*!40000 ALTER TABLE `reservations_for_associatedwith_contains` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservations_for_associatedwith_contains` ENABLE KEYS */;
UNLOCK TABLES;

-- INSERT INTO `reservations_for_associatedwith_contains` (
--     reservation_number, 
--     total_fare, 
--     reservation_date, 
--     passenger, 
--     transitline, 
--     train, 
--     origin_station, 
--     destination_station, 
--     transit_line, 
--     train_number, 
--     station_id, 
--     email_address, 
--     is_round_trip, 
--     return_date, 
--     status
-- ) VALUES
-- (1, 50.00, '2024-12-06', 'John Doe', 'NEC', 'Train A', 'Trenton', 'New York Penn', 'NEC', 12345, 1, 'john.doe@example.com', TRUE, '2024-12-10', 'active'),
-- (2, 25.50, '2024-12-07', 'Jane Smith', 'NAC', 'Train B', 'Princeton Junction', 'Metropark', 'NAC', 12346, 2, 'jane.smith@example.com', FALSE, NULL, 'active'),
-- (3, 60.00, '2024-12-08', 'Michael Brown', 'GHI', 'Train C', 'Hamilton', 'Boston South Station', 'GHI', 12347, 3, 'michael.brown@example.com', TRUE, '2024-12-12', 'cancelled');

-- SELECT * FROM `reservations_for_associatedwith_contains`;

--
-- Table structure for table `stations`
--

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

--
-- Dumping data for table `stations`
--

LOCK TABLES `stations` WRITE;
/*!40000 ALTER TABLE `stations` DISABLE KEYS */;
/*!40000 ALTER TABLE `stations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support`
--

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

--
-- Dumping data for table `support`
--

LOCK TABLES `support` WRITE;
/*!40000 ALTER TABLE `support` DISABLE KEYS */;
/*!40000 ALTER TABLE `support` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train`
--

DROP TABLE IF EXISTS `train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train` (
  `train_id` int NOT NULL,
  `transit_line` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`train_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train`
--

LOCK TABLES `train` WRITE;
/*!40000 ALTER TABLE `train` DISABLE KEYS */;
/*!40000 ALTER TABLE `train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train_schedules_has`
--

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
  PRIMARY KEY (`transitline`, `train`), -- Make `transitline` and `train` the composite primary key
  KEY `train_id` (`train_id`),
--   PRIMARY KEY (`transitline`,`train_id`),
--   KEY `train_id` (`train_id`),
  CONSTRAINT `train_schedules_has_ibfk_1` FOREIGN KEY (`train_id`) REFERENCES `train` (`train_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Table structure for table `customer_searches`
CREATE TABLE `customer_searches` (
    `search_id` INT AUTO_INCREMENT PRIMARY KEY,
    `email_address` VARCHAR(50) NOT NULL, -- FK to customer
    `transitline` VARCHAR(50),           -- FK to train_schedules_has
    `train` VARCHAR(50),                 -- FK to train_schedules_has
    `origin` VARCHAR(50),
    `destination` VARCHAR(50),
    `travel_date` DATE,
    `search_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`email_address`) REFERENCES `customer`(`email_address`),
    FOREIGN KEY (`transitline`, `train`) REFERENCES `train_schedules_has`(`transitline`, `train`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `customer_searches`
LOCK TABLES `customer_searches` WRITE;
/*!40000 ALTER TABLE `customer_searches` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_searches` ENABLE KEYS */;
UNLOCK TABLES;


-- -- INSERT INTO train_schedules_has 
-- -- (transitline, train, origin, destination, stops, departure_time, arrival_time, fare, train_id) 
-- -- VALUES 
-- -- ('Blue Line', 'Train A', 'City1', 'City2', 'Stop1, Stop2', '2024-12-10 08:00:00', '2024-12-10 12:00:00', 50.00, 1);
-- --
-- Dumping data for table `train_schedules_has`
--

LOCK TABLES `train_schedules_has` WRITE;
/*!40000 ALTER TABLE `train_schedules_has` DISABLE KEYS */;
/*!40000 ALTER TABLE `train_schedules_has` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- INSERT INTO train_schedules_has(transitline, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
-- VALUES ("NEC", "Trenton", "New York Penn", "Trenton,Hamilton,Princeton Junction,New Brunswick,Edison,Metuchen,Metropark,Newark Penn,Secaucus Junction,New York Penn",
-- "2024-12-04 04:30:00,2024-12-04 04:44:00,2024-12-04 04:48:00,2024-12-04 04:53:00,2024-12-04 04:58:00,
-- 2024-12-04 05:19:00,2024-12-04 05:27:00,2024-12-04 05:40:00,", '2024-12-04 04:30:00', '2024-12-04 05:40:00', 1.37, 19.25, 3808);
INSERT INTO train_schedules_has(transitline, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
VALUES ("NAC", "Princeton Junction", "Metropark", "Princeton Junction,New Brunswick,Edison,Metropark",
"2024-12-04 10:00:00,2024-12-04 10:20:00,2024-12-04 10:30:00,2024-12-04 10:50:00", 
'2024-12-04 10:00:00', '2024-12-04 10:50:00', 0.83, 25.50, 3810);

INSERT INTO train_schedules_has(transitline, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
VALUES ("NAB", "Trenton", "Boston South Station", "Trenton,Hamilton,Newark Penn,Providence,Boston South Station",
"2024-12-04 06:00:00,2024-12-04 06:30:00,2024-12-04 08:00:00,2024-12-04 11:00:00,2024-12-04 12:00:00", 
'2024-12-04 06:00:00', '2024-12-04 12:00:00', 6.00, 50.00, 3811);

INSERT INTO train_schedules_has(transitline, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
VALUES ("NBC", "Hamilton", "New York Penn", "Hamilton,Princeton Junction,Edison,Metropark,Newark Penn,New York Penn",
"2024-12-04 12:30:00,2024-12-04 12:50:00,2024-12-04 13:00:00,2024-12-04 13:20:00,2024-12-04 13:40:00,2024-12-04 14:00:00", 
'2024-12-04 12:30:00', '2024-12-04 14:00:00', 1.50, 15.00, 3812);

INSERT INTO train_schedules_has(transitline, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
VALUES ("NAC", "Edison", "Newark Penn", "Edison,Metropark,Newark Penn",
"2024-12-04 23:30:00,2024-12-04 23:45:00,2024-12-05 00:00:00", 
'2024-12-04 23:30:00', '2024-12-05 00:00:00', 0.50, 10.00, 3813);

INSERT INTO train_schedules_has(transitline, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
VALUES ("ABC", "Newark Penn", "New York Penn", "Newark Penn,Secaucus Junction,New York Penn",
"2024-12-04 07:00:00,2024-12-04 07:10:00,2024-12-04 07:25:00", 
'2024-12-04 07:00:00', '2024-12-04 07:25:00', 0.42, 8.00, 3814);

INSERT INTO train_schedules_has(transitline, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
VALUES ("DEF", "Edison", "New York Penn", "Edison,Metropark,Newark Penn,Secaucus Junction,New York Penn",
"2024-12-04 18:30:00,2024-12-04 18:45:00,2024-12-04 19:15:00,2024-12-04 19:30:00,2024-12-04 19:50:00", 
'2024-12-04 18:30:00', '2024-12-04 19:50:00', 1.20, 18.00, 3815);

INSERT INTO train_schedules_has(transitline, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
VALUES ("GHI", "Hamilton", "Boston South Station", "Hamilton,Newark Penn,Providence,Boston South Station",
"2024-12-04 14:00:00,2024-12-04 14:30:00,2024-12-04 17:00:00,2024-12-04 18:30:00", 
'2024-12-04 14:00:00', '2024-12-04 18:30:00', 4.50, 60.00, 3816);

INSERT INTO train_schedules_has(transitline, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
VALUES ("JKL", "Princeton Junction", "Metropark", "Princeton Junction,New Brunswick,Edison,Metropark",
"2024-12-04 13:00:00,2024-12-04 13:20:00,2024-12-04 13:30:00,2024-12-04 13:50:00", 
'2024-12-04 13:00:00', '2024-12-04 13:50:00', 0.83, 22.50, 3817);

INSERT INTO train_schedules_has(transitline, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
VALUES ("XYZ", "Edison", "New York Penn", "Edison,Metropark,Newark Penn,New York Penn",
"2024-12-04 18:00:00,2024-12-04 18:15:00,2024-12-04 18:45:00,2024-12-04 19:00:00", 
'2024-12-04 18:00:00', '2024-12-04 19:00:00', 1.0, 20.00, 3818);


SELECT * 
FROM train_schedules_has

Select *
From customer


-- Dump completed on 2024-11-15 16:05:19

INSERT INTO employee (ssn, username, first_name, last_name, password, role)
SELECT '9999', 'admin', 'Admin', 'User', 'securepassword', 'admin'
WHERE NOT EXISTS (
    SELECT 1
    FROM employee
    WHERE ssn = '9999'
);


Select *
From reservations_for_associatedwith_contains

INSERT INTO employee (ssn, username, first_name, last_name, password, role)
SELECT '8888', 'cust_rep', 'Customer', 'Rep', 'securepassword', 'customer_rep'
WHERE NOT EXISTS (
    SELECT 1
    FROM employee
    WHERE ssn = '8888'
);

Select *
From customer_searches
INSERT INTO train_schedules_has(transitline, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
VALUES ("NAC", "Princeton Junction", "Metropark", "Princeton Junction,New Brunswick,Edison,Metropark",
"2024-12-04 10:00:00,2024-12-04 10:20:00,2024-12-04 10:30:00,2024-12-04 10:50:00", 
'2024-12-04 10:00:00', '2024-12-04 10:50:00', 0.83, 25.50, 3810);

INSERT INTO train_schedules_has(transitline, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
VALUES ("NAB", "Trenton", "Boston South Station", "Trenton,Hamilton,Newark Penn,Providence,Boston South Station",
"2024-12-04 06:00:00,2024-12-04 06:30:00,2024-12-04 08:00:00,2024-12-04 11:00:00,2024-12-04 12:00:00", 
'2024-12-04 06:00:00', '2024-12-04 12:00:00', 6.00, 50.00, 3811);

INSERT INTO train_schedules_has(transitline, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
VALUES ("NBC", "Hamilton", "New York Penn", "Hamilton,Princeton Junction,Edison,Metropark,Newark Penn,New York Penn",
"2024-12-04 12:30:00,2024-12-04 12:50:00,2024-12-04 13:00:00,2024-12-04 13:20:00,2024-12-04 13:40:00,2024-12-04 14:00:00", 
'2024-12-04 12:30:00', '2024-12-04 14:00:00', 1.50, 15.00, 3812);

#INSERT INTO train_schedules_has(transitline, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
#VALUES ("NAC", "Edison", "Newark Penn", "Edison,Metropark,Newark Penn",
#"2024-12-04 23:30:00,2024-12-04 23:45:00,2024-12-05 00:00:00", 
#'2024-12-04 23:30:00', '2024-12-05 00:00:00', 0.50, 10.00, 3813);


INSERT INTO employee (ssn, username, first_name, last_name, password, role)
SELECT '9999', 'admin', 'Admin', 'User', 'securepassword', 'admin'
WHERE NOT EXISTS (
    SELECT 1
    FROM employee
    WHERE ssn = '9999'
);





INSERT INTO customer (email_address, username, first_name, last_name, password)
VALUES ('johndoe@example.com', 'testuser', 'John', 'Doe', 'password123'),
('janesmith@example.com', 'testuser', 'Jane', 'Smith', 'password123');


INSERT INTO train (train_id, transit_line) VALUES
(101, 'Express 1'),
(102, 'Express 2');

INSERT INTO train_schedules_has (transitline, train, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
VALUES 
('NEC', 'Train A', 'Trenton', 'New York Penn', 'Trenton,Hamilton,Newark Penn,New York Penn', 
 '2024-12-04 06:00:00,2024-12-04 06:30:00,2024-12-04 07:00:00,2024-12-04 07:30:00', 
 '2024-12-04 06:00:00', '2024-12-04 07:30:00', 1.5, 50.00, 101),
('NAC', 'Train B', 'Princeton Junction', 'Metropark', 'Princeton Junction,New Brunswick,Edison,Metropark', 
 '2024-12-05 09:00:00,2024-12-05 09:20:00,2024-12-05 09:40:00,2024-12-05 10:00:00', 
 '2024-12-05 09:00:00', '2024-12-05 10:00:00', 1.0, 25.50, 102);
 
INSERT INTO reservations_for_associatedwith_contains (reservation_number, total_fare, reservation_date, passenger, transitline, train, origin_station, destination_station, email_address)
VALUES 
(1, 50.00, '2024-12-04', 'John Doe', 'NEC', 'Train A', 'Trenton', 'New York Penn', 'johndoe@example.com'),
(2, 25.50, '2024-12-05', 'Jane Smith', 'NAC', 'Train B', 'Princeton Junction', 'Metropark', 'janesmith@example.com');

Select *
From reservations_for_associatedwith_contains
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
From reservations_associated_with_contains

Select * 
From customer



