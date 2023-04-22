CREATE DATABASE  IF NOT EXISTS `university_gp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `university_gp`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: university_gp
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `advisor`
--

DROP TABLE IF EXISTS `advisor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advisor` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `staff_name` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `phone_number` int DEFAULT NULL,
  `staff_email_id` varchar(50) DEFAULT NULL,
  `role` varchar(50) DEFAULT 'advisor',
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `advisor_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advisor`
--

LOCK TABLES `advisor` WRITE;
/*!40000 ALTER TABLE `advisor` DISABLE KEYS */;
INSERT INTO `advisor` VALUES (1,'Alex Johnson','1982-07-12',12345628,'ajohnson@northeastern.edu','advisor',1),(2,'Brenda Lee','1985-01-30',85720976,'blee@northeastern.edu','advisor',2),(3,'Charlie Brown','1979-09-22',85720875,'cbrown@northeastern.edu','advisor',3),(4,'David Chen','1988-04-13',85720132,'dchen@northeastern.edu','advisor',4),(5,'Emily Davis','1992-11-27',85720742,'edavis@northeastern.edu','advisor',5),(6,'Frank Taylor','1980-06-19',85720258,'ftaylor@northeastern.edu','advisor',6),(7,'Grace Hernandez','1975-03-14',85720345,'ghernandez@northeastern.edu','advisor',7),(8,'Henry Wilson','1983-08-08',85720567,'hwilson@northeastern.edu','advisor',8),(9,'Isabella Johnson','1990-05-05',85721145,'ijohnson@northeastern.edu','advisor',9),(10,'Jake Smith','1977-12-28',85720987,'jsmith@northeastern.edu','advisor',10),(11,'Olivia Baker','1992-05-07',12345678,'olivia.baker@northeastern.edu','advisor',1),(12,'Ethan Cooper','1987-08-21',23456789,'ethan.cooper@northeastern.edu','advisor',2),(13,'Avery Davis','1980-11-12',34567890,'avery.davis@northeastern.edu','advisor',3),(14,'Isabella Garcia','1995-02-16',45678901,'isabella.garcia@northeastern.edu','advisor',4),(15,'Jackson Kim','1983-06-09',56789012,'jackson.kim@northeastern.edu','advisor',5),(16,'Sophie Lee','1990-12-22',67890123,'sophie.lee@northeastern.edu','advisor',6),(17,'Caleb Miller','1977-03-03',78901234,'caleb.miller@northeastern.edu','advisor',7),(18,'Natalie Nguyen','1993-09-18',89012345,'natalie.nguyen@northeastern.edu','advisor',8),(19,'Levi Patel','1988-04-30',90123456,'levi.patel@northeastern.edu','advisor',9),(20,'Aria Smith','1981-01-24',12345678,'aria.smith@northeastern.edu','advisor',10);
/*!40000 ALTER TABLE `advisor` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `add_advisor_user` AFTER INSERT ON `advisor` FOR EACH ROW BEGIN
    INSERT INTO user (user_id, username, password, role)
    VALUES (NEW.staff_id, NEW.staff_email_id, 'password123', 'advisor');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `appointment_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `advisor_id` int NOT NULL,
  `slot_id` int NOT NULL,
  `app_status` int DEFAULT '1',
  PRIMARY KEY (`appointment_id`),
  KEY `student_id` (`student_id`),
  KEY `advisor_id` (`advisor_id`),
  KEY `slot_id` (`slot_id`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`advisor_id`) REFERENCES `advisor` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `appointments_ibfk_3` FOREIGN KEY (`slot_id`) REFERENCES `slots` (`slot_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (1,101,1,2,1);
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `building` (
  `building_id` int NOT NULL AUTO_INCREMENT,
  `building_name` varchar(50) DEFAULT NULL,
  `building_address` varchar(200) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`building_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `building`
--

LOCK TABLES `building` WRITE;
/*!40000 ALTER TABLE `building` DISABLE KEYS */;
INSERT INTO `building` VALUES (1,'Forsyth Building','145 Forsyth St, Boston, MA 02115','617-373-2000'),(2,'WVH Building','360 Huntington Ave, Boston, MA 02115','617-373-2000'),(3,'Dockser Hall','65 Forsyth St, Boston, MA 02115','617-373-2000'),(4,'Hayden Hall','360 Huntington Ave, Boston, MA 02115','617-373-2000'),(5,'Richards Hall','25 Leon St, Boston, MA 02115','617-373-2000'),(6,'Robinson Hall','301 Huntington Ave, Boston, MA 02115','617-373-2000'),(7,'Kariotis Hall','11 Speare Pl, Boston, MA 02115','617-373-2000'),(8,'International Village','1155 Tremont St, Boston, MA 02120','617-373-2000'),(9,'Rubenstein Hall','68 Forsyth St, Boston, MA 02115','617-373-2000'),(10,'Lake Hall','360 Huntington Ave, Boston, MA 02115','617-373-2000'),(11,'Stetson West','10 Leon St, Boston, MA 02115','617-373-2000');
/*!40000 ALTER TABLE `building` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom`
--

DROP TABLE IF EXISTS `classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom` (
  `room_id` int NOT NULL AUTO_INCREMENT,
  `room_number` varchar(20) DEFAULT NULL,
  `room_capacity` int DEFAULT NULL,
  `building_id` int DEFAULT NULL,
  PRIMARY KEY (`room_id`),
  KEY `building_id` (`building_id`),
  CONSTRAINT `classroom_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */;
INSERT INTO `classroom` VALUES (1,'114',50,1),(2,'304',30,2),(3,'102',25,3),(4,'203',40,4),(5,'205',35,5),(6,'307',20,6),(7,'301',50,7),(8,'402',40,8),(9,'212',30,9),(10,'306',20,10),(11,'114A',15,1),(12,'312',25,2),(13,'101',20,3),(14,'201',35,4),(15,'303',30,5),(16,'305',25,6),(17,'302',45,7),(18,'404',35,8),(19,'214',15,9),(20,'308',20,10),(21,'115',50,1),(22,'305A',30,2),(23,'103',25,3),(24,'202',40,4),(25,'204',35,5),(26,'309',20,6);
/*!40000 ALTER TABLE `classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `club`
--

DROP TABLE IF EXISTS `club`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `club` (
  `club_id` int NOT NULL AUTO_INCREMENT,
  `club_name` varchar(50) DEFAULT NULL,
  `club_description` varchar(200) DEFAULT NULL,
  `club_email_address` varchar(50) DEFAULT NULL,
  `club_phone_number` varchar(20) DEFAULT NULL,
  `club_head` int DEFAULT NULL,
  PRIMARY KEY (`club_id`),
  KEY `club_head` (`club_head`),
  CONSTRAINT `club_ibfk_1` FOREIGN KEY (`club_head`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club`
--

LOCK TABLES `club` WRITE;
/*!40000 ALTER TABLE `club` DISABLE KEYS */;
INSERT INTO `club` VALUES (1,'Debate Club','A club for those passionate about debating','debateclub@neu.edu','123-456-7890',1020),(2,'Music Club','A club for those who love music','musicclub@neu.edu','234-567-8901',1032),(3,'Dance Club','A club for those who love dancing','danceclub@neu.edu','345-678-9012',1025),(4,'Photography Club','A club for those who love photography','photoclub@neu.edu','456-789-0123',1019),(5,'Art Club','A club for those who love art','artclub@neu.edu','567-890-1234',1035);
/*!40000 ALTER TABLE `club` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `course_id` int NOT NULL AUTO_INCREMENT,
  `course_name` varchar(255) DEFAULT NULL,
  `course_description` varchar(255) DEFAULT NULL,
  `course_credits` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'Introduction to Computer Science','Introduction to the fundamentals of computer science.',4,1),(2,'Data Structures and Algorithms','Study of basic algorithms and their implementation.',4,1),(3,'Discrete Mathematics','Introduction to mathematical reasoning and discrete structures.',4,1),(4,'Introduction to Biology','Overview of the major concepts and principles of biology.',4,2),(5,'Cellular and Molecular Biology','Study of cellular and molecular mechanisms of life.',4,2),(6,'Genetics and Evolution','Introduction to the principles of genetics and evolution.',4,2),(7,'General Chemistry','Introduction to the fundamental principles of chemistry.',4,3),(8,'Organic Chemistry','Introduction to the principles of organic chemistry.',4,3),(9,'Physical Chemistry','Introduction to the principles of physical chemistry.',4,3),(10,'Linear Algebra','Study of linear equations and matrices.',4,4),(11,'Real Analysis','Introduction to the fundamental concepts of analysis.',4,4),(12,'Probability and Statistics','Introduction to the concepts of probability and statistics.',4,4),(13,'Classical Mechanics','Introduction to the principles of classical mechanics.',4,5),(14,'Electromagnetism','Introduction to the principles of electromagnetism.',4,5),(15,'Quantum Mechanics','Introduction to the principles of quantum mechanics.',4,5),(16,'Introduction to Psychology','Overview of the major concepts and principles of psychology.',4,6),(17,'Social Psychology','Introduction to the principles of social psychology.',4,6),(18,'Abnormal Psychology','Introduction to the principles of abnormal psychology.',4,6),(19,'Introduction to English Literature','Overview of the major works of English literature.',4,7),(20,'American Literature','Introduction to the major works of American literature.',4,7),(21,'Creative Writing','Introduction to the principles of creative writing.',4,7),(22,'Introduction to World History','Overview of the major events and themes of world history.',4,8),(23,'American History','Introduction to the major events and themes of American history.',4,8),(24,'History of Science and Technology','Overview of the major scientific and technological developments of history.',4,8),(25,'Introduction to Political Science','Overview of the major concepts and principles of political science.',4,9),(26,'International Relations','Introduction to the principles of international relations.',4,9),(27,'Comparative Politics','Introduction to the principles of comparative politics.',4,9),(28,'Introduction to Business','Introduction to the major concepts and principles of business.',4,10),(29,'Marketing','Introduction to the principles of marketing.',4,10),(30,'Financial Accounting','Introduction to the principles of financial accounting.',4,10),(31,'abcdefg','abcdefgkffhsdvhsflsdjvl\'jfad',4,1),(32,'Cybersec','Intro to CY',4,1);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `department_name` varchar(50) DEFAULT NULL,
  `department_budget` decimal(10,2) DEFAULT NULL,
  `department_head` varchar(50) DEFAULT NULL,
  `building_id` int DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  KEY `building_id` (`building_id`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Computer Science',1500000.00,'Rebecca Davis ',1),(2,'Biology',2000000.00,'Jordan Ortiz ',2),(3,'Chemistry',1800000.00,'Vanessa Brown ',3),(4,'Mathematics',1600000.00,'Megan Cox',4),(5,'Physics',1900000.00,'Aria Gonzales ',5),(6,'Psychology',1700000.00,'Samantha Flores ',6),(7,'English',1400000.00,'Dylan Kim',7),(8,'History',1200000.00,'Emma Ramirez',8),(9,'Political Science',1300000.00,'Samantha Lee ',9),(10,'Finance',2500000.00,'Isaac Cooper',10);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(50) DEFAULT NULL,
  `event_description` varchar(200) DEFAULT NULL,
  `event_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `classroom_id` int DEFAULT NULL,
  `club_id` int DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `classroom_id` (`classroom_id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`classroom_id`) REFERENCES `classroom` (`room_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `event_ibfk_2` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'Orientation Day','Welcome event for new students','2023-08-20','09:00:00','13:00:00',15,1),(2,'Career Fair','Job and internship opportunities for students','2023-10-05','10:00:00','14:00:00',25,2),(3,'Halloween Party','Costume party for students','2023-10-31','20:00:00','23:00:00',7,3),(4,'Thanksgiving Dinner','Traditional Thanksgiving dinner for students','2023-11-23','18:00:00','21:00:00',11,4),(5,'Christmas Concert','Music concert for students and staff','2023-12-15','19:00:00','22:00:00',19,5),(6,'Example Event','This is an example event.','2023-04-20','13:00:00','15:00:00',15,1),(7,'Adobe Workshop','A workshop to improve editing skills','2023-11-13','11:00:00','15:00:00',20,4),(9,'Photoshop Workshop','A workshop to improve photoshop skills','2023-04-19','16:00:00','17:00:00',13,4);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participates`
--

DROP TABLE IF EXISTS `participates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `participates` (
  `club_id` int NOT NULL,
  `student_id` int NOT NULL,
  PRIMARY KEY (`club_id`,`student_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `participates_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `participates_ibfk_2` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participates`
--

LOCK TABLES `participates` WRITE;
/*!40000 ALTER TABLE `participates` DISABLE KEYS */;
INSERT INTO `participates` VALUES (4,101),(4,1019),(1,1020),(3,1025),(2,1032),(5,1035);
/*!40000 ALTER TABLE `participates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professor`
--

DROP TABLE IF EXISTS `professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professor` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `staff_name` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `tenure_status` enum('TENURED','TENURE_TRACK','NON_TENURE_TRACK') DEFAULT NULL,
  `phone_number` int DEFAULT NULL,
  `staff_email_id` varchar(50) DEFAULT NULL,
  `role` varchar(50) DEFAULT 'professor',
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `professor_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor`
--

LOCK TABLES `professor` WRITE;
/*!40000 ALTER TABLE `professor` DISABLE KEYS */;
INSERT INTO `professor` VALUES (21,'Rebecca Davis ','1975-08-02','TENURE_TRACK',12345678,'rebecca.davis@neu.edu','dept_head',1),(22,'Jordan Ortiz','1978-06-14','TENURED',23456789,'jordan.ortiz@neu.edu','dept_head',2),(23,'Shannon Peterson','1982-11-21','NON_TENURE_TRACK',34567890,'shannon.peterson@neu.edu','professor',3),(24,'Megan Cox','1979-02-16','TENURED',45678901,'megan.cox@neu.edu','dept_head',4),(25,'Benjamin Lee','1985-07-19','TENURE_TRACK',56789012,'benjamin.lee@neu.edu','professor',5),(26,'Samantha Flores','1988-04-26','NON_TENURE_TRACK',67890123,'samantha.flores@neu.edu','dept_head',6),(27,'Dylan Kim','1972-09-12','TENURED',78901234,'dylan.kim@neu.edu','dept_head',7),(28,'Emma Ramirez','1976-01-08','TENURE_TRACK',89012345,'emma.ramirez@neu.edu','dept_head',8),(29,'Cameron Richardson','1981-05-03','NON_TENURE_TRACK',90123456,'cameron.richardson@neu.edu','professor',9),(30,'Hannah Turner','1974-12-27','TENURED',12347890,'hannah.turner@neu.edu','professor',10),(31,'Owen Parker','1983-08-11','TENURE_TRACK',23458901,'owen.parker@neu.edu','professor',7),(32,'Avery Collins','1987-03-24','NON_TENURE_TRACK',34569012,'avery.collins@neu.edu','professor',8),(33,'Isaac Cooper','1977-10-10','TENURED',45670123,'isaac.cooper@neu.edu','dept_head',10),(34,'Olivia Hernandez','1980-12-04','TENURE_TRACK',56781234,'olivia.hernandez@neu.edu','professor',6),(35,'Levi Ward','1984-06-17','NON_TENURE_TRACK',67892345,'levi.ward@neu.edu','professor',4),(36,'Aria Gonzales','1973-01-22','TENURED',78903456,'aria.gonzales@neu.edu','dept_head',5),(37,'Ethan Lewis','1979-04-18','TENURE_TRACK',89014567,'ethan.lewis@neu.edu','professor',7),(38,'Chloe Jackson','1986-11-05','NON_TENURE_TRACK',90125678,'chloe.jackson@neu.edu','professor',8),(39,'Landon Wright','1975-02-28','TENURED',12346789,'landon.wright@neu.edu','professor',9),(40,'Lila Chen','1979-12-08','TENURED',85720368,'lchen@northeastern.edu','professor',7),(41,'Michael Scott','1985-06-22','TENURE_TRACK',85721984,'mscott@northeastern.edu','professor',2),(42,'Olivia Johnson','1989-03-15','TENURED',85720467,'ojohnson@northeastern.edu','professor',4),(43,'Ryan Wilson','1981-09-27','NON_TENURE_TRACK',85720185,'rwilson@northeastern.edu','professor',1),(44,'Samantha Lee','1983-07-30','TENURE_TRACK',85720734,'slee@northeastern.edu','dept_head',9),(45,'Thomas Lee','1976-02-14','TENURED',85720378,'tlee@northeastern.edu','professor',1),(46,'Vanessa Brown','1990-10-11','NON_TENURE_TRACK',85721456,'vbrown@northeastern.edu','dept_head',3),(47,'William Taylor','1988-05-19','TENURE_TRACK',85720567,'wtaylor@northeastern.edu','professor',3),(48,'Xavier Hernandez','1982-11-18','TENURED',85720127,'xhernandez@northeastern.edu','professor',10),(49,'Yvonne Davis','1977-04-09','NON_TENURE_TRACK',85720899,'ydavis@northeastern.edu','professor',4);
/*!40000 ALTER TABLE `professor` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `add_professor_user` AFTER INSERT ON `professor` FOR EACH ROW BEGIN
    INSERT INTO user (user_id, username, password, role)
    VALUES (NEW.staff_id, NEW.staff_email_id, 'password123', 'professor');
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `section` (
  `section_id` int NOT NULL AUTO_INCREMENT,
  `section_number` int DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  `sroom_id` int DEFAULT NULL,
  PRIMARY KEY (`section_id`),
  KEY `course_id` (`course_id`),
  KEY `sroom_id` (`sroom_id`),
  CONSTRAINT `section_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  CONSTRAINT `section_ibfk_2` FOREIGN KEY (`sroom_id`) REFERENCES `classroom` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` VALUES (3,1,1,1),(4,2,1,1),(5,1,2,2),(6,2,2,2),(7,1,3,3),(8,1,4,4),(9,2,4,4),(10,1,5,5),(11,2,5,5),(12,1,6,6),(13,1,7,7),(14,2,7,7),(15,1,8,8),(16,2,8,8),(17,1,9,9),(18,2,9,9),(19,1,10,10),(20,2,10,10),(21,1,11,11),(22,2,12,12),(23,1,13,13),(24,2,13,13),(25,1,14,14),(26,2,14,14),(27,1,15,15),(28,2,15,15),(29,1,16,16),(30,2,16,16),(31,1,17,17),(32,1,18,18),(33,2,18,18),(34,1,19,19),(35,2,19,19),(36,1,20,20),(37,2,20,20),(38,1,21,21),(39,1,22,21),(40,1,23,22),(41,1,24,22),(42,1,25,23),(43,1,26,23),(44,1,27,24),(45,2,27,24),(46,1,28,25),(47,2,28,25),(48,1,29,26),(49,1,30,26);
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slots`
--

DROP TABLE IF EXISTS `slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `slots` (
  `slot_id` int NOT NULL AUTO_INCREMENT,
  `slot_date` date DEFAULT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `slot_status` int DEFAULT '1',
  `advisor_id` int DEFAULT NULL,
  PRIMARY KEY (`slot_id`),
  KEY `advisor_id` (`advisor_id`),
  CONSTRAINT `slots_ibfk_1` FOREIGN KEY (`advisor_id`) REFERENCES `advisor` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slots`
--

LOCK TABLES `slots` WRITE;
/*!40000 ALTER TABLE `slots` DISABLE KEYS */;
INSERT INTO `slots` VALUES (1,'2023-04-18','10:00:00','11:00:00',1,2),(2,'2023-04-18','11:30:00','12:30:00',2,1),(3,'2023-04-18','13:00:00','14:00:00',1,3),(4,'2023-04-18','14:30:00','15:30:00',1,5),(5,'2023-04-18','16:00:00','17:00:00',1,7),(6,'2023-04-18','10:00:00','11:00:00',1,9),(7,'2023-04-18','11:30:00','12:30:00',1,8),(8,'2023-04-18','13:00:00','14:00:00',1,10),(9,'2023-04-18','14:30:00','15:30:00',1,4),(10,'2023-04-18','16:00:00','17:00:00',1,6),(11,'2023-04-18','10:00:00','11:00:00',2,1),(12,'2023-04-18','11:30:00','12:30:00',1,3),(13,'2023-04-18','13:00:00','14:00:00',1,2),(14,'2023-04-18','14:30:00','15:30:00',1,4),(15,'2023-04-18','16:00:00','17:00:00',1,5),(16,'2023-04-18','14:00:00','15:00:00',1,1),(17,'2023-04-19','14:00:00','15:00:00',1,1),(18,'2023-04-20','18:00:00','19:00:00',1,1),(19,'2023-04-21','10:00:00','11:00:00',1,1),(20,'2023-04-21','12:00:00','13:00:00',1,1),(21,'2023-04-21','15:00:00','16:00:00',1,1),(22,'2023-04-21','18:00:00','19:00:00',1,1),(23,'2023-04-21','20:00:00','21:00:00',1,1),(24,'2023-04-22','09:00:00','10:00:00',1,1),(25,'2023-04-22','10:00:00','11:00:00',1,1),(26,'2023-04-22','11:00:00','12:00:00',1,1),(27,'2023-04-22','12:00:00','13:00:00',1,1),(28,'2023-04-22','13:00:00','14:00:00',1,1),(29,'2023-04-22','14:00:00','15:00:00',1,1),(30,'2023-04-22','15:00:00','16:00:00',1,1),(31,'2023-04-22','16:00:00','17:00:00',1,1),(32,'2023-04-22','17:00:00','18:00:00',1,1),(33,'2023-04-23','09:00:00','10:00:00',1,1),(34,'2023-04-23','10:00:00','11:00:00',1,1),(35,'2023-04-23','11:00:00','12:00:00',1,1),(36,'2023-04-23','12:00:00','13:00:00',1,1),(37,'2023-04-23','13:00:00','14:00:00',1,1),(38,'2023-04-23','14:00:00','15:00:00',1,1),(39,'2023-04-23','15:00:00','16:00:00',1,1),(40,'2023-04-23','16:00:00','17:00:00',1,1),(41,'2023-04-23','17:00:00','18:00:00',1,1),(42,'2023-04-24','09:00:00','10:00:00',1,1),(43,'2023-04-24','10:00:00','11:00:00',1,1),(44,'2023-04-24','11:00:00','12:00:00',1,1),(45,'2023-04-24','12:00:00','13:00:00',1,1),(46,'2023-04-24','13:00:00','14:00:00',1,1),(47,'2023-04-24','14:00:00','15:00:00',1,1),(48,'2023-04-24','15:00:00','16:00:00',1,1),(49,'2023-04-24','16:00:00','17:00:00',1,1),(50,'2023-04-24','17:00:00','18:00:00',1,1),(51,'2023-04-25','09:00:00','10:00:00',1,1),(52,'2023-04-25','10:00:00','11:00:00',1,1),(53,'2023-04-25','11:00:00','12:00:00',1,1),(54,'2023-04-25','12:00:00','13:00:00',1,1),(55,'2023-04-25','13:00:00','14:00:00',1,1),(56,'2023-04-25','14:00:00','15:00:00',1,1),(57,'2023-04-25','15:00:00','16:00:00',1,1),(58,'2023-04-25','16:00:00','17:00:00',1,1),(59,'2023-04-25','17:00:00','18:00:00',1,1),(60,'2023-04-26','09:00:00','10:00:00',1,1),(61,'2023-04-26','10:00:00','11:00:00',1,1),(62,'2023-04-26','11:00:00','12:00:00',1,1),(63,'2023-04-26','12:00:00','13:00:00',1,1),(64,'2023-04-26','13:00:00','14:00:00',1,1),(65,'2023-04-26','14:00:00','15:00:00',1,1),(66,'2023-04-26','15:00:00','16:00:00',1,1),(67,'2023-04-26','16:00:00','17:00:00',1,1),(68,'2023-04-26','17:00:00','18:00:00',1,1),(69,'2023-04-27','09:00:00','10:00:00',1,1),(70,'2023-04-27','10:00:00','11:00:00',1,1),(71,'2023-04-27','11:00:00','12:00:00',1,1),(72,'2023-04-27','12:00:00','13:00:00',1,1),(73,'2023-04-27','13:00:00','14:00:00',1,1),(74,'2023-04-27','14:00:00','15:00:00',1,1),(75,'2023-04-27','15:00:00','16:00:00',1,1),(76,'2023-04-27','16:00:00','17:00:00',1,1),(77,'2023-04-27','17:00:00','18:00:00',1,1),(78,'2023-04-28','09:00:00','10:00:00',1,1),(79,'2023-04-28','10:00:00','11:00:00',1,1),(80,'2023-04-28','11:00:00','12:00:00',1,1),(81,'2023-04-28','12:00:00','13:00:00',1,1),(82,'2023-04-28','13:00:00','14:00:00',1,1),(83,'2023-04-28','14:00:00','15:00:00',1,1),(84,'2023-04-28','15:00:00','16:00:00',1,1),(85,'2023-04-28','16:00:00','17:00:00',1,1),(86,'2023-04-28','17:00:00','18:00:00',1,1),(87,'2023-04-29','09:00:00','10:00:00',1,1),(88,'2023-04-29','10:00:00','11:00:00',1,1),(89,'2023-04-29','11:00:00','12:00:00',1,1),(90,'2023-04-29','12:00:00','13:00:00',1,1),(91,'2023-04-29','13:00:00','14:00:00',1,1),(92,'2023-04-29','14:00:00','15:00:00',1,1),(93,'2023-04-29','15:00:00','16:00:00',1,1),(94,'2023-04-29','16:00:00','17:00:00',1,1),(95,'2023-04-29','17:00:00','18:00:00',1,1),(96,'2023-04-22','20:00:00','21:00:00',1,1),(97,'2023-04-22','21:00:00','22:00:00',1,1),(98,'2023-04-23','20:00:00','21:00:00',1,1),(99,'2023-04-23','21:00:00','22:00:00',1,1),(100,'2023-04-24','20:00:00','21:00:00',1,1),(101,'2023-04-24','21:00:00','22:00:00',1,1),(102,'2023-04-25','20:00:00','21:00:00',1,1),(103,'2023-04-25','21:00:00','22:00:00',1,1),(104,'2023-04-26','20:00:00','21:00:00',1,1),(105,'2023-04-26','21:00:00','22:00:00',1,1),(106,'2023-04-27','20:00:00','21:00:00',1,1),(107,'2023-04-27','21:00:00','22:00:00',1,1),(108,'2023-04-28','20:00:00','21:00:00',1,1),(109,'2023-04-28','21:00:00','22:00:00',1,1),(110,'2023-04-29','20:00:00','21:00:00',1,1),(111,'2023-04-29','21:00:00','22:00:00',1,1);
/*!40000 ALTER TABLE `slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `student_name` varchar(255) DEFAULT NULL,
  `student_major` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `student_email_id` varchar(255) DEFAULT NULL,
  `class_level` varchar(255) DEFAULT NULL,
  `grade` varchar(10) DEFAULT 'N/A',
  `role` varchar(50) DEFAULT 'student',
  `course_id` int DEFAULT NULL,
  `advisor_id` int DEFAULT NULL,
  `section_id` int DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `course_id` (`course_id`),
  KEY `advisor_id` (`advisor_id`),
  KEY `section_id` (`section_id`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`advisor_id`) REFERENCES `advisor` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_ibfk_3` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1037 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (101,'Amy Smith','Computer Science','2001-01-10','amysmith@gmail.com','Freshman','A','student',1,1,3),(102,'Bob Johnson','Electrical Engineering','2000-05-20','bjohnson@yahoo.com','Sophomore','N/A','student',2,2,5),(103,'Carla Williams','Psychology','1999-09-15','carlawill@gmail.com','Senior','N/A','student',3,3,7),(104,'David Lee','Mechanical Engineering','2002-03-02','davidlee@hotmail.com','Junior','N/A','student',1,4,4),(105,'Emily Chen','Marketing','2001-11-27','echen@yahoo.com','Freshman','N/A','student',2,5,5),(106,'Frank Rodriguez','Computer Science','2000-08-12','frankrod@gmail.com','Sophomore','N/A','student',3,6,7),(107,'Grace Kim','Biology','1999-04-19','gracekim@hotmail.com','Senior','B','student',1,7,3),(108,'Henry Nguyen','Chemical Engineering','2002-06-23','hnguyen@gmail.com','Junior','N/A','student',2,8,5),(109,'Isabella Taylor','English','2001-02-17','isataylor@yahoo.com','Freshman','N/A','student',3,9,7),(110,'Jack Brown','Finance','2000-10-08','jbrown@hotmail.com','Sophomore','N/A','student',1,10,4),(111,'Katherine Lee','Computer Science','1999-08-15','katlee@gmail.com','Senior','N/A','student',2,1,5),(112,'Liam Johnson','Mechanical Engineering','2002-05-23','ljohnson@yahoo.com','Junior','N/A','student',3,2,7),(113,'Mia Davis','Psychology','2001-01-03','miadavis@gmail.com','Freshman','B','student',1,3,3),(114,'Noah Kim','Electrical Engineering','2000-07-09','nkim@hotmail.com','Sophomore','N/A','student',2,4,5),(115,'Olivia Garcia','Computer Science','1999-11-12','ogarcia@yahoo.com','Senior','N/A','student',3,5,7),(116,'Paula Hernandez','Marketing','2002-04-25','phernandez@gmail.com','Junior','A','student',1,6,3),(117,'Quinn Smith','Biology','2001-09-19','qsmith@hotmail.com','Freshman','N/A','student',2,7,5),(118,'Ryan Nguyen','Chemical Engineering','2000-02-22','rnguyen@yahoo.com','Sophomore','N/A','student',3,8,7),(119,'Samantha Wilson','English','1999-12-28','swilson@gmail.com','Senior','B+','student',1,9,3),(120,'Thomas Brown','Finance','2002-08-04','tbrown@yahoo.com','Junior','N/A','student',2,10,5),(1019,'Lila Brown','Computer Science','2001-03-09','lilabrown@northeastern.edu','Senior','A','student',4,7,8),(1020,'Ethan Turner','Physics','2002-05-22','ethanturner@northeastern.edu','Freshman','N/A','student',5,6,10),(1021,'Avery Scott','History','2001-06-16','averyscott@northeastern.edu','Sophomore','N/A','student',6,2,12),(1022,'Mia Peterson','Chemistry','2000-11-18','miapeterson@northeastern.edu','Junior','N/A','student',7,1,13),(1023,'Aiden Evans','Computer Engineering','1999-09-04','aidenevans@northeastern.edu','Senior','N/A','student',8,8,15),(1024,'Grace Martinez','Biology','2002-01-12','gracemartinez@northeastern.edu','Freshman','A-','student',1,5,3),(1025,'Lucas Rodriguez','Computer Science','2001-04-23','lucasrodriguez@northeastern.edu','Sophomore','N/A','student',2,9,5),(1026,'Hannah Flores','Psychology','2000-07-17','hannahflores@northeastern.edu','Junior','N/A','student',3,10,7),(1027,'Isaac Hernandez','Political Science','2002-08-08','isachernandez@northeastern.edu','Freshman','B','student',4,4,8),(1028,'Olivia Davis','Mathematics','2001-02-11','oliviadavis@northeastern.edu','Senior','N/A','student',5,3,10),(1029,'David Lewis','Computer Engineering','2000-09-22','davidlewis@northeastern.edu','Junior','N/A','student',6,7,12),(1030,'Sofia King','Sociology','2002-06-27','sofiaking@northeastern.edu','Sophomore','N/A','student',7,6,13),(1031,'Jackson Baker','Biochemistry','2001-01-05','jacksonbaker@northeastern.edu','Senior','N/A','student',8,2,15),(1032,'Chloe Nelson','Computer Science','2002-04-28','chloenelson@northeastern.edu','Freshman','N/A','student',1,1,4),(1033,'Elijah Carter','Mechanical Engineering','2000-12-07','elijahcarter@northeastern.edu','Junior','N/A','student',2,5,5),(1034,'Ava Perez','Chemistry','2001-07-01','avaperez@northeastern.edu','Sophomore','N/A','student',3,9,7),(1035,'Logan Turner','Computer Engineering','2002-02-17','loganturner@northeastern.edu','Freshman','B','student',4,10,8);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `add_student_user` AFTER INSERT ON `student` FOR EACH ROW BEGIN
    INSERT INTO user (user_id, username, password, role)
    VALUES (NEW.student_id, NEW.student_email_id, 'password123', 'student');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `teaches`
--

DROP TABLE IF EXISTS `teaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teaches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int DEFAULT NULL,
  `section_id` int DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_id` (`course_id`),
  KEY `section_id` (`section_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `teaches_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `teaches_ibfk_3` FOREIGN KEY (`staff_id`) REFERENCES `professor` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `teaches_ibfk_4` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teaches`
--

LOCK TABLES `teaches` WRITE;
/*!40000 ALTER TABLE `teaches` DISABLE KEYS */;
INSERT INTO `teaches` VALUES (1,1,3,21),(2,1,4,21),(3,2,5,43),(4,2,6,45),(5,3,7,21),(6,4,8,22),(7,4,9,22),(8,5,10,41),(9,5,11,22),(10,6,12,41),(11,7,13,23),(12,7,14,46),(13,8,15,47),(14,8,16,46),(15,9,17,23),(16,9,18,47),(17,10,19,24),(18,10,20,35),(19,11,21,42),(20,12,22,49),(21,13,23,25),(22,14,24,36),(23,15,25,25),(24,15,26,36),(25,16,27,26),(26,16,28,34),(27,17,29,26),(28,18,30,34),(29,18,31,26),(30,18,32,34),(31,19,33,27),(32,19,34,31),(33,20,35,37),(34,20,36,40),(35,21,37,31),(36,21,38,40),(37,22,39,28),(38,23,40,32),(39,24,41,38),(40,25,42,29),(41,26,43,39),(42,27,44,29),(43,27,45,39),(44,28,46,30),(45,28,47,33),(46,29,48,48),(47,30,49,33);
/*!40000 ALTER TABLE `teaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `role` enum('student','professor','advisor','club_head','dept_head') NOT NULL,
  `pass_updated` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (21,'rebecca.davis@neu.edu','abcd','dept_head',1),(22,'jordan.ortiz@neu.edu','abcd','dept_head',1),(23,'shannon.peterson@neu.edu','password123','professor',0),(24,'megan.cox@neu.edu','password123','dept_head',0),(25,'benjamin.lee@neu.edu','password123','professor',0),(26,'samantha.flores@neu.edu','password123','dept_head',0),(27,'dylan.kim@neu.edu','password123','dept_head',0),(28,'emma.ramirez@neu.edu','password123','dept_head',0),(29,'cameron.richardson@neu.edu','password123','professor',0),(30,'hannah.turner@neu.edu','password123','professor',0),(31,'owen.parker@neu.edu','password123','professor',0),(32,'avery.collins@neu.edu','password123','professor',0),(33,'isaac.cooper@neu.edu','password123','dept_head',0),(34,'olivia.hernandez@neu.edu','password123','professor',0),(35,'levi.ward@neu.edu','password123','professor',0),(36,'aria.gonzales@neu.edu','password123','dept_head',0),(37,'ethan.lewis@neu.edu','password123','professor',0),(38,'chloe.jackson@neu.edu','password123','professor',0),(39,'landon.wright@neu.edu','password123','professor',0),(40,'lchen@northeastern.edu','password123','professor',0),(41,'mscott@northeastern.edu','password123','professor',0),(42,'ojohnson@northeastern.edu','password123','professor',0),(43,'rwilson@northeastern.edu','password123','professor',0),(44,'slee@northeastern.edu','password123','dept_head',0),(45,'tlee@northeastern.edu','password123','professor',0),(46,'vbrown@northeastern.edu','password123','dept_head',0),(47,'wtaylor@northeastern.edu','password123','professor',0),(48,'xhernandez@northeastern.edu','password123','professor',0),(49,'ydavis@northeastern.edu','password123','professor',0),(1,'ajohnson@northeastern.edu','abcd','advisor',1),(2,'blee@northeastern.edu','password123','advisor',0),(3,'cbrown@northeastern.edu','abcd','advisor',1),(4,'dchen@northeastern.edu','password123','advisor',0),(5,'edavis@northeastern.edu','password123','advisor',0),(6,'ftaylor@northeastern.edu','password123','advisor',0),(7,'ghernandez@northeastern.edu','password123','advisor',0),(8,'hwilson@northeastern.edu','password123','advisor',0),(9,'ijohnson@northeastern.edu','password123','advisor',0),(10,'jsmith@northeastern.edu','password123','advisor',0),(11,'olivia.baker@northeastern.edu','password123','advisor',0),(12,'ethan.cooper@northeastern.edu','password123','advisor',0),(13,'avery.davis@northeastern.edu','password123','advisor',0),(14,'isabella.garcia@northeastern.edu','password123','advisor',0),(15,'jackson.kim@northeastern.edu','password123','advisor',0),(16,'sophie.lee@northeastern.edu','password123','advisor',0),(17,'caleb.miller@northeastern.edu','password123','advisor',0),(18,'natalie.nguyen@northeastern.edu','password123','advisor',0),(19,'levi.patel@northeastern.edu','password123','advisor',0),(20,'aria.smith@northeastern.edu','password123','advisor',0),(101,'amysmith@gmail.com','abcd','student',1),(102,'bjohnson@yahoo.com','password123','student',0),(103,'carlawill@gmail.com','abcd','student',1),(104,'davidlee@hotmail.com','password123','student',0),(105,'echen@yahoo.com','password123','student',0),(106,'frankrod@gmail.com','password123','student',0),(107,'gracekim@hotmail.com','password123','student',0),(108,'hnguyen@gmail.com','password123','student',0),(109,'isataylor@yahoo.com','password123','student',0),(110,'jbrown@hotmail.com','password123','student',0),(111,'katlee@gmail.com','password123','student',0),(112,'ljohnson@yahoo.com','password123','student',0),(113,'miadavis@gmail.com','password123','student',0),(114,'nkim@hotmail.com','password123','student',0),(115,'ogarcia@yahoo.com','password123','student',0),(116,'phernandez@gmail.com','password123','student',0),(117,'qsmith@hotmail.com','password123','student',0),(118,'rnguyen@yahoo.com','password123','student',0),(119,'swilson@gmail.com','password123','student',0),(120,'tbrown@yahoo.com','password123','student',0),(1019,'lilabrown@northeastern.edu','abcd','club_head',1),(1020,'ethanturner@northeastern.edu','password123','club_head',0),(1021,'averyscott@northeastern.edu','password123','student',0),(1022,'miapeterson@northeastern.edu','password123','student',0),(1023,'aidenevans@northeastern.edu','password123','student',0),(1024,'gracemartinez@northeastern.edu','password123','student',0),(1025,'lucasrodriguez@northeastern.edu','password123','club_head',0),(1026,'hannahflores@northeastern.edu','password123','student',0),(1027,'isachernandez@northeastern.edu','password123','student',0),(1028,'oliviadavis@northeastern.edu','password123','student',0),(1029,'davidlewis@northeastern.edu','password123','student',0),(1030,'sofiaking@northeastern.edu','password123','student',0),(1031,'jacksonbaker@northeastern.edu','password123','student',0),(1032,'chloenelson@northeastern.edu','password123','club_head',0),(1033,'elijahcarter@northeastern.edu','password123','student',0),(1034,'avaperez@northeastern.edu','password123','student',0),(1035,'loganturner@northeastern.edu','password123','club_head',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'university_gp'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_courses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_courses`(IN p_username VARCHAR(50), IN p_course_name VARCHAR(255), IN p_course_description VARCHAR(255), IN p_course_credits INT)
BEGIN
	declare p_department_id int;
    select department_id into p_department_id from professor where staff_email_id=p_username;
    INSERT INTO course (course_name,course_description,course_credits,department_id) values (p_course_name,p_course_description,p_course_credits,p_department_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_slot` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_slot`(IN p_user_id INT, IN p_slot_date DATE, IN p_start_time time, IN p_end_time time)
BEGIN
	IF Not exists(select * from slots where advisor_id = p_user_id and start_time = p_start_time and slot_date = p_slot_date) Then
    INSERT INTO slots (slot_date,start_time,end_time,advisor_id) values (p_slot_date,p_start_time,p_end_time,p_user_id);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `club_events` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `club_events`(IN p_club_name VARCHAR(255))
BEGIN
 DECLARE id INT;
 SELECT club_id INTO id FROM club WHERE club_name = p_club_name;
 select event_name,event_description,event_date,start_time,end_time,room_number,room_capacity,building_name from event 
 join classroom on event.classroom_id = classroom.room_id 
 join building on building.building_id = classroom.building_id 
 where club_id = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_event`(
  IN p_club_name VARCHAR(255),
  IN event_name VARCHAR(255),
  IN event_description TEXT,
  IN event_date DATE,
  IN start_time TIME,
  IN end_time TIME,
  IN building_name VARCHAR(255),
  IN p_room_number VARCHAR(255)
)
BEGIN
  DECLARE id INT;
  Declare c_id INT;
  -- Get the ID of the selected building
  SELECT room_id INTO id FROM classroom WHERE  room_number = p_room_number;
SELECT club_id INTO c_id FROM club WHERE  club_name = p_club_name;
  -- Insert the new event into the event table
  INSERT INTO event (event_name, event_description, event_date, start_time, end_time, classroom_id, club_id)
  VALUES (event_name, event_description, event_date, start_time, end_time, id, c_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_club` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_club`(IN p_user_id INT)
BEGIN
IF EXISTS(SELECT * FROM participates WHERE student_id = p_user_id) THEN
delete from participates where student_id = p_user_id;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fill_participants` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fill_participants`(IN p_user_id INT, IN p_club_name VARCHAR(255))
BEGIN
 DECLARE id INT;
 SELECT club_id INTO id FROM club WHERE club_name = p_club_name;
IF NOT EXISTS(SELECT * FROM participates WHERE student_id = p_user_id) THEN
INSERT INTO participates (club_id, student_id) VALUES (id, p_user_id);
ELSE 
SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'You are already enrolled in a club';
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_advisor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_advisor`(IN p_user_Id INT)
BEGIN
    SELECT * FROM advisor join department on advisor.department_id = department.department_id WHERE advisor.staff_id = p_user_Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_advisor_students` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_advisor_students`(IN p_user_Id INT)
BEGIN
    SELECT * FROM student join course on student.course_id = course.course_id join advisor on student.advisor_id = advisor.staff_id join department on advisor.department_id = department.department_id WHERE staff_id =p_user_Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_courses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_courses`()
BEGIN
select course_name,section_number,course_description,course_credits,building_name,staff_name,room_number from course 
join teaches on course.course_id = teaches.course_id 
join section on section.section_id = teaches.section_id 
join professor on professor.staff_id=teaches.staff_id
join classroom on section.sroom_id = classroom.room_id 
join building on classroom.building_id = building.building_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_booking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_booking`(IN p_user_id INT)
BEGIN
select appointment_id,slot_date,start_time,end_time,staff_name,staff_email_id from appointments 
join slots on appointments.slot_id = slots.slot_id 
join advisor on appointments.advisor_id = advisor.staff_id 
where slot_status = 2 and student_id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_building` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_building`()
BEGIN
select building_id,building_name from building;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_clubs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_clubs`()
BEGIN
select * from club join student where student_id = club_head;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_course_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_course_details`(IN p_user_id INT)
BEGIN
SELECT student_major, course_name,section_number,course_description,course_credits,building_name,staff_name,room_number FROM student 
join course on student.course_id = course.course_id 
join section on section.section_id = student.section_id
join classroom on section.sroom_id = classroom.room_id 
join building on classroom.building_id = building.building_id 
join teaches on teaches.section_id=student.section_id
join professor on professor.staff_id=teaches.staff_id
WHERE student_id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_grade_statistics` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_grade_statistics`(IN p_course_id INT, IN p_section_id INT)
BEGIN
    select grade as label,count(grade)/(select count(*) from student where course_id=p_course_id and section_id=p_section_id)*100 as y
    from student
    where course_id=p_course_id and section_id=p_section_id
    group by grade;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_login`(IN p_user_name VARCHAR(200),IN p_password VARCHAR(50))
BEGIN
 DECLARE id INT;
 SELECT user_id into id FROM user WHERE username = p_user_name AND password = p_password;
 If id is not null then 
 SELECT * FROM user WHERE username = p_user_name AND password = p_password;
 else
 SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = 'User Does Not Exists';
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_professor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_professor`(IN p_user_Id INT)
BEGIN
    SELECT * FROM professor join department on professor.department_id = department.department_id WHERE professor.staff_id = p_user_Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_rooms` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_rooms`(IN p_building_id INT)
BEGIN
SELECT * FROM classroom WHERE building_id=p_building_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_slots` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_slots`(IN p_user_id INT)
BEGIN
select * from slots 
    join advisor on slots.advisor_id = advisor.staff_id 
    join student on student.advisor_id = advisor.staff_id 
    Where student_id = p_user_id and slot_status = 1 and slot_date=CURDATE();
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_slot_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_slot_details`(IN p_user_id INT)
BEGIN
    select student.student_id,student_name,student_major,student_email_id,class_level,grade, start_time,end_time,app_status from appointments join student on student.student_id = appointments.student_id join advisor on advisor.staff_id = appointments.advisor_id join slots on slots.slot_id = appointments.slot_id where staff_id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_student` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_student`(IN p_user_id INT)
BEGIN
    SELECT * FROM student join advisor on advisor.staff_id = student.advisor_id WHERE student_id = p_user_Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `my_clubs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `my_clubs`(IN p_user_id INT)
BEGIN
select * from participates join club on participates.club_id = club.club_id join student on participates.student_id = student.student_id where participates.student_id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `password_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `password_update`(IN pass_user_name VARCHAR(50))
BEGIN
    SELECT pass_updated FROM user WHERE username = pass_user_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_advisor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_advisor`(
    IN p_name VARCHAR(255),
    IN p_dob DATE,
    IN p_phone VARCHAR(15),
    IN p_email VARCHAR(255),
    IN p_user_id INT
)
BEGIN
    UPDATE advisor
    SET 
        `staff_name` = p_name,
        `date_of_birth` = p_dob,
        `phone_number` = p_phone,
        `staff_email_id` = p_email
    WHERE `staff_id` = p_user_id;
            
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_appointment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_appointment`(
    IN student_email VARCHAR(255),
    IN advisor_name VARCHAR(255),
    IN p_slot_id INT,
    IN user_id INT
)
BEGIN
    DECLARE advisor_id INT;
	SELECT staff_id INTO advisor_id FROM advisor WHERE staff_name = advisor_name;
    INSERT INTO appointments (student_id, advisor_id, slot_id)
    VALUES (user_id, advisor_id, p_slot_id);
    UPDATE slots SET slot_status = 2 WHERE slot_id = p_slot_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_grade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_grade`(IN p_grade VARCHAR(10), IN p_student_id INT)
BEGIN
    update student
	set grade = p_grade
	where student_id=p_student_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_password` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_password`(IN p_user_name VARCHAR(50), IN p_new_password VARCHAR(255))
BEGIN
    UPDATE user SET password = p_new_password, pass_updated=1 WHERE username = p_user_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_professor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_professor`(
    IN p_name VARCHAR(255),
    IN p_dob DATE,
    IN p_tenure VARCHAR(50),
    IN p_phone VARCHAR(15),
    IN p_email VARCHAR(255),
    IN p_user_id INT
)
BEGIN
    UPDATE professor
    SET 
        `staff_name` = p_name,
        `date_of_birth` = p_dob,
        `tenure_status` = p_tenure,
        `phone_number` = p_phone,
        `staff_email_id` = p_email
    WHERE `staff_id` = p_user_id;
            
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_student` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_student`(
    IN p_name VARCHAR(255),
    IN p_dob DATE,
    IN p_email VARCHAR(255),
    IN p_user_id INT
)
BEGIN
    UPDATE student
    SET 
        `student_name` = p_name,
        `date_of_birth` = p_dob,
        `student_email_id` = p_email
    WHERE `student_id` = p_user_id;
            
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_courses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_courses`(IN p_username VARCHAR(50))
BEGIN
    select teaches.course_id,course.course_name,course.course_description,course.course_credits,section.section_id,section.section_number,classroom.room_number,building.building_name,building.building_address from teaches
	join course on course.course_id=teaches.course_id
	join section on section.section_id=teaches.section_id
	join professor on teaches.staff_id=professor.staff_id
	join classroom on classroom.room_id=section.sroom_id
	join building on building.building_id=classroom.building_id where professor.staff_email_id=p_username;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_professors` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_professors`(IN p_username VARCHAR(50))
BEGIN
    declare p_department_id int;
    select department_id into p_department_id from professor where staff_email_id=p_username;
    select staff_id,staff_name,tenure_status,staff_email_id from professor where role='professor' and department_id=p_department_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_students` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_students`(IN p_course_id INT, IN p_section_id INT)
BEGIN
    select * from student
	where course_id=p_course_id and section_id=p_section_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-21 21:02:51
