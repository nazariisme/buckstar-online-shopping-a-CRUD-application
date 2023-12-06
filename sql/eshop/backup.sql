-- MariaDB dump 10.19  Distrib 10.6.5-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: eshop
-- ------------------------------------------------------
-- Server version	10.6.5-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bestallning`
--

DROP TABLE IF EXISTS `bestallning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bestallning` (
  `orderid` int(11) NOT NULL AUTO_INCREMENT,
  `kundid` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted` timestamp NULL DEFAULT NULL,
  `ordered` timestamp NULL DEFAULT NULL,
  `sent` timestamp NULL DEFAULT NULL,
  `antal_rader` int(11) DEFAULT NULL,
  `logid` int(11) DEFAULT NULL,
  `fakturaid` int(11) DEFAULT NULL,
  PRIMARY KEY (`orderid`),
  KEY `kundid` (`kundid`),
  KEY `logid` (`logid`),
  KEY `fakturaid` (`fakturaid`),
  CONSTRAINT `bestallning_ibfk_1` FOREIGN KEY (`kundid`) REFERENCES `kundregistret` (`kundid`),
  CONSTRAINT `bestallning_ibfk_2` FOREIGN KEY (`logid`) REFERENCES `handelselog` (`logid`),
  CONSTRAINT `bestallning_ibfk_3` FOREIGN KEY (`fakturaid`) REFERENCES `faktura` (`fakturaid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bestallning`
--

LOCK TABLES `bestallning` WRITE;
/*!40000 ALTER TABLE `bestallning` DISABLE KEYS */;
INSERT INTO `bestallning` VALUES (1,1,'2022-03-27 13:59:12','2022-03-27 14:00:07',NULL,'2022-03-27 13:59:30','2022-03-27 14:00:07',NULL,NULL,NULL),(2,2,'2022-03-27 13:59:48','2022-03-27 15:03:54',NULL,'2022-03-27 13:59:56','2022-03-27 15:03:54',NULL,NULL,NULL),(3,4,'2022-03-27 14:00:16','2022-03-27 14:00:29','2022-03-27 14:00:29',NULL,NULL,NULL,NULL,NULL),(4,5,'2022-03-27 14:00:43','2022-03-27 14:00:55',NULL,'2022-03-27 14:00:55',NULL,NULL,NULL,NULL),(5,2,'2022-03-27 14:01:28',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `bestallning` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faktura`
--

DROP TABLE IF EXISTS `faktura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faktura` (
  `fakturaid` int(11) NOT NULL AUTO_INCREMENT,
  `produktkod` int(11) DEFAULT NULL,
  `antal` int(11) DEFAULT NULL,
  `totalPris` int(11) DEFAULT NULL,
  PRIMARY KEY (`fakturaid`),
  KEY `produktkod` (`produktkod`),
  CONSTRAINT `faktura_ibfk_1` FOREIGN KEY (`produktkod`) REFERENCES `produkter` (`produktkod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faktura`
--

LOCK TABLES `faktura` WRITE;
/*!40000 ALTER TABLE `faktura` DISABLE KEYS */;
/*!40000 ALTER TABLE `faktura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `handelselog`
--

DROP TABLE IF EXISTS `handelselog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `handelselog` (
  `logid` int(11) NOT NULL AUTO_INCREMENT,
  `orderdatum` date DEFAULT NULL,
  `plockdatum` date DEFAULT NULL,
  `fakturadatum` date DEFAULT NULL,
  PRIMARY KEY (`logid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `handelselog`
--

LOCK TABLES `handelselog` WRITE;
/*!40000 ALTER TABLE `handelselog` DISABLE KEYS */;
/*!40000 ALTER TABLE `handelselog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategorimanager`
--

DROP TABLE IF EXISTS `kategorimanager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kategorimanager` (
  `produktkod` int(11) DEFAULT NULL,
  `kategorinamn` varchar(50) DEFAULT NULL,
  KEY `produktkod` (`produktkod`),
  KEY `kategorinamn` (`kategorinamn`),
  CONSTRAINT `kategorimanager_ibfk_1` FOREIGN KEY (`produktkod`) REFERENCES `produkter` (`produktkod`),
  CONSTRAINT `kategorimanager_ibfk_2` FOREIGN KEY (`kategorinamn`) REFERENCES `produktkategori` (`kategorinamn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategorimanager`
--

LOCK TABLES `kategorimanager` WRITE;
/*!40000 ALTER TABLE `kategorimanager` DISABLE KEYS */;
INSERT INTO `kategorimanager` VALUES (1,'Grand Theft Auto'),(1,'Open World'),(3,'Grand Theft Auto'),(3,'Open World'),(4,'Combat'),(4,'Classic'),(5,'Open World'),(2,'Creative');
/*!40000 ALTER TABLE `kategorimanager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kund`
--

DROP TABLE IF EXISTS `kund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kund` (
  `kundid` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`kundid`),
  CONSTRAINT `kund_ibfk_1` FOREIGN KEY (`kundid`) REFERENCES `kundregistret` (`kundid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kund`
--

LOCK TABLES `kund` WRITE;
/*!40000 ALTER TABLE `kund` DISABLE KEYS */;
/*!40000 ALTER TABLE `kund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kundregistret`
--

DROP TABLE IF EXISTS `kundregistret`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kundregistret` (
  `kundid` int(11) NOT NULL AUTO_INCREMENT,
  `fornamn` varchar(40) DEFAULT NULL,
  `efternamn` varchar(40) DEFAULT NULL,
  `adress` varchar(50) DEFAULT NULL,
  `telefon` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`kundid`),
  KEY `index_namn` (`kundid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kundregistret`
--

LOCK TABLES `kundregistret` WRITE;
/*!40000 ALTER TABLE `kundregistret` DISABLE KEYS */;
INSERT INTO `kundregistret` VALUES (1,'Namn1','Efternamn1','Adress1','Telefonnummer1'),(2,'Namn2','Efternamn2','Adress2','Telefonnummer2'),(3,'Namn3','Efternamn3','Adress3','Telefonnummer3'),(4,'Namn4','Efternamn4','Adress4','Telefonnummer4'),(5,'Namn5','Efternamn5','Adress5','Telefonnummer5');
/*!40000 ALTER TABLE `kundregistret` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lager`
--

DROP TABLE IF EXISTS `lager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lager` (
  `hylla` varchar(20) NOT NULL,
  PRIMARY KEY (`hylla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lager`
--

LOCK TABLES `lager` WRITE;
/*!40000 ALTER TABLE `lager` DISABLE KEYS */;
INSERT INTO `lager` VALUES ('A:101'),('B:101'),('C:101'),('D:101'),('E:101');
/*!40000 ALTER TABLE `lager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lagerhylla`
--

DROP TABLE IF EXISTS `lagerhylla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lagerhylla` (
  `produktkod` int(11) NOT NULL,
  `antal` int(11) DEFAULT NULL,
  `hylla` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`produktkod`),
  KEY `hylla` (`hylla`),
  CONSTRAINT `lagerhylla_ibfk_1` FOREIGN KEY (`produktkod`) REFERENCES `produkter` (`produktkod`),
  CONSTRAINT `lagerhylla_ibfk_2` FOREIGN KEY (`hylla`) REFERENCES `lager` (`hylla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lagerhylla`
--

LOCK TABLES `lagerhylla` WRITE;
/*!40000 ALTER TABLE `lagerhylla` DISABLE KEYS */;
INSERT INTO `lagerhylla` VALUES (1,7,'A:101'),(2,9,'B:101'),(3,0,'C:101'),(4,7,'D:101'),(5,14,'E:101');
/*!40000 ALTER TABLE `lagerhylla` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plocklista`
--

DROP TABLE IF EXISTS `plocklista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plocklista` (
  `plockid` int(11) NOT NULL AUTO_INCREMENT,
  `produktkod` int(11) DEFAULT NULL,
  `kundid` int(11) DEFAULT NULL,
  `orderid` int(11) DEFAULT NULL,
  `antal` int(11) DEFAULT 0,
  PRIMARY KEY (`plockid`),
  KEY `produktkod` (`produktkod`),
  KEY `kundid` (`kundid`),
  KEY `orderid` (`orderid`),
  CONSTRAINT `plocklista_ibfk_1` FOREIGN KEY (`produktkod`) REFERENCES `produkter` (`produktkod`),
  CONSTRAINT `plocklista_ibfk_2` FOREIGN KEY (`kundid`) REFERENCES `kundregistret` (`kundid`),
  CONSTRAINT `plocklista_ibfk_3` FOREIGN KEY (`orderid`) REFERENCES `bestallning` (`orderid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plocklista`
--

LOCK TABLES `plocklista` WRITE;
/*!40000 ALTER TABLE `plocklista` DISABLE KEYS */;
INSERT INTO `plocklista` VALUES (1,1,1,1,2),(2,2,1,1,2),(3,3,1,1,4),(4,4,1,1,1),(5,5,1,1,1),(6,1,2,2,1),(7,2,2,2,1),(8,4,2,2,1),(9,3,5,4,4);
/*!40000 ALTER TABLE `plocklista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_log`
--

DROP TABLE IF EXISTS `product_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Tidstampel` timestamp NOT NULL DEFAULT current_timestamp(),
  `Handelse` varchar(50) DEFAULT NULL,
  `Produktnamn` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_log`
--

LOCK TABLES `product_log` WRITE;
/*!40000 ALTER TABLE `product_log` DISABLE KEYS */;
INSERT INTO `product_log` VALUES (1,'2022-03-27 13:58:58','A new product was added','Vice City'),(2,'2022-03-27 13:58:58','A new product was added','Sims'),(3,'2022-03-27 13:58:58','A new product was added','San Andreas'),(4,'2022-03-27 13:58:58','A new product was added','Call of Duty'),(5,'2022-03-27 13:58:58','A new product was added','Zelda');
/*!40000 ALTER TABLE `product_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produkter`
--

DROP TABLE IF EXISTS `produkter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkter` (
  `produktkod` int(11) NOT NULL AUTO_INCREMENT,
  `namn` varchar(20) DEFAULT NULL,
  `beskrivning` varchar(200) DEFAULT NULL,
  `pris` int(11) DEFAULT NULL,
  PRIMARY KEY (`produktkod`),
  KEY `namn_index` (`namn`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkter`
--

LOCK TABLES `produkter` WRITE;
/*!40000 ALTER TABLE `produkter` DISABLE KEYS */;
INSERT INTO `produkter` VALUES (1,'Vice City','It is fun.',200),(2,'Sims','It is ok.',500),(3,'San Andreas','It is very fun.',150),(4,'Call of Duty','Have not played it.',599),(5,'Zelda','I do not play it.',600);
/*!40000 ALTER TABLE `produkter` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER product_log_insert
AFTER INSERT
ON produkter FOR EACH ROW
	INSERT INTO product_log (Tidstampel, Handelse, Produktnamn)
    VALUES (CURRENT_TIMESTAMP, "A new product was added", NEW.namn) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER product_log_update
AFTER UPDATE
ON produkter FOR EACH ROW
	INSERT INTO product_log (Tidstampel, Handelse, Produktnamn)
    VALUES (CURRENT_TIMESTAMP, "The details were updated.", NEW.namn) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER product_log_delete
AFTER DELETE
ON produkter FOR EACH ROW
	INSERT INTO product_log (Tidstampel, Handelse, Produktnamn)
    VALUES (CURRENT_TIMESTAMP, "The product was deleted.", OLD.namn) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `produktkategori`
--

DROP TABLE IF EXISTS `produktkategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produktkategori` (
  `kategorinamn` varchar(50) NOT NULL,
  PRIMARY KEY (`kategorinamn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produktkategori`
--

LOCK TABLES `produktkategori` WRITE;
/*!40000 ALTER TABLE `produktkategori` DISABLE KEYS */;
INSERT INTO `produktkategori` VALUES ('Classic'),('Combat'),('Creative'),('Grand Theft Auto'),('New Era'),('Open World');
/*!40000 ALTER TABLE `produktkategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'eshop'
--
/*!50003 DROP FUNCTION IF EXISTS `show_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` FUNCTION `show_status`(a_created TIMESTAMP,
    a_updated TIMESTAMP,
    a_deleted TIMESTAMP,
    a_ordered TIMESTAMP,
    a_sent TIMESTAMP
) RETURNS varchar(20) CHARSET utf8mb3
    DETERMINISTIC
BEGIN
	IF a_sent IS NOT NULL THEN
		RETURN 'Shickat';
	ELSEIF a_deleted IS NOT NULL THEN
		RETURN 'Raderat';
	ELSEIF a_ordered IS NOT NULL THEN
		RETURN 'Bestallt';
	ELSEIF a_updated IS NOT NULL THEN
		RETURN 'Uppdaterad';
	ELSEIF a_created IS NOT NULL THEN
		RETURN 'Skapat';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `create_order`(
	a_kundid INT
)
BEGIN
	INSERT INTO
		bestallning (kundid)
	VALUES
		 (a_kundid)
		;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_plocklist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `create_plocklist`(
	a_orderid INT
    )
BEGIN
	SELECT 
		p.orderid AS 'Order ID',
		p.produktkod AS 'Produkt Kod',
		pr.namn AS 'Produkt Namn',
		p.antal AS 'Bestallt Antal',
		(lh.antal + p.antal) AS 'Lager antal',
		lh.hylla AS 'Hyllplats',
        IF((lh.antal + p.antal) - p.antal < 0, 'Slut i Lager', 'Finns i lager') AS 'Lagerstatus'
	FROM plocklista AS p
	JOIN
		lagerhylla AS lh
			ON p.produktkod = lh.produktkod
	JOIN
		produkter AS pr
			ON p.produktkod = pr.produktkod
	WHERE 
		p.orderid = a_orderid
		;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `delete_product`(
	a_produktkod INT
    )
BEGIN
	DELETE FROM 
		produkter
	WHERE 
		produktkod = a_produktkod;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `get_customer`(
	a_kundid INT
)
BEGIN
	SELECT
		kundid AS ID,
        CONCAT(fornamn,' ', efternamn) AS Namn,
        adress AS Adress,
        telefon AS Telefonnummer
	FROM 
		kundregistret
	WHERE
		kundid = a_kundid
        ;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_kund_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `get_kund_id`(
	a_orderid INT)
BEGIN
	SELECT 	
		kundid
	FROM 
		bestallning
	WHERE
		orderid = a_orderid
        ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_order_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `get_order_status`(
	a_orderid int)
BEGIN
	SELECT
        show_status(created, updated, deleted, ordered, sent) AS 'status' 
	FROM
		bestallning AS b
	WHERE 
		orderid = a_orderid
		;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `get_product`(
	a_produktkod INT
    )
BEGIN
	SELECT * FROM produkter
		WHERE produktkod = a_produktkod;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `insert_product`(
	a_produktkod INT,
    a_kundid INT,
	a_orderid INT,
    a_antal INT
)
BEGIN
	INSERT INTO
		plocklista (produktkod, kundid, orderid, antal)
	VALUES (a_produktkod, a_kundid, a_orderid, a_antal);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inv` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `inv`()
BEGIN
	SELECT 
		produkter.produktkod AS Produktkod, 
		produkter.namn AS Namn, 
		lagerhylla.antal AS Antal,
        lagerhylla.hylla AS Hylla
	FROM 
		produkter
	LEFT OUTER JOIN 
		lagerhylla 
			ON produkter.produktkod = lagerhylla.produktkod
		;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `invadd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `invadd`(
	p_kod INT,
    p_number INT,
	p_hylla VARCHAR(20)
    )
BEGIN
	INSERT INTO
		 lagerhylla (produktkod, antal, hylla)
	VALUES 
		(p_kod, p_number, p_hylla)
	ON DUPLICATE KEY UPDATE antal = antal + p_number;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `invdel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `invdel`(
	p_kod INT,
    p_number INT,
	p_hylla VARCHAR(20)
    )
BEGIN
	UPDATE lagerhylla
		SET antal = antal - p_number
	WHERE
		produktkod = p_kod
        AND
        hylla = p_hylla
        ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inv_str` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `inv_str`(
	a_input VARCHAR(200)
)
BEGIN
	SELECT 
		produkter.produktkod AS Produktkod, 
		produkter.namn AS Namn, 
		lagerhylla.antal AS Antal,
        lagerhylla.hylla AS Hylla
	FROM 
		produkter
	LEFT OUTER JOIN 
		lagerhylla 
			ON produkter.produktkod = lagerhylla.produktkod
	WHERE
		produkter.produktkod = a_input
        OR
        produkter.namn LIKE a_input
        OR
        lagerhylla.hylla LIKE a_input
		;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `log_number` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `log_number`(
	a_number INT
    )
BEGIN
	SELECT 
		ID,
        Tidstampel,
        Handelse,
        Produktnamn
    FROM product_log
    ORDER BY Tidstampel DESC
    LIMIT a_number;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `product`()
BEGIN
	SELECT 
		produktkod AS Produktkod,
        namn AS Namn,
        beskrivning AS Beskrivning,
        pris AS Pris
	FROM 
		produkter
        ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `shelf` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `shelf`()
BEGIN
	SELECT 
		hylla AS Hylla
	FROM 
		lager
        ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ship_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `ship_order`(
	a_orderid INT
    )
BEGIN
	UPDATE
		bestallning
	SET
		sent = CURRENT_TIMESTAMP
	WHERE 
		orderid = a_orderid
		;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_a_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_a_order`(
	a_orderid int)
BEGIN
	SELECT
		b.orderid,
		CONCAT(k.fornamn, ' ', k.efternamn) AS kundnamn,
		pr.*,
		p.antal,
        b.kundid,
        show_status(created, updated, deleted, ordered, sent) AS 'status' 
	FROM
		bestallning AS b
	JOIN
		plocklista AS p
			ON  p.orderid = b.orderid 
	JOIN
		produkter as pr
			ON p.produktkod = pr.produktkod
	JOIN 
		kundregistret AS k
			ON p.kundid = k.kundid
	WHERE 
		p.orderid = a_orderid
		;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_a_order_terminal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_a_order_terminal`(
	a_orderid INT
)
BEGIN
	SELECT DISTINCT
	b.orderid 'Order ID',
	b.kundid 'Kund ID',
    CONCAT(k.fornamn,' ', k.efternamn) AS Namn,
	IF(created IS NOT NULL, created, '') AS Datum,
    count(p.orderid)  AS Antal,
	show_status(created, updated, deleted, ordered, sent) AS 'Status' 
	FROM 
		 bestallning AS b
	LEFT JOIN
		kundregistret AS k
			ON k.kundid = b.kundid 
	LEFT JOIN
		plocklista AS p
			ON b.orderid = p.orderid
	WHERE 
		b.orderid = a_orderid
        OR
		b.kundid = a_orderid
    GROUP BY
		b.orderid
	ORDER BY
		b.orderid DESC
        ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_category` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_category`()
BEGIN 
	SELECT * FROM produktkategori AS Kategori;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_customer`()
BEGIN
	SELECT
		kundid AS ID,
        CONCAT(fornamn,' ', efternamn) AS Namn,
        adress AS Adress,
        telefon AS Telefonnummer
	FROM 
		kundregistret;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_order`()
BEGIN
	SELECT DISTINCT
	b.orderid ,
	b.kundid ,
    CONCAT(k.fornamn,' ', k.efternamn) AS namn,
	IF(created IS NOT NULL, created, '') AS datum,
    count(p.orderid)  AS antal,
	show_status(created, updated, deleted, ordered, sent) AS 'status' 
	FROM 
		 bestallning AS b
	LEFT JOIN
		kundregistret AS k
			ON k.kundid = b.kundid 
	LEFT JOIN
		plocklista AS p
			ON b.orderid = p.orderid
	GROUP BY
		b.orderid
	ORDER BY
		b.orderid DESC
        ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_order_terminal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_order_terminal`()
BEGIN
	SELECT DISTINCT
	b.orderid 'Order ID',
	b.kundid 'Kund ID',
    CONCAT(k.fornamn,' ', k.efternamn) AS Namn,
	IF(created IS NOT NULL, created, '') AS Datum,
    count(p.orderid)  AS Antal,
	show_status(created, updated, deleted, ordered, sent) AS 'Status' 
	FROM 
		 bestallning AS b
	LEFT JOIN
		kundregistret AS k
			ON k.kundid = b.kundid 
	LEFT JOIN
		plocklista AS p
			ON b.orderid = p.orderid
	GROUP BY
		b.orderid
	ORDER BY
		b.orderid DESC
        ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_product`()
BEGIN
	SELECT 
		produkter.produktkod AS Produktkod, 
		produkter.namn AS Namn,
		produkter.beskrivning AS Beskrivning, 
		produkter.pris AS Pris, 
		IF (lagerhylla.antal = 0, 'Slut i lager', lagerhylla.antal) AS Antal,
	GROUP_CONCAT(DISTINCT kategorimanager.kategorinamn) AS Kategori
	FROM 
		produkter
	LEFT OUTER JOIN 
		lagerhylla 
			ON produkter.produktkod = lagerhylla.produktkod
	LEFT OUTER JOIN
		kategorimanager
			ON produkter.produktkod = kategorimanager.produktkod
	GROUP BY
		produkter.produktkod
		;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `update_order`(
	a_orderid INT,
    a_kundid INT
)
BEGIN
	UPDATE 
		bestallning
	SET 
		ordered = current_timestamp
	WHERE
		kundid = a_kundid
        AND
        orderid = a_orderid
        ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `update_product`(
	a_produktkod INT,
    a_namn VARCHAR(20),
    a_beskrivning VARCHAR(200),
    a_pris INT
    )
BEGIN
	UPDATE produkter
		SET namn = a_namn, beskrivning = a_beskrivning, pris = a_pris
	WHERE produktkod = a_produktkod;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `uppdate_lager_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `uppdate_lager_status`(
	a_antal INT,
    a_produktkod INT
)
BEGIN
	UPDATE 
		lagerhylla
		SET 
			antal = antal - a_antal
	WHERE 
		produktkod = a_produktkod
        ;
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

-- Dump completed on 2022-03-27 16:09:41
