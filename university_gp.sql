CREATE DATABASE  IF NOT EXISTS `university_gp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `university_gp`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: university_gp
-- ------------------------------------------------------
-- Server version	8.0.32

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advisor`
--

LOCK TABLES `advisor` WRITE;
/*!40000 ALTER TABLE `advisor` DISABLE KEYS */;
INSERT INTO `advisor` VALUES (1,'Jn mith','1990-03-01',1234567890,'jn.mith@example.com','advisor',1),(2,'Alex Johnson','1982-07-12',85721423,'ajohnson@northeastern.edu','advisor',1),(3,'Brenda Lee','1985-01-30',85720976,'blee@northeastern.edu','advisor',2),(4,'Charlie Brown','1979-09-22',85720875,'cbrown@northeastern.edu','advisor',3),(5,'David Chen','1988-04-13',85720132,'dchen@northeastern.edu','advisor',4),(6,'Emily Davis','1992-11-27',85720742,'edavis@northeastern.edu','advisor',5),(7,'Frank Taylor','1980-06-19',85720258,'ftaylor@northeastern.edu','advisor',6),(8,'Grace Hernandez','1975-03-14',85720345,'ghernandez@northeastern.edu','advisor',7),(9,'Henry Wilson','1983-08-08',85720567,'hwilson@northeastern.edu','advisor',8),(10,'Isabella Johnson','1990-05-05',85721145,'ijohnson@northeastern.edu','advisor',9),(11,'Jake Smith','1977-12-28',85720987,'jsmith@northeastern.edu','advisor',10);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `building`
--

