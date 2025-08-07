CREATE DATABASE  IF NOT EXISTS `cs336project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cs336project`;

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
CREATE TABLE `customer` (
  `email_address` varchar(50) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for table `employee`
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `ssn` int NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `password` varchar(15) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for table `stations`
DROP TABLE IF EXISTS `stations`;
CREATE TABLE `stations` (
  `station_id` int NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for table `train`
DROP TABLE IF EXISTS `train`;
CREATE TABLE `train` (
  `train_id` int NOT NULL,
  `transit_line` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`train_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for table `train_schedules_has`
DROP TABLE IF EXISTS `train_schedules_has`;
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
  KEY `train_id` (`train_id`),
  CONSTRAINT `train_schedules_has_ibfk_1` FOREIGN KEY (`train_id`) REFERENCES `train` (`train_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for table `reservations_for_associatedwith_contains`
DROP TABLE IF EXISTS `reservations_for_associatedwith_contains`;
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
  `status` varchar(20) DEFAULT 'active',
  `is_round_trip` boolean DEFAULT FALSE,
  `return_date` date DEFAULT NULL,
  PRIMARY KEY (`reservation_number`,`reservation_date`),
  KEY `transitline` (`transitline`,`train`),
  KEY `station_id` (`station_id`),
  KEY `email_address` (`email_address`),
  CONSTRAINT `reservations_for_associatedwith_contains_ibfk_1` FOREIGN KEY (`transitline`, `train`) REFERENCES `train_schedules_has` (`transitline`, `train`),
  CONSTRAINT `reservations_for_associatedwith_contains_ibfk_2` FOREIGN KEY (`station_id`) REFERENCES `stations` (`station_id`),
  CONSTRAINT `reservations_for_associatedwith_contains_ibfk_3` FOREIGN KEY (`email_address`) REFERENCES `customer` (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for table `reservationportfolio_transactedit`
DROP TABLE IF EXISTS `reservationportfolio_transactedit`;
CREATE TABLE `reservationportfolio_transactedit` (
  `email_address` varchar(50) NOT NULL,
  PRIMARY KEY (`email_address`),
  CONSTRAINT `reservationportfolio_transactedit_ibfk_1` FOREIGN KEY (`email_address`) REFERENCES `customer` (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for table `support`
DROP TABLE IF EXISTS `support`;
CREATE TABLE `support` (
  `ssn` int NOT NULL,
  `email_address` varchar(50) NOT NULL,
  PRIMARY KEY (`ssn`,`email_address`),
  KEY `email_address` (`email_address`),
  CONSTRAINT `support_ibfk_1` FOREIGN KEY (`ssn`) REFERENCES `employee` (`ssn`),
  CONSTRAINT `support_ibfk_2` FOREIGN KEY (`email_address`) REFERENCES `customer` (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

-- Insert sample data
-- First insert customers
INSERT INTO customer (email_address, username, first_name, last_name, password)
VALUES 
('johndoe@example.com', 'johndoe', 'John', 'Doe', 'password123'),
('janesmith@example.com', 'janesmith', 'Jane', 'Smith', 'password123');

-- Insert employees
INSERT INTO employee (ssn, username, first_name, last_name, password, role)
VALUES (9999, 'admin', 'Admin', 'User', 'securepassword', 'admin');

-- Insert trains first (required for foreign key)
INSERT INTO train (train_id, transit_line) VALUES
(3808, 'NEC'),
(3810, 'NAC'), 
(3811, 'NAB'),
(3812, 'NBC'),
(101, 'NEC'),
(102, 'NAC');

-- Now insert train schedules with BOTH transitline AND train columns
INSERT INTO train_schedules_has(transitline, train, origin, destination, stops, stop_times, departure_time, arrival_time, travel_time, fare, train_id)
VALUES 
("NAC", "Train_3810", "Princeton Junction", "Metropark", "Princeton Junction,New Brunswick,Edison,Metropark",
"2024-12-04 10:00:00,2024-12-04 10:20:00,2024-12-04 10:30:00,2024-12-04 10:50:00", 
'2024-12-04 10:00:00', '2024-12-04 10:50:00', 0.83, 25.50, 3810),

("NAB", "Train_3811", "Trenton", "Boston South Station", "Trenton,Hamilton,Newark Penn,Providence,Boston South Station",
"2024-12-04 06:00:00,2024-12-04 06:30:00,2024-12-04 08:00:00,2024-12-04 11:00:00,2024-12-04 12:00:00", 
'2024-12-04 06:00:00', '2024-12-04 12:00:00', 6.00, 50.00, 3811),

("NBC", "Train_3812", "Hamilton", "New York Penn", "Hamilton,Princeton Junction,Edison,Metropark,Newark Penn,New York Penn",
"2024-12-04 12:30:00,2024-12-04 12:50:00,2024-12-04 13:00:00,2024-12-04 13:20:00,2024-12-04 13:40:00,2024-12-04 14:00:00", 
'2024-12-04 12:30:00', '2024-12-04 14:00:00', 1.50, 15.00, 3812),

("NEC", "Train_A", "Trenton", "New York Penn", "Trenton,Hamilton,Newark Penn,New York Penn", 
"2024-12-04 06:00:00,2024-12-04 06:30:00,2024-12-04 07:00:00,2024-12-04 07:30:00", 
'2024-12-04 06:00:00', '2024-12-04 07:30:00', 1.5, 50.00, 101),

("NAC", "Train_B", "Princeton Junction", "Metropark", "Princeton Junction,New Brunswick,Edison,Metropark", 
"2024-12-05 09:00:00,2024-12-05 09:20:00,2024-12-05 09:40:00,2024-12-05 10:00:00", 
'2024-12-05 09:00:00', '2024-12-05 10:00:00', 1.0, 25.50, 102);

-- Insert reservations
INSERT INTO reservations_for_associatedwith_contains (reservation_number, total_fare, reservation_date, passenger, transitline, train, origin_station, destination_station, email_address, status)
VALUES 
(1, 50.00, '2024-12-04', 'John Doe', 'NEC', 'Train_A', 'Trenton', 'New York Penn', 'johndoe@example.com', 'active'),
(2, 25.50, '2024-12-05', 'Jane Smith', 'NAC', 'Train_B', 'Princeton Junction', 'Metropark', 'janesmith@example.com', 'active');

-- Table structure for table `questions`
DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
  `question_id` int NOT NULL AUTO_INCREMENT,
  `email_address` varchar(50) NOT NULL,
  `body` text NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`question_id`),
  FOREIGN KEY (`email_address`) REFERENCES `customer` (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for table `answers`
DROP TABLE IF EXISTS `answers`;
CREATE TABLE `answers` (
  `answer_id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `email_address` varchar(50) NOT NULL,
  `body` text NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`answer_id`),
  FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Insert sample questions
INSERT INTO questions (email_address, body) VALUES
('johndoe@example.com', 'How do I cancel my reservation?'),
('janesmith@example.com', 'What are the baggage allowances for train travel?'),
('johndoe@example.com', 'Can I change my departure time after booking?');

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
