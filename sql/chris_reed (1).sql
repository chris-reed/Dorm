CREATE DATABASE  IF NOT EXISTS `chris_reed` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `chris_reed`;
-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: chris_reed
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `dormitories`
--

DROP TABLE IF EXISTS `dormitories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dormitories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `total_units` int(11) DEFAULT '16',
  `units_per_floor` int(11) DEFAULT '4',
  `rooms_per_unit` int(11) DEFAULT '4',
  `students_per_room` int(11) DEFAULT '2',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dormitories`
--

LOCK TABLES `dormitories` WRITE;
/*!40000 ALTER TABLE `dormitories` DISABLE KEYS */;
INSERT INTO `dormitories` VALUES (1,'Green Run Hall',16,4,4,2),(2,'Towers',16,4,4,2);
/*!40000 ALTER TABLE `dormitories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_assignments`
--

DROP TABLE IF EXISTS `room_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `dormitory_id` int(11) NOT NULL,
  `unit` int(11) NOT NULL,
  `room` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_id_UNIQUE` (`student_id`),
  KEY `student_id_idx` (`student_id`) /*!80000 INVISIBLE */,
  KEY `dormitory_id_idx` (`dormitory_id`),
  CONSTRAINT `dormitory_id` FOREIGN KEY (`dormitory_id`) REFERENCES `dormitories` (`id`),
  CONSTRAINT `student_id` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_assignments`
--

LOCK TABLES `room_assignments` WRITE;
/*!40000 ALTER TABLE `room_assignments` DISABLE KEYS */;
INSERT INTO `room_assignments` VALUES (1,1,1,1,1),(2,2,1,2,1),(3,3,1,3,1),(4,4,1,4,1),(5,5,1,5,1),(6,6,1,6,1),(7,7,1,7,1),(8,8,1,8,1),(9,9,1,9,1),(10,10,1,10,1),(11,11,1,11,1),(12,12,1,12,1),(13,13,1,13,1),(14,14,1,14,1),(15,15,1,15,1),(16,16,1,16,1),(17,17,2,1,1),(18,18,2,2,1),(19,19,2,3,1),(20,20,2,4,1),(21,21,2,5,1),(22,22,2,6,1),(23,23,2,7,1),(24,24,2,8,1),(25,25,2,9,1),(26,26,2,10,1),(27,27,2,11,1),(28,28,2,12,1),(29,29,2,13,1),(30,30,2,14,1),(31,31,2,15,1),(32,32,2,16,1),(33,38,1,6,1),(34,39,1,7,1),(35,42,1,10,1),(36,44,1,12,1),(37,45,1,13,1),(38,46,1,14,1),(39,47,1,15,1),(40,48,1,16,1),(41,50,1,2,1),(42,51,1,3,1),(43,52,1,4,1),(44,53,1,5,1),(45,54,1,6,2),(46,56,1,8,1),(47,58,1,10,2),(48,59,1,11,1),(49,60,1,12,2),(50,62,1,14,2),(51,65,2,1,1),(52,66,1,2,2),(53,70,1,6,2),(54,71,1,7,2),(55,75,1,11,2),(56,76,1,12,2),(57,78,1,14,2),(58,79,1,15,2),(59,80,1,16,2),(60,81,2,1,2),(61,82,1,2,2),(62,83,1,3,2),(63,85,1,5,2),(64,86,1,6,3),(65,87,1,7,2),(66,89,1,9,1),(67,91,1,11,2),(68,93,1,13,2),(69,94,1,14,3),(70,95,1,15,2),(71,96,1,16,2),(72,100,1,4,2),(73,101,1,5,2),(74,105,1,9,2),(75,107,1,11,3),(76,108,1,12,3),(77,111,1,15,3),(78,113,2,1,2),(79,114,1,2,3),(80,115,1,3,2),(81,118,1,6,3),(82,119,1,7,3),(83,120,1,8,2),(84,121,1,9,2),(85,123,1,11,3),(86,125,1,13,2),(87,127,1,15,3),(88,130,1,2,3),(89,131,1,3,3),(90,136,1,8,2),(91,137,1,9,3),(92,138,1,10,2),(93,145,2,1,3),(94,146,1,2,4),(95,148,1,4,2),(96,150,1,6,4),(98,33,1,2,4),(100,34,1,1,1),(101,35,1,1,2),(102,36,1,3,3),(103,37,1,3,4),(104,40,1,3,4),(105,41,1,1,2),(106,43,1,6,4),(107,49,1,7,3),(108,55,1,1,3),(109,57,1,1,3),(110,61,1,1,4),(111,63,1,1,4),(112,64,1,4,3),(113,67,1,4,3),(114,68,1,7,4),(115,69,1,7,4),(116,72,1,9,3),(117,73,1,4,4),(118,74,1,4,4),(119,77,1,5,3),(120,84,1,9,4),(121,88,1,9,4),(122,90,1,5,3),(123,92,1,10,3),(124,97,1,10,3),(125,98,1,5,4),(126,99,1,5,4),(127,102,1,8,3),(128,103,1,8,3),(129,104,1,10,4),(130,106,1,8,4),(131,109,1,8,4),(132,110,1,11,4),(133,112,1,11,4),(134,116,1,10,4),(135,117,1,13,3),(136,122,1,12,3),(137,124,1,13,3),(138,126,1,12,4),(139,128,1,12,4),(140,129,1,13,4),(141,132,1,13,4),(142,133,1,14,3),(143,134,2,1,3),(144,135,2,1,4),(145,139,1,14,4),(146,140,1,14,4),(147,141,2,1,4),(148,142,2,4,1),(149,143,2,4,2),(150,144,2,4,2),(151,147,2,4,3),(152,149,1,15,4);
/*!40000 ALTER TABLE `room_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_name` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `student_id` varchar(45) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(45) NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `students_student_id_uindex` (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'Greatbatch','Barnard','90033126','358 Namekagon Terrace','Ogden','UT','84409','1998-06-28','Male','8018722120'),(2,'Titmus','Malia','33290465','573 Sage Plaza','Wichita','KS','67230','1998-02-23','Female','3169920805'),(3,'Lipson','Kiri','82581281','80730 Caliangt Trail','Washington','DC','20078','1998-05-19','Female','2027054655'),(4,'Hamm','Dieter','57554311','4777 Eastwood Avenue','El Paso','TX','88546','1996-09-06','Male','9152667061'),(5,'Moen','Teodoor','28832579','557 Lotheville Alley','Trenton','NJ','08695','1998-06-26','Male','6092904394'),(6,'Bruyet','Theressa','37369667','7 Derek Park','Salt Lake City','UT','84170','1999-05-17','Female','8017316520'),(7,'Pinching','Tine','99831185','7808 Rieder Hill','Houston','TX','77223','1998-07-17','Female','7131076414'),(8,'Gumme','Cesar','79964113','39 Village Green Court','Dallas','TX','75358','1999-04-15','Male','2146763932'),(9,'Goodlad','Coraline','42045910','13606 Esker Trail','Wichita','KS','67260','2001-06-07','Female','3164883316'),(10,'Lunbech','Star','17557530','249 Michigan Center','San Francisco','CA','94132','1999-09-16','Female','4155719185'),(11,'Reicherz','Cy','01391128','6969 Rieder Road','Salem','OR','97306','1999-04-10','Male','5034414024'),(12,'Plevey','Myer','12944457','6 Ridgeview Lane','Portland','OR','97206','1998-07-25','Male','5031906046'),(13,'Lomasney','Jo-anne','45366692','2 Grover Junction','Tacoma','WA','98481','1995-03-01','Female','2537102557'),(14,'Crowest','Eunice','54933847','887 Dexter Way','Evansville','IN','47737','1998-05-25','Female','8127715024'),(15,'Dunklee','Esmaria','25788381','4 Maple Circle','San Bernardino','CA','92405','1995-01-02','Female','9096868159'),(16,'Calbrathe','Jillane','82083921','5 Anzinger Avenue','Gaithersburg','MD','20883','1999-10-09','Female','2402754073'),(17,'Lansdale','Cece','15353852','43924 Fair Oaks Park','Shawnee Mission','KS','66276','1998-07-11','Male','9137516709'),(18,'O\'Crowley','Leontine','72066030','9018 Hollow Ridge Avenue','Edmond','OK','73034','2001-07-08','Female','4051726422'),(19,'Holhouse','Luisa','65233338','10 Northview Road','Dallas','TX','75205','1995-03-03','Female','9729282676'),(20,'Redgrove','Pryce','41652474','054 Green Avenue','Nashville','TN','37205','1996-01-12','Male','6157430020'),(21,'Greenman','Perl','94643380','8 Pennsylvania Drive','Alexandria','VA','22333','1995-07-06','Female','5715874252'),(22,'Arsey','Lianne','90781023','1975 Sunbrook Place','Pittsburgh','PA','15250','1996-08-31','Female','4121967217'),(23,'Cardoo','Loralie','82668345','2 Rieder Way','Augusta','GA','30905','1995-02-19','Female','7065413370'),(24,'Phlippsen','Ardath','02578373','5 Debs Point','Arlington','TX','76004','1996-09-13','Female','8177235805'),(25,'Piscopiello','Sandy','31602294','694 Utah Park','Sioux Falls','SD','57105','1996-03-25','Female','6054300812'),(26,'Huff','Austin','18531236','742 Killdeer Street','Raleigh','NC','27605','1999-02-25','Male','9192568223'),(27,'Astridge','Lorianna','06216697','1029 Melby Way','Jamaica','NY','11431','2000-12-02','Female','2123507857'),(28,'Wooles','Alisa','60717742','811 Corben Avenue','Houston','TX','77260','2000-05-01','Female','7139938413'),(29,'Gabala','Eartha','89279614','10255 Valley Edge Place','Lansing','MI','48930','2001-10-17','Female','5174835632'),(30,'Tapsell','Friedrick','08489342','8 Rowland Drive','Sacramento','CA','94250','2001-03-31','Male','9163049979'),(31,'Adnam','Erek','19033443','5 Nobel Place','Pittsburgh','PA','15279','1999-05-22','Male','4122817503'),(32,'William','Bari','36310755','699 Raven Drive','Miami','FL','33180','1995-12-01','Female','7861932510'),(33,'Yonnie','Ginny','32557443','90 Becker Place','Fort Pierce','FL','34949','1996-08-27','Female','7722340029'),(34,'Dalliston','Tyson','95721701','0 Ryan Point','Monticello','MN','55590','1998-03-11','Male','7632614730'),(35,'Matthisson','Roscoe','03559549','32 Scoville Court','Charlotte','NC','28256','1998-02-07','Male','7046648692'),(36,'Boss','Sidoney','76822467','199 Oxford Parkway','Lincoln','NE','68510','1998-01-19','Female','4024691248'),(37,'Connichie','Elenore','18382148','908 Amoth Point','New York City','NY','10275','2001-11-20','Female','2124263037'),(38,'Pomfrett','Valera','15571067','9 Esker Circle','Shreveport','LA','71166','2000-10-27','Female','3187751750'),(39,'Watters','Charita','48890694','186 Novick Lane','Shreveport','LA','71137','1998-11-18','Female','3187183095'),(40,'O\'Neal','Darbie','03984545','577 Prentice Plaza','Arlington','TX','76011','1995-02-09','Female','8175901452'),(41,'Monkton','Lowe','17373381','8602 Hagan Center','New Orleans','LA','70149','2000-01-21','Male','5042984185'),(42,'MacDougal','Hermine','07737597','84570 Gina Way','Fort Collins','CO','80525','1997-09-04','Female','9702994421'),(43,'Rosekilly','Evangelin','27886589','27687 Forest Hill','Des Moines','IA','50362','1995-10-01','Female','5153079330'),(44,'Ceschelli','Barnie','80773842','6 Hoepker Crossing','Fort Worth','TX','76178','1995-08-30','Male','6822761991'),(45,'Chamberlen','Katharina','74031377','78184 Lighthouse Bay Road','Springfield','IL','62705','1996-02-14','Female','2178156643'),(46,'Dumbreck','Carie','81667955','850 Del Sol Point','Bronx','NY','10454','1997-10-30','Female','7188610775'),(47,'MacGilrewy','Missie','09239120','386 Nancy Plaza','Denver','CO','80241','1999-12-07','Female','7204059331'),(48,'Peron','Melody','92482079','99389 Hoepker Circle','Youngstown','OH','44511','1995-03-15','Female','3302381488'),(49,'de Keep','Nancey','79671961','5993 Cherokee Plaza','Houston','TX','77250','1999-07-20','Female','7134279183'),(50,'McIlwraith','Darsey','04908746','12871 Autumn Leaf Center','Lancaster','PA','17622','1998-08-16','Female','7174132077'),(51,'Leithgoe','Wylma','48276571','28053 Gulseth Park','Charlotte','NC','28205','1995-10-05','Female','7042870165'),(52,'Bentsen','Silvan','99422666','51 Larry Crossing','Trenton','NJ','08650','1997-10-25','Male','6094316254'),(53,'Bartlam','Vite','46104182','62777 Heffernan Hill','Charlotte','NC','28242','1997-07-11','Male','7045454234'),(54,'Kenwin','Letitia','09410704','0265 Sachtjen Alley','Waterbury','CT','06705','1995-02-21','Female','2036043977'),(55,'Boodle','Corby','50845763','4358 Ryan Place','Dayton','OH','45440','1999-01-14','Male','9372420863'),(56,'Romanin','Dan','16401758','8 Longview Park','Waterbury','CT','06721','2001-12-11','Male','2035513788'),(57,'Linguard','Gabriello','65727791','105 Acker Drive','Loretto','MN','55598','1997-12-24','Male','7636799227'),(58,'Ferreli','Sophey','10511616','40 Forest Dale Alley','Oakland','CA','94627','1996-03-13','Female','5106434974'),(59,'Sugar','Abby','41747404','823 Michigan Plaza','Tulsa','OK','74116','1998-05-13','Male','9189155347'),(60,'Greendale','Gifford','85437625','516 Dakota Street','Whittier','CA','90610','1995-06-17','Male','5627755153'),(61,'Jenteau','Gilburt','72047450','4 Sutherland Hill','Indianapolis','IN','46295','1995-04-10','Male','3176821186'),(62,'Kamena','Eirena','40346786','0 Elka Trail','Saint Petersburg','FL','33710','1995-06-27','Female','7276189477'),(63,'Rubens','Harold','32481717','324 Stephen Point','Hialeah','FL','33013','1996-04-13','Male','3054726247'),(64,'Mitroshinov','Andrew','36066037','157 Surrey Pass','Tampa','FL','33615','1999-04-05','Male','8132794903'),(65,'Gayton','Cass','61982812','85197 Scofield Alley','Las Vegas','NV','89155','2001-02-18','Male','7024128655'),(66,'Bunclark','Rina','62402325','514 Mccormick Lane','Charleston','SC','29416','2000-05-02','Female','8432096838'),(67,'Belleny','Townsend','78310347','2958 Bartelt Pass','Naperville','IL','60567','1995-01-13','Male','6301388702'),(68,'Diack','Lynna','19652970','93933 Sutteridge Place','Los Angeles','CA','90081','1998-06-04','Female','2131431165'),(69,'Luckings','Noelyn','38073780','684 Algoma Street','Huntington','WV','25775','1999-11-09','Female','3042717777'),(70,'Poulgreen','Kakalina','27937236','9 Cordelia Junction','Seattle','WA','98175','1996-12-24','Female','2063412775'),(71,'Clarridge','Cornela','15837852','52880 Reindahl Place','Arlington','VA','22244','1997-06-21','Female','5711120042'),(72,'Giveen','Dione','13949856','95432 School Place','Jackson','MS','39282','2001-07-06','Female','6012810021'),(73,'Elliman','Erl','07227652','538 Homewood Alley','Inglewood','CA','90305','1997-08-31','Male','3232211603'),(74,'Walcher','Kendell','29719770','74517 Portage Avenue','Fullerton','CA','92640','1997-08-09','Male','5598403900'),(75,'Godlip','Eamon','69903465','17 Forest Dale Terrace','Katy','TX','77493','1998-03-03','Male','2819742280'),(76,'Seager','Everett','70780583','2432 Cordelia Avenue','Colorado Springs','CO','80905','2001-10-29','Male','7199234140'),(77,'Cleminshaw','Peadar','22131045','0019 Londonderry Lane','Newport News','VA','23612','1995-05-27','Male','7579453171'),(78,'Warfield','Sallee','99355946','1 Armistice Court','Denver','CO','80299','1998-12-17','Female','7208351174'),(79,'Archdeacon','Daniella','87713960','71 Northwestern Center','Cleveland','OH','44130','1998-02-17','Female','2162458173'),(80,'Sorsbie','Bella','12359147','9 Melvin Court','Portland','OR','97286','1999-06-27','Female','5031621052'),(81,'Delap','Rudd','37520483','4216 Roth Way','Savannah','GA','31405','1995-10-25','Male','9121833983'),(82,'Currell','Amil','30156889','078 Eggendart Court','Mobile','AL','36689','1995-02-13','Female','2516530424'),(83,'Reinbeck','Helsa','21692764','9 Russell Park','Honolulu','HI','96820','1995-11-24','Female','8087971106'),(84,'Lockier','Nancy','49205724','1989 Fuller Point','Baton Rouge','LA','70805','2000-11-22','Female','2252237039'),(85,'Lippiello','Zachariah','76142731','9189 Comanche Parkway','Mesa','AZ','85205','1998-07-19','Male','6022223785'),(86,'Simonou','Sandi','47851100','4 Bluestem Drive','Durham','NC','27710','1997-04-23','Female','9195625275'),(87,'Woolf','Korney','73014941','81 Mendota Road','Birmingham','AL','35215','1998-04-28','Female','2055943118'),(88,'Addis','Zandra','96990099','897 Valley Edge Drive','Phoenix','AZ','85077','1999-11-27','Female','6024234058'),(89,'Dorant','Dacie','06914794','72939 Westend Way','Indianapolis','IN','46207','1999-07-23','Female','3178934316'),(90,'Barzen','Humbert','87746886','0 Swallow Trail','Olympia','WA','98506','1995-03-03','Male','3609575536'),(91,'Buttriss','Innis','70740574','6 Debs Circle','Roanoke','VA','24020','1996-06-16','Male','5405311595'),(92,'Aspland','Maryl','32995137','61 Dovetail Avenue','Oakland','CA','94605','1998-09-28','Female','5109248575'),(93,'Caroline','Astrid','90291593','01 Green Lane','Louisville','KY','40233','1997-02-15','Female','5023878033'),(94,'Ketchen','Trudie','63963495','87581 Gina Alley','Amarillo','TX','79165','1998-02-01','Female','8067533412'),(95,'Bartaloni','Druci','70183359','51 Green Crossing','Irvine','CA','92612','1998-02-27','Female','9495934858'),(96,'Vassman','Lacy','29684477','40 Quincy Trail','Sioux Falls','SD','57105','2000-03-16','Female','6056237107'),(97,'Creech','Lucina','29591770','64477 Barby Place','Las Vegas','NV','89140','1999-12-06','Female','7023968652'),(98,'MacNeilley','Bartholomeo','37292261','15356 Nevada Junction','Dallas','TX','75353','1998-10-23','Male','2146435710'),(99,'McLugish','Hermon','58517519','1425 Cardinal Park','Phoenix','AZ','85099','1998-08-25','Male','6028365324'),(100,'Rickardes','Chick','78154590','48 La Follette Place','Omaha','NE','68164','2001-03-06','Male','4028140811'),(101,'Brinklow','Nichole','20706965','9 Susan Alley','Buffalo','NY','14225','1997-07-09','Male','7165722147'),(102,'Kilmurray','Devy','20023220','4 Dahle Court','Duluth','MN','55811','1998-11-19','Male','2181285806'),(103,'Braznell','Binky','31256914','4579 Dakota Center','Washington','DC','20557','1998-12-21','Male','2028129818'),(104,'Maddra','Mandie','22429516','4 Glacier Hill Crossing','Raleigh','NC','27658','1997-12-01','Female','9193127884'),(105,'Camilio','Kimmie','91226506','541 Declaration Junction','Baltimore','MD','21282','1998-10-09','Female','4105063013'),(106,'Levinge','Corey','48565727','9679 Prairieview Road','Tampa','FL','33625','1995-02-24','Male','7272042320'),(107,'Stockport','Rodolfo','83227257','5536 Jenna Parkway','Henderson','NV','89012','2001-01-28','Male','7026239598'),(108,'Corness','Warde','52373784','43 Northland Crossing','Fredericksburg','VA','22405','1997-03-24','Male','5402673678'),(109,'Emer','Leon','15585988','41 Sloan Hill','Fort Wayne','IN','46825','2000-05-14','Male','2601558335'),(110,'Peck','Tanney','38492449','7284 Washington Drive','Jacksonville','FL','32220','1998-12-05','Male','9049024449'),(111,'Narrie','Kitti','31762014','52934 Erie Park','Sioux Falls','SD','57193','1999-07-21','Female','6059148515'),(112,'Hamsher','Conrade','48699346','54197 Schiller Alley','Vancouver','WA','98687','1998-07-08','Male','3607171117'),(113,'Rawsthorne','Barri','63497803','2285 Heath Street','Fort Worth','TX','76110','1995-09-09','Male','8171067984'),(114,'Gosnoll','Doro','78979743','86 Tony Drive','Phoenix','AZ','85045','1995-09-10','Female','4801537936'),(115,'Rudland','Amity','27129143','9131 Prairie Rose Drive','Tallahassee','FL','32304','1998-11-06','Female','8508077252'),(116,'Domleo','Cherlyn','81366121','73 Colorado Center','Denver','CO','80223','1999-06-05','Female','3032665406'),(117,'Petters','Ellynn','10226961','2030 Towne Lane','Cleveland','OH','44118','1996-01-29','Female','2166857163'),(118,'Scupham','Marge','65431623','73748 Glacier Hill Pass','Houston','TX','77288','1997-11-04','Female','7132148253'),(119,'Nafzger','Marlene','07477002','744 Service Court','San Angelo','TX','76905','2001-04-05','Female','3257619002'),(120,'McCrudden','Lance','54311900','999 Fieldstone Court','Young America','MN','55551','2000-11-03','Male','9529920125'),(121,'Vigurs','Lizette','70358097','01 Buhler Trail','Roanoke','VA','24009','2001-06-05','Female','5409267853'),(122,'Artinstall','Marv','16999185','392 Delaware Place','Tulsa','OK','74170','2000-02-08','Male','9186977005'),(123,'Garrettson','Warden','43566486','3 Laurel Lane','San Antonio','TX','78215','2000-10-22','Male','2108741109'),(124,'Mawdsley','Benny','54062854','483 West Hill','Milwaukee','WI','53205','1998-03-04','Female','9203859808'),(125,'MacLardie','Sallie','85266778','0 Comanche Place','San Jose','CA','95133','1999-05-17','Female','4084109887'),(126,'Oneil','Forester','78024955','33222 Huxley Avenue','Springfield','IL','62756','1996-10-11','Male','2176552596'),(127,'Wolfinger','Janetta','81606108','1 Hallows Place','Spring','TX','77388','2001-04-08','Female','2813890931'),(128,'Shimmings','Graehme','82664997','600 Darwin Place','Stockton','CA','95210','1996-11-09','Male','2092008580'),(129,'Hancox','Ernestine','08704871','7456 Northport Hill','Dulles','VA','20189','2001-07-22','Female','5714424345'),(130,'Wondraschek','Ursula','02195555','9866 Pond Avenue','Newark','NJ','07195','1996-05-24','Female','8626925762'),(131,'Stonehewer','Viki','74131519','94107 Lighthouse Bay Point','Shawnee Mission','KS','66225','1998-01-12','Female','9133573687'),(132,'Bain','Sean','01486620','263 John Wall Point','San Diego','CA','92132','1999-12-14','Female','8589392408'),(133,'Churms','Frannie','72292901','017 Delaware Circle','Orlando','FL','32830','1999-01-17','Female','4076752076'),(134,'Turfus','Carlie','53257947','2 Scott Terrace','Portland','OR','97211','1998-05-21','Male','5037526244'),(135,'Cometto','Merry','11511486','0018 Grasskamp Crossing','Helena','MT','59623','1997-01-19','Male','4066593847'),(136,'Bisacre','Randi','69412694','04594 Hoffman Street','Spartanburg','SC','29305','1997-08-27','Male','8646731873'),(137,'Wescott','Minna','36211816','8945 Utah Trail','Nashville','TN','37250','2000-11-09','Female','6157595512'),(138,'Florence','Sharla','10866374','21972 Reinke Point','Shawnee Mission','KS','66220','1995-09-25','Female','9136742717'),(139,'Cleve','Christy','73673544','50479 Myrtle Crossing','Amarillo','TX','79118','2000-10-01','Female','8067010720'),(140,'Duesberry','Raphaela','56385951','44337 Kings Crossing','Littleton','CO','80126','1997-07-08','Female','7203138395'),(141,'de Guerre','Bord','78868592','37190 Mccormick Court','Miami','FL','33158','2000-02-29','Male','3057981246'),(142,'Abramin','Gardener','85053406','823 Sullivan Place','Kansas City','MO','64114','1997-10-17','Male','8163741849'),(143,'Von Salzberg','Tate','42558036','8 Waubesa Drive','Houston','TX','77293','1999-03-03','Male','2812151660'),(144,'Reubel','Zeke','93060992','8 Sutherland Circle','Kansas City','KS','66160','1997-09-04','Male','9137792391'),(145,'Gajewski','Bryon','75692869','8677 Sutherland Junction','Shreveport','LA','71105','1995-12-24','Male','3185564844'),(146,'Mirams','Ashla','54271214','2067 Thackeray Point','Fort Lauderdale','FL','33305','1995-07-27','Female','9542066582'),(147,'Handy','Wake','85028497','9450 Del Mar Trail','Pensacola','FL','32505','2001-06-14','Male','8509185146'),(148,'Beacock','Rolland','46078144','6 Di Loreto Hill','Saint Louis','MO','63121','1995-03-22','Male','3147823539'),(149,'Saltsberger','Michal','05765265','75 Talmadge Road','Des Moines','IA','50320','1998-11-25','Female','5159771017'),(150,'Dunbabin','Bride','34327428','4975 Buena Vista Trail','Memphis','TN','38197','1996-01-23','Female','9015415838');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-01 18:13:08