LOCK TABLES `building` WRITE;
/*!40000 ALTER TABLE `building` DISABLE KEYS */;
INSERT INTO `building` VALUES (1,'Smith Hall','123 Main St, Anytown, USA','(555) 555-1234'),(2,'Forsyth Building','145 Forsyth St, Boston, MA 02115','617-373-2000'),(3,'WVH Building','360 Huntington Ave, Boston, MA 02115','617-373-2000'),(4,'Dockser Hall','65 Forsyth St, Boston, MA 02115','617-373-2000'),(5,'Hayden Hall','360 Huntington Ave, Boston, MA 02115','617-373-2000'),(6,'Richards Hall','25 Leon St, Boston, MA 02115','617-373-2000'),(7,'Robinson Hall','301 Huntington Ave, Boston, MA 02115','617-373-2000'),(8,'Kariotis Hall','11 Speare Pl, Boston, MA 02115','617-373-2000'),(9,'International Village','1155 Tremont St, Boston, MA 02120','617-373-2000'),(10,'Rubenstein Hall','68 Forsyth St, Boston, MA 02115','617-373-2000'),(11,'Lake Hall','360 Huntington Ave, Boston, MA 02115','617-373-2000'),(12,'Stetson West','10 Leon St, Boston, MA 02115','617-373-2000'),(13,'Cullinane Hall','117 Cullinane Hall, Boston, MA 02115','617-373-2000'),(14,'Churchill Hall','40A Leon St, Boston, MA 02115','617-373-2000'),(15,'Ryder Hall','11 Leon St, Boston, MA 02115','617-373-2000'),(16,'Wollaston Building','316 Huntington Ave, Boston, MA 02115','617-373-2000'),(17,'Dodge Hall','360 Huntington Ave, Boston, MA 02115','617-373-2000'),(18,'Davies Hall','360 Huntington Ave, Boston, MA 02115','617-373-2000'),(19,'Mugar Hall','360 Huntington Ave, Boston, MA 02115','617-373-2000'),(20,'International Student Center','104 Forsyth St, Boston, MA 02115','617-373-2000'),(21,'Kerr Hall','340 Huntington Ave, Boston, MA 02115','617-373-2000'),(22,'Columbus Place','716 Columbus Ave, Boston, MA 02120','617-373-2000'),(23,'Rubenstein Hall Annex','106 Saint Botolph St, Boston, MA 02115','617-373-2000'),(24,'West Village E','40A Leon St, Boston, MA 02115','617-373-2000'),(25,'Snell Engineering Center','360 Huntington Ave, Boston, MA 02115','617-373-2000'),(26,'Krentzman Quad','15 Forsyth St, Boston, MA 02115','617-373-2000'),(27,'Fenway Center','77 Saint Botolph St, Boston, MA 02115','617-373-2000'),(28,'1155 Tremont','1155 Tremont St, Boston, MA 02120','617-373-2000'),(29,'Burstein Hall','135 Forsyth St, Boston, MA 02115','617-373-2000');
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */;
INSERT INTO `classroom` VALUES (1,'114',50,1),(2,'304',30,2),(3,'102',25,3),(4,'203',40,4),(5,'205',35,5),(6,'307',20,6),(7,'301',50,7),(8,'402',40,8),(9,'212',30,9),(10,'306',20,10),(11,'114A',15,1),(12,'312',25,2),(13,'101',20,3),(14,'201',35,4),(15,'303',30,5),(16,'305',25,6),(17,'302',45,7),(18,'404',35,8),(19,'214',15,9),(20,'308',20,10),(21,'115',50,1),(22,'305A',30,2),(23,'103',25,3),(24,'202',40,4),(25,'204',35,5),(26,'309',20,6),(27,'303A',50,7),(28,'401',40,8),(29,'216',30,9),(30,'310',20,10);
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
  `course_id` int NOT NULL,
  `course_name` varchar(255) DEFAULT NULL,
  `course_description` varchar(255) DEFAULT NULL,
  `course_credits` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'Introduction to Computer Science','Introduction to the fundamentals of computer science.',4,1),(2,'Data Structures and Algorithms','Study of basic algorithms and their implementation.',4,1),(3,'Discrete Mathematics','Introduction to mathematical reasoning and discrete structures.',4,1),(4,'Introduction to Biology','Overview of the major concepts and principles of biology.',4,2),(5,'Cellular and Molecular Biology','Study of cellular and molecular mechanisms of life.',4,2),(6,'Genetics and Evolution','Introduction to the principles of genetics and evolution.',4,2),(7,'General Chemistry','Introduction to the fundamental principles of chemistry.',4,3),(8,'Organic Chemistry','Introduction to the principles of organic chemistry.',4,3),(9,'Physical Chemistry','Introduction to the principles of physical chemistry.',4,3),(10,'Linear Algebra','Study of linear equations and matrices.',4,4),(11,'Real Analysis','Introduction to the fundamental concepts of analysis.',4,4),(12,'Probability and Statistics','Introduction to the concepts of probability and statistics.',4,4),(13,'Classical Mechanics','Introduction to the principles of classical mechanics.',4,5),(14,'Electromagnetism','Introduction to the principles of electromagnetism.',4,5),(15,'Quantum Mechanics','Introduction to the principles of quantum mechanics.',4,5),(16,'Introduction to Psychology','Overview of the major concepts and principles of psychology.',4,6),(17,'Social Psychology','Introduction to the principles of social psychology.',4,6),(18,'Abnormal Psychology','Introduction to the principles of abnormal psychology.',4,6),(19,'Introduction to English Literature','Overview of the major works of English literature.',4,7),(20,'American Literature','Introduction to the major works of American literature.',4,7),(21,'Creative Writing','Introduction to the principles of creative writing.',4,7),(22,'Introduction to World History','Overview of the major events and themes of world history.',4,8),(23,'American History','Introduction to the major events and themes of American history.',4,8),(24,'History of Science and Technology','Overview of the major scientific and technological developments of history.',4,8),(25,'Introduction to Political Science','Overview of the major concepts and principles of political science.',4,9),(26,'International Relations','Introduction to the principles of international relations.',4,9),(27,'Comparative Politics','Introduction to the principles of comparative politics.',4,9),(28,'Introduction to Business','Introduction to the major concepts and principles of business.',4,10),(29,'Marketing','Introduction to the principles of marketing.',4,10),(30,'Financial Accounting','Introduction to the principles of financial accounting.',4,10);
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Computer Science',1000000.00,'John Smith',1),(2,'Biology',2000000.00,'Emily Brown',2),(3,'Chemistry',1800000.00,'Adam Lee',3),(4,'Mathematics',1600000.00,'Karen Chen',4),(5,'Physics',1900000.00,'Michael Kim',5),(6,'Psychology',1700000.00,'Julia Nguyen',6),(7,'English',1400000.00,'David Wilson',7),(8,'History',1200000.00,'Alex Martin',8),(9,'Political Science',1300000.00,'Samantha Lee',9),(10,'Business',2200000.00,'Peter Kim',10),(11,'Art',800000.00,'Linda Chen',1),(12,'Music',900000.00,'William Davis',2),(13,'Journalism',750000.00,'Grace Park',3),(14,'Philosophy',850000.00,'Daniel Lee',4),(15,'Education',1000000.00,'Mary Johnson',5),(16,'Economics',1100000.00,'George Brown',6),(17,'Sociology',950000.00,'Sophia Kim',7),(18,'Theater',700000.00,'Nathan Chen',8),(19,'Architecture',1200000.00,'Oliver Davis',9),(20,'Engineering',2500000.00,'Jennifer Lee',10),(21,'Philology',700000.00,'Emily Wilson',1),(22,'Statistics',1300000.00,'Steven Kim',2),(23,'Anthropology',900000.00,'Andrew Park',3),(24,'Environmental Science',1100000.00,'Mia Brown',4),(25,'Public Health',1900000.00,'Hannah Lee',5);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'Orientation Day','Welcome event for new students','2023-08-20','09:00:00','13:00:00',15,1),(2,'Career Fair','Job and internship opportunities for students','2023-10-05','10:00:00','14:00:00',25,2),(3,'Halloween Party','Costume party for students','2023-10-31','20:00:00','23:00:00',7,3),(4,'Thanksgiving Dinner','Traditional Thanksgiving dinner for students','2023-11-23','18:00:00','21:00:00',11,4),(5,'Christmas Concert','Music concert for students and staff','2023-12-15','19:00:00','22:00:00',19,5);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manages`
--

DROP TABLE IF EXISTS `manages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manages` (
  `department_id` int NOT NULL,
  `staff_id` int NOT NULL,
  PRIMARY KEY (`department_id`,`staff_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `manages_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `manages_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `professor` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manages`
--

LOCK TABLES `manages` WRITE;
/*!40000 ALTER TABLE `manages` DISABLE KEYS */;
/*!40000 ALTER TABLE `manages` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor`
--

LOCK TABLES `professor` WRITE;
/*!40000 ALTER TABLE `professor` DISABLE KEYS */;
INSERT INTO `professor` VALUES (2,'Joe Doe','1983-01-01','TENURED',1234567890,'joe.doe@example.com','professor',1),(42,'Rebecca Davis','1975-08-02','TENURE_TRACK',12345678,'rebecca.davis@neu.edu','professor',1),(43,'Jordan Ortiz','1978-06-14','TENURED',23456789,'jordan.ortiz@neu.edu','professor',2),(44,'Shannon Peterson','1982-11-21','NON_TENURE_TRACK',34567890,'shannon.peterson@neu.edu','professor',3),(45,'Megan Cox','1979-02-16','TENURED',45678901,'megan.cox@neu.edu','professor',4),(46,'Benjamin Lee','1985-07-19','TENURE_TRACK',56789012,'benjamin.lee@neu.edu','professor',5),(47,'Samantha Flores','1988-04-26','NON_TENURE_TRACK',67890123,'samantha.flores@neu.edu','professor',6),(48,'Dylan Kim','1972-09-12','TENURED',78901234,'dylan.kim@neu.edu','professor',7),(49,'Emma Ramirez','1976-01-08','TENURE_TRACK',89012345,'emma.ramirez@neu.edu','professor',8),(50,'Cameron Richardson','1981-05-03','NON_TENURE_TRACK',90123456,'cameron.richardson@neu.edu','professor',9),(51,'Hannah Turner','1974-12-27','TENURED',12347890,'hannah.turner@neu.edu','professor',10),(52,'Owen Parker','1983-08-11','TENURE_TRACK',23458901,'owen.parker@neu.edu','professor',11),(53,'Avery Collins','1987-03-24','NON_TENURE_TRACK',34569012,'avery.collins@neu.edu','professor',12),(54,'Isaac Cooper','1977-10-10','TENURED',45670123,'isaac.cooper@neu.edu','professor',13),(55,'Olivia Hernandez','1980-12-04','TENURE_TRACK',56781234,'olivia.hernandez@neu.edu','professor',14),(56,'Levi Ward','1984-06-17','NON_TENURE_TRACK',67892345,'levi.ward@neu.edu','professor',15),(57,'Aria Gonzales','1973-01-22','TENURED',78903456,'aria.gonzales@neu.edu','professor',16),(58,'Ethan Lewis','1979-04-18','TENURE_TRACK',89014567,'ethan.lewis@neu.edu','professor',17),(59,'Chloe Jackson','1986-11-05','NON_TENURE_TRACK',90125678,'chloe.jackson@neu.edu','professor',18),(60,'Landon Wright','1975-02-28','TENURED',12346789,'landon.wright@neu.edu','professor',19),(61,'Lila Chen','1979-12-08','TENURED',85720368,'lchen@northeastern.edu','professor',7),(62,'Michael Scott','1985-06-22','TENURE_TRACK',85721984,'mscott@northeastern.edu','professor',2),(63,'Olivia Johnson','1989-03-15','TENURED',85720467,'ojohnson@northeastern.edu','professor',14),(64,'Ryan Wilson','1981-09-27','NON_TENURE_TRACK',85720185,'rwilson@northeastern.edu','professor',11),(65,'Samantha Lee','1983-07-30','TENURE_TRACK',85720734,'slee@northeastern.edu','professor',8),(66,'Thomas Lee','1976-02-14','TENURED',85720378,'tlee@northeastern.edu','professor',1),(67,'Vanessa Brown','1990-10-11','NON_TENURE_TRACK',85721456,'vbrown@northeastern.edu','professor',3),(68,'William Taylor','1988-05-19','TENURE_TRACK',85720567,'wtaylor@northeastern.edu','professor',13),(69,'Xavier Hernandez','1982-11-18','TENURED',85720127,'xhernandez@northeastern.edu','professor',10),(70,'Yvonne Davis','1977-04-09','NON_TENURE_TRACK',85720899,'ydavis@northeastern.edu','professor',4);
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` VALUES (1,1,1,1),(2,2,1,2),(3,3,1,3),(4,1,2,4),(5,2,2,5),(6,3,2,6),(7,1,3,7),(8,2,3,8),(9,1,4,9),(10,2,4,10),(11,3,4,11),(12,1,5,12),(13,2,5,13),(14,1,6,14),(15,2,6,15),(16,3,6,16),(17,1,7,17),(18,2,7,18),(19,1,8,19),(20,2,8,20),(21,1,9,21),(22,2,9,22),(23,3,9,23),(24,1,10,24),(25,2,10,25),(26,1,1,1),(27,2,1,2),(28,3,1,3),(29,1,2,4),(30,2,2,5),(31,3,2,6),(32,1,3,7),(33,2,3,8),(34,1,4,9),(35,2,4,10),(36,3,4,11),(37,1,5,12),(38,2,5,13),(39,1,6,14),(40,2,6,15),(41,3,6,16),(42,1,7,17),(43,2,7,18),(44,1,8,19),(45,2,8,20),(46,1,9,21),(47,2,9,22),(48,3,9,23),(49,1,10,24),(50,2,10,25);
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semester`
--

DROP TABLE IF EXISTS `semester`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semester` (
  `semester_id` int NOT NULL AUTO_INCREMENT,
  `sem_year` year DEFAULT NULL,
  `term` enum('FALL','SPRING','SUMMER') DEFAULT NULL,
  PRIMARY KEY (`semester_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semester`
--

LOCK TABLES `semester` WRITE;
/*!40000 ALTER TABLE `semester` DISABLE KEYS */;
INSERT INTO `semester` VALUES (1,2023,'FALL'),(2,2023,'SPRING'),(3,2023,'SUMMER');
/*!40000 ALTER TABLE `semester` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slots`
--

DROP TABLE IF EXISTS `slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `slots` (
  `slot_id` int NOT NULL AUTO_INCREMENT,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `slot_status` int DEFAULT '1',
  `advisor_id` int DEFAULT NULL,
  PRIMARY KEY (`slot_id`),
  KEY `advisor_id` (`advisor_id`),
  CONSTRAINT `slots_ibfk_1` FOREIGN KEY (`advisor_id`) REFERENCES `advisor` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slots`
--

LOCK TABLES `slots` WRITE;
/*!40000 ALTER TABLE `slots` DISABLE KEYS */;
INSERT INTO `slots` VALUES (1,'10:00:00','11:00:00',1,2),(2,'11:30:00','12:30:00',1,1),(3,'13:00:00','14:00:00',1,3),(4,'14:30:00','15:30:00',1,5),(5,'16:00:00','17:00:00',1,7),(6,'10:00:00','11:00:00',1,9),(7,'11:30:00','12:30:00',1,8),(8,'13:00:00','14:00:00',1,10),(9,'14:30:00','15:30:00',1,4),(10,'16:00:00','17:00:00',1,6),(11,'10:00:00','11:00:00',1,1),(12,'11:30:00','12:30:00',1,3),(13,'13:00:00','14:00:00',1,2),(14,'14:30:00','15:30:00',1,4),(15,'16:00:00','17:00:00',1,5);
/*!40000 ALTER TABLE `slots` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insert_appointment` AFTER UPDATE ON `slots` FOR EACH ROW BEGIN
    IF NEW.slot_status = 'booked' THEN
        INSERT INTO Appointments (student_id, advisor_id, slot_id, app_status)
        VALUES (SESSION_ID(), NEW.advisor_id, NEW.slot_id, 'pending');
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `student_id` int NOT NULL,
  `student_name` varchar(255) DEFAULT NULL,
  `student_major` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `student_email_id` varchar(255) DEFAULT NULL,
  `class_level` varchar(255) DEFAULT NULL,
  `grade` varchar(10) DEFAULT 'N/A',
  `role` varchar(50) DEFAULT 'student',
  `section_id` int DEFAULT NULL,
  `advisor_id` int DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `section_id` (`section_id`),
  KEY `advisor_id` (`advisor_id`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`advisor_id`) REFERENCES `advisor` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (101,'Amy Smith','Computer Science','2001-01-10','amysmith@gmail.com','Freshman','N/A','student',1,1),(102,'Bob Johnson','Electrical Engineering','2000-05-20','bjohnson@yahoo.com','Sophomore','N/A','student',2,2),(103,'Carla Williams','Psychology','1999-09-15','carlawill@gmail.com','Senior','N/A','student',3,3),(104,'David Lee','Mechanical Engineering','2002-03-02','davidlee@hotmail.com','Junior','N/A','student',1,4),(105,'Emily Chen','Marketing','2001-11-27','echen@yahoo.com','Freshman','N/A','student',2,5),(106,'Frank Rodriguez','Computer Science','2000-08-12','frankrod@gmail.com','Sophomore','N/A','student',3,6),(107,'Grace Kim','Biology','1999-04-19','gracekim@hotmail.com','Senior','N/A','student',1,7),(108,'Henry Nguyen','Chemical Engineering','2002-06-23','hnguyen@gmail.com','Junior','N/A','student',2,8),(109,'Isabella Taylor','English','2001-02-17','isataylor@yahoo.com','Freshman','N/A','student',3,9),(110,'Jack Brown','Finance','2000-10-08','jbrown@hotmail.com','Sophomore','N/A','student',1,10),(111,'Katherine Lee','Computer Science','1999-08-15','katlee@gmail.com','Senior','N/A','student',2,1),(112,'Liam Johnson','Mechanical Engineering','2002-05-23','ljohnson@yahoo.com','Junior','N/A','student',3,2),(113,'Mia Davis','Psychology','2001-01-03','miadavis@gmail.com','Freshman','N/A','student',1,3),(114,'Noah Kim','Electrical Engineering','2000-07-09','nkim@hotmail.com','Sophomore','N/A','student',2,4),(115,'Olivia Garcia','Computer Science','1999-11-12','ogarcia@yahoo.com','Senior','N/A','student',3,5),(116,'Paula Hernandez','Marketing','2002-04-25','phernandez@gmail.com','Junior','N/A','student',1,6),(117,'Quinn Smith','Biology','2001-09-19','qsmith@hotmail.com','Freshman','N/A','student',2,7),(118,'Ryan Nguyen','Chemical Engineering','2000-02-22','rnguyen@yahoo.com','Sophomore','N/A','student',3,8),(119,'Samantha Wilson','English','1999-12-28','swilson@gmail.com','Senior','N/A','student',1,9),(120,'Thomas Brown','Finance','2002-08-04','tbrown@yahoo.com','Junior','N/A','student',2,10),(1019,'Lila Brown','Computer Science','2001-03-09','lilabrown@northeastern.edu','Senior','N/A','student',4,7),(1020,'Ethan Turner','Physics','2002-05-22','ethanturner@northeastern.edu','Freshman','N/A','student',5,6),(1021,'Avery Scott','History','2001-06-16','averyscott@northeastern.edu','Sophomore','N/A','student',6,2),(1022,'Mia Peterson','Chemistry','2000-11-18','miapeterson@northeastern.edu','Junior','N/A','student',7,1),(1023,'Aiden Evans','Computer Engineering','1999-09-04','aidenevans@northeastern.edu','Senior','N/A','student',8,8),(1024,'Grace Martinez','Biology','2002-01-12','gracemartinez@northeastern.edu','Freshman','N/A','student',1,5),(1025,'Lucas Rodriguez','Computer Science','2001-04-23','lucasrodriguez@northeastern.edu','Sophomore','N/A','student',2,9),(1026,'Hannah Flores','Psychology','2000-07-17','hannahflores@northeastern.edu','Junior','N/A','student',3,10),(1027,'Isaac Hernandez','Political Science','2002-08-08','isachernandez@northeastern.edu','Freshman','N/A','student',4,4),(1028,'Olivia Davis','Mathematics','2001-02-11','oliviadavis@northeastern.edu','Senior','N/A','student',5,3),(1029,'David Lewis','Computer Engineering','2000-09-22','davidlewis@northeastern.edu','Junior','N/A','student',6,7),(1030,'Sofia King','Sociology','2002-06-27','sofiaking@northeastern.edu','Sophomore','N/A','student',7,6),(1031,'Jackson Baker','Biochemistry','2001-01-05','jacksonbaker@northeastern.edu','Senior','N/A','student',8,2),(1032,'Chloe Nelson','Computer Science','2002-04-28','chloenelson@northeastern.edu','Freshman','N/A','student',1,1),(1033,'Elijah Carter','Mechanical Engineering','2000-12-07','elijahcarter@northeastern.edu','Junior','N/A','student',2,5),(1034,'Ava Perez','Chemistry','2001-07-01','avaperez@northeastern.edu','Sophomore','N/A','student',3,9),(1035,'Logan Turner','Computer Engineering','2002-02-17','loganturner@northeastern.edu','Freshman','N/A','student',4,10);
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
  `semester_id` int DEFAULT NULL,
  `section_id` int DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `semester_id` (`semester_id`),
  KEY `section_id` (`section_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `teaches_ibfk_1` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`semester_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `teaches_ibfk_2` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `teaches_ibfk_3` FOREIGN KEY (`staff_id`) REFERENCES `professor` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teaches`
--

LOCK TABLES `teaches` WRITE;
/*!40000 ALTER TABLE `teaches` DISABLE KEYS */;
INSERT INTO `teaches` VALUES (1,1,12,53),(2,1,34,67),(3,2,2,42),(4,2,45,50),(5,3,15,60),(6,3,22,55),(7,1,8,48),(8,2,10,66),(9,3,31,44),(10,1,16,57);
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
  `role` enum('student','professor','advisor','club_head') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'jn.mith@example.com','password123','advisor'),(2,'joe.doe@example.com','password123','professor'),(42,'rebecca.davis@neu.edu','password123','professor'),(43,'jordan.ortiz@neu.edu','password123','professor'),(44,'shannon.peterson@neu.edu','password123','professor'),(45,'megan.cox@neu.edu','password123','professor'),(46,'benjamin.lee@neu.edu','password123','professor'),(47,'samantha.flores@neu.edu','password123','professor'),(48,'dylan.kim@neu.edu','password123','professor'),(49,'emma.ramirez@neu.edu','password123','professor'),(50,'cameron.richardson@neu.edu','password123','professor'),(51,'hannah.turner@neu.edu','password123','professor'),(52,'owen.parker@neu.edu','password123','professor'),(53,'avery.collins@neu.edu','password123','professor'),(54,'isaac.cooper@neu.edu','password123','professor'),(55,'olivia.hernandez@neu.edu','password123','professor'),(56,'levi.ward@neu.edu','password123','professor'),(57,'aria.gonzales@neu.edu','password123','professor'),(58,'ethan.lewis@neu.edu','password123','professor'),(59,'chloe.jackson@neu.edu','password123','professor'),(60,'landon.wright@neu.edu','password123','professor'),(61,'lchen@northeastern.edu','password123','professor'),(62,'mscott@northeastern.edu','password123','professor'),(63,'ojohnson@northeastern.edu','password123','professor'),(64,'rwilson@northeastern.edu','password123','professor'),(65,'slee@northeastern.edu','password123','professor'),(66,'tlee@northeastern.edu','password123','professor'),(67,'vbrown@northeastern.edu','password123','professor'),(68,'wtaylor@northeastern.edu','password123','professor'),(69,'xhernandez@northeastern.edu','password123','professor'),(70,'ydavis@northeastern.edu','password123','professor'),(2,'ajohnson@northeastern.edu','password123','advisor'),(3,'blee@northeastern.edu','password123','advisor'),(4,'cbrown@northeastern.edu','password123','advisor'),(5,'dchen@northeastern.edu','password123','advisor'),(6,'edavis@northeastern.edu','password123','advisor'),(7,'ftaylor@northeastern.edu','password123','advisor'),(8,'ghernandez@northeastern.edu','password123','advisor'),(9,'hwilson@northeastern.edu','password123','advisor'),(10,'ijohnson@northeastern.edu','password123','advisor'),(11,'jsmith@northeastern.edu','password123','advisor'),(101,'amysmith@gmail.com','password123','student'),(102,'bjohnson@yahoo.com','password123','student'),(103,'carlawill@gmail.com','password123','student'),(104,'davidlee@hotmail.com','password123','student'),(105,'echen@yahoo.com','password123','student'),(106,'frankrod@gmail.com','password123','student'),(107,'gracekim@hotmail.com','password123','student'),(108,'hnguyen@gmail.com','password123','student'),(109,'isataylor@yahoo.com','password123','student'),(110,'jbrown@hotmail.com','password123','student'),(111,'katlee@gmail.com','password123','student'),(112,'ljohnson@yahoo.com','password123','student'),(113,'miadavis@gmail.com','password123','student'),(114,'nkim@hotmail.com','password123','student'),(115,'ogarcia@yahoo.com','password123','student'),(116,'phernandez@gmail.com','password123','student'),(117,'qsmith@hotmail.com','password123','student'),(118,'rnguyen@yahoo.com','password123','student'),(119,'swilson@gmail.com','password123','student'),(120,'tbrown@yahoo.com','password123','student'),(1019,'lilabrown@northeastern.edu','password123','student'),(1020,'ethanturner@northeastern.edu','password123','student'),(1021,'averyscott@northeastern.edu','password123','student'),(1022,'miapeterson@northeastern.edu','password123','student'),(1023,'aidenevans@northeastern.edu','password123','student'),(1024,'gracemartinez@northeastern.edu','password123','student'),(1025,'lucasrodriguez@northeastern.edu','password123','student'),(1026,'hannahflores@northeastern.edu','password123','student'),(1027,'isachernandez@northeastern.edu','password123','student'),(1028,'oliviadavis@northeastern.edu','password123','student'),(1029,'davidlewis@northeastern.edu','password123','student'),(1030,'sofiaking@northeastern.edu','password123','student'),(1031,'jacksonbaker@northeastern.edu','password123','student'),(1032,'chloenelson@northeastern.edu','password123','student'),(1033,'elijahcarter@northeastern.edu','password123','student'),(1034,'avaperez@northeastern.edu','password123','student'),(1035,'loganturner@northeastern.edu','password123','student');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'university_gp'
--

--
-- Dumping routines for database 'university_gp'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-05 10:49:55
