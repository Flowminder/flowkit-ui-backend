-- MySQL dump 10.13  Distrib 8.0.26, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: mysql
-- ------------------------------------------------------
-- Server version	8.0.26-google

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `flowkit_ui_backend`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `flowkit_ui_backend` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `flowkit_ui_backend`;


--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'residents','single_location',1,'https://www.flowgeek.org/methods/calculating-mobility-indicators/residents-indicators','Residents','Residents-class indicators describe long-term (monthly) changes in the number of people whose home location is within each area.','{\"fr\": {\"label\": \"R\\u00e9sidents\", \"description\": \"Les indicateurs relatifs aux r\\u00e9sidents d\\u00e9crivent les variations (mensuelles) \\u00e0 long terme du nombre de personnes dont le lieu de r\\u00e9sidence se trouve dans chaque zone.\"}}'),(2,'relocations','flow',2,'https://www.flowgeek.org/methods/calculating-mobility-indicators/relocation-indicators/','Relocation','Relocation-class indicators describe long-term (monthly) changes in the number of people changing their home location between pairs of areas.','{\"fr\": {\"label\": \"Changement de r\\u00e9sidence\", \"description\": \"Les indicateurs relatifs au changement de r\\u00e9sidence d\\u00e9crivent les variations (mensuelles) \\u00e0 long terme du nombre de personnes qui changent de lieu de r\\u00e9sidence entre des paires de zones.\"}}'),(3,'presence','single_location',3,'https://www.flowgeek.org/methods/calculating-mobility-indicators/presence-indicators/','Presence','Presence-class indicators describe short-term (daily) changes in the number of people who are present within each area.','{\"fr\": {\"label\": \"Pr\\u00e9sence journali\\u00e8re\", \"description\": \"Les indicateurs relatifs \\u00e0 la pr\\u00e9sence d\\u00e9crivent les variations \\u00e0 court terme du nombre de personnes pr\\u00e9sentes dans chaque zone.\"}}'),(4,'movements','flow',4,'https://www.flowgeek.org/methods/calculating-mobility-indicators/movement-indicators','Movements','Movements-class indicators describe short-term changes in the number of people who are travelling into, out of and between areas.','{\"fr\": {\"label\": \"Mouvements journaliers\", \"description\": \"Les indicateurs relatifs aux mouvements d\\u00e9crivent les variations \\u00e0 court terme du nombre de personnes qui se d\\u00e9placent vers, depuis et entre les zones.\"}}');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `data_provider`
--

LOCK TABLES `data_provider` WRITE;
/*!40000 ALTER TABLE `data_provider` DISABLE KEYS */;
INSERT INTO `data_provider` VALUES (1,1,'Digicel Haiti','https://www.digicelgroup.com/etc.clientlibs/digicel-redesign/clientlibs/dg_base/resources/digicel-mobile-selected.svg','https://www.digicelgroup.com',NULL);
/*!40000 ALTER TABLE `data_provider` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `flow_data_movements.abnormality_129`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.abnormality_129` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4263 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.abnormality_129`
--

LOCK TABLES `flow_data_movements.abnormality_129` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.abnormality_129` DISABLE KEYS */;
INSERT INTO `flow_data_movements.abnormality_129` VALUES (1,129,'HT0111-01','HT0111-02',-0.540000000);
/*!40000 ALTER TABLE `flow_data_movements.abnormality_129` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.abnormality_130`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.abnormality_130` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4268 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.abnormality_130`
--

LOCK TABLES `flow_data_movements.abnormality_130` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.abnormality_130` DISABLE KEYS */;
INSERT INTO `flow_data_movements.abnormality_130` VALUES (1,130,'HT0111-01','HT0111-02',0.100000000);
/*!40000 ALTER TABLE `flow_data_movements.abnormality_130` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.abnormality_131`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.abnormality_131` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4266 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.abnormality_131`
--

LOCK TABLES `flow_data_movements.abnormality_131` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.abnormality_131` DISABLE KEYS */;
INSERT INTO `flow_data_movements.abnormality_131` VALUES (1,131,'HT0111-01','HT0111-02',-0.080000000);
/*!40000 ALTER TABLE `flow_data_movements.abnormality_131` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.abnormality_132`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.abnormality_132` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4273 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.abnormality_132`
--

LOCK TABLES `flow_data_movements.abnormality_132` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.abnormality_132` DISABLE KEYS */;
INSERT INTO `flow_data_movements.abnormality_132` VALUES (1,132,'HT0111-01','HT0111-02',0.950000000);
/*!40000 ALTER TABLE `flow_data_movements.abnormality_132` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.abnormality_133`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.abnormality_133` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4259 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.abnormality_133`
--

LOCK TABLES `flow_data_movements.abnormality_133` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.abnormality_133` DISABLE KEYS */;
INSERT INTO `flow_data_movements.abnormality_133` VALUES (1,133,'HT0111-01','HT0111-02',-0.430000000);
/*!40000 ALTER TABLE `flow_data_movements.abnormality_133` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.abnormality_134`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.abnormality_134` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4264 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.abnormality_134`
--

LOCK TABLES `flow_data_movements.abnormality_134` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.abnormality_134` DISABLE KEYS */;
INSERT INTO `flow_data_movements.abnormality_134` VALUES (1,134,'HT0111-01','HT0111-02',1.420000000);
/*!40000 ALTER TABLE `flow_data_movements.abnormality_134` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.abnormality_135`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.abnormality_135` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4267 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.abnormality_135`
--

LOCK TABLES `flow_data_movements.abnormality_135` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.abnormality_135` DISABLE KEYS */;
INSERT INTO `flow_data_movements.abnormality_135` VALUES (1,135,'HT0111-01','HT0111-02',0.780000000);
/*!40000 ALTER TABLE `flow_data_movements.abnormality_135` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_122`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_122` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4267 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_122`
--

LOCK TABLES `flow_data_movements.travellers_122` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_122` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_122` VALUES (1,122,'HT0111-01','HT0111-02',5250.000000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_122` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_123`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_123` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4259 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_123`
--

LOCK TABLES `flow_data_movements.travellers_123` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_123` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_123` VALUES (1,123,'HT0111-01','HT0111-02',5180.000000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_123` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_124`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_124` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4263 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_124`
--

LOCK TABLES `flow_data_movements.travellers_124` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_124` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_124` VALUES (1,124,'HT0111-01','HT0111-02',5170.000000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_124` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_125`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_125` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4268 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_125`
--

LOCK TABLES `flow_data_movements.travellers_125` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_125` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_125` VALUES (1,125,'HT0111-01','HT0111-02',5210.000000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_125` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_126`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_126` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4266 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_126`
--

LOCK TABLES `flow_data_movements.travellers_126` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_126` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_126` VALUES (1,126,'HT0111-01','HT0111-02',5200.000000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_126` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_127`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_127` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4264 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_127`
--

LOCK TABLES `flow_data_movements.travellers_127` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_127` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_127` VALUES (1,127,'HT0111-01','HT0111-02',5290.000000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_127` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_128`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_128` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4273 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_128`
--

LOCK TABLES `flow_data_movements.travellers_128` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_128` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_128` VALUES (1,128,'HT0111-01','HT0111-02',5260.000000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_128` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_diffwithref_136`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_diffwithref_136` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4267 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_diffwithref_136`
--

LOCK TABLES `flow_data_movements.travellers_diffwithref_136` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_diffwithref_136` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_diffwithref_136` VALUES (1,136,'HT0111-01','HT0111-02',46.250000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_diffwithref_136` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_diffwithref_137`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_diffwithref_137` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4259 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_diffwithref_137`
--

LOCK TABLES `flow_data_movements.travellers_diffwithref_137` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_diffwithref_137` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_diffwithref_137` VALUES (1,137,'HT0111-01','HT0111-02',-25.430000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_diffwithref_137` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_diffwithref_138`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_diffwithref_138` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4264 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_diffwithref_138`
--

LOCK TABLES `flow_data_movements.travellers_diffwithref_138` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_diffwithref_138` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_diffwithref_138` VALUES (1,138,'HT0111-01','HT0111-02',83.760000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_diffwithref_138` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_diffwithref_139`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_diffwithref_139` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4263 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_diffwithref_139`
--

LOCK TABLES `flow_data_movements.travellers_diffwithref_139` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_diffwithref_139` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_diffwithref_139` VALUES (1,139,'HT0111-01','HT0111-02',-32.110000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_diffwithref_139` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_diffwithref_140`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_diffwithref_140` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4273 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_diffwithref_140`
--

LOCK TABLES `flow_data_movements.travellers_diffwithref_140` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_diffwithref_140` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_diffwithref_140` VALUES (1,140,'HT0111-01','HT0111-02',56.100000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_diffwithref_140` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_diffwithref_141`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_diffwithref_141` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4266 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_diffwithref_141`
--

LOCK TABLES `flow_data_movements.travellers_diffwithref_141` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_diffwithref_141` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_diffwithref_141` VALUES (1,141,'HT0111-01','HT0111-02',-4.610000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_diffwithref_141` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_diffwithref_142`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_diffwithref_142` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4268 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_diffwithref_142`
--

LOCK TABLES `flow_data_movements.travellers_diffwithref_142` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_diffwithref_142` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_diffwithref_142` VALUES (1,142,'HT0111-01','HT0111-02',5.720000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_diffwithref_142` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_pctchangewithref_143`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_pctchangewithref_143` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4263 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_pctchangewithref_143`
--

LOCK TABLES `flow_data_movements.travellers_pctchangewithref_143` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_pctchangewithref_143` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_pctchangewithref_143` VALUES (1,143,'HT0111-01','HT0111-02',-0.540000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_pctchangewithref_143` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_pctchangewithref_144`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_pctchangewithref_144` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4266 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_pctchangewithref_144`
--

LOCK TABLES `flow_data_movements.travellers_pctchangewithref_144` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_pctchangewithref_144` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_pctchangewithref_144` VALUES (1,144,'HT0111-01','HT0111-02',-0.090000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_pctchangewithref_144` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_pctchangewithref_145`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_pctchangewithref_145` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4267 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_pctchangewithref_145`
--

LOCK TABLES `flow_data_movements.travellers_pctchangewithref_145` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_pctchangewithref_145` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_pctchangewithref_145` VALUES (1,145,'HT0111-01','HT0111-02',0.810000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_pctchangewithref_145` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_pctchangewithref_146`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_pctchangewithref_146` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4273 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_pctchangewithref_146`
--

LOCK TABLES `flow_data_movements.travellers_pctchangewithref_146` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_pctchangewithref_146` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_pctchangewithref_146` VALUES (1,146,'HT0111-01','HT0111-02',0.990000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_pctchangewithref_146` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_pctchangewithref_147`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_pctchangewithref_147` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4264 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_pctchangewithref_147`
--

LOCK TABLES `flow_data_movements.travellers_pctchangewithref_147` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_pctchangewithref_147` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_pctchangewithref_147` VALUES (1,147,'HT0111-01','HT0111-02',1.440000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_pctchangewithref_147` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_pctchangewithref_148`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_pctchangewithref_148` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4268 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_pctchangewithref_148`
--

LOCK TABLES `flow_data_movements.travellers_pctchangewithref_148` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_pctchangewithref_148` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_pctchangewithref_148` VALUES (1,148,'HT0111-01','HT0111-02',0.090000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_pctchangewithref_148` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_movements.travellers_pctchangewithref_149`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_movements.travellers_pctchangewithref_149` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4259 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_movements.travellers_pctchangewithref_149`
--

LOCK TABLES `flow_data_movements.travellers_pctchangewithref_149` WRITE;
/*!40000 ALTER TABLE `flow_data_movements.travellers_pctchangewithref_149` DISABLE KEYS */;
INSERT INTO `flow_data_movements.travellers_pctchangewithref_149` VALUES (1,149,'HT0111-01','HT0111-02',-0.450000000);
/*!40000 ALTER TABLE `flow_data_movements.travellers_pctchangewithref_149` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.abnormality_61`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.abnormality_61` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=5222 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.abnormality_61`
--

LOCK TABLES `flow_data_relocations.abnormality_61` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.abnormality_61` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.abnormality_61` VALUES (1,61,'HT0111-01','HT0111-02',1.610000000);
/*!40000 ALTER TABLE `flow_data_relocations.abnormality_61` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.abnormality_62`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.abnormality_62` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4919 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.abnormality_62`
--

LOCK TABLES `flow_data_relocations.abnormality_62` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.abnormality_62` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.abnormality_62` VALUES (1,62,'HT0111-01','HT0111-02',-0.460000000);
/*!40000 ALTER TABLE `flow_data_relocations.abnormality_62` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.abnormality_63`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.abnormality_63` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=5028 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.abnormality_63`
--

LOCK TABLES `flow_data_relocations.abnormality_63` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.abnormality_63` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.abnormality_63` VALUES (1,63,'HT0111-01','HT0111-02',0.710000000);
/*!40000 ALTER TABLE `flow_data_relocations.abnormality_63` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.abnormality_64`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.abnormality_64` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4952 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.abnormality_64`
--

LOCK TABLES `flow_data_relocations.abnormality_64` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.abnormality_64` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.abnormality_64` VALUES (1,64,'HT0111-01','HT0111-02',0.190000000);
/*!40000 ALTER TABLE `flow_data_relocations.abnormality_64` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.abnormality_65`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.abnormality_65` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4847 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.abnormality_65`
--

LOCK TABLES `flow_data_relocations.abnormality_65` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.abnormality_65` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.abnormality_65` VALUES (1,65,'HT0111-01','HT0111-02',0.480000000);
/*!40000 ALTER TABLE `flow_data_relocations.abnormality_65` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.abnormality_66`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.abnormality_66` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4925 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.abnormality_66`
--

LOCK TABLES `flow_data_relocations.abnormality_66` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.abnormality_66` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.abnormality_66` VALUES (1,66,'HT0111-01','HT0111-02',-0.400000000);
/*!40000 ALTER TABLE `flow_data_relocations.abnormality_66` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_49`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_49` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4952 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_49`
--

LOCK TABLES `flow_data_relocations.relocations_49` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_49` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_49` VALUES (1,49,'HT0111-01','HT0111-02',8750.000000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_49` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_50`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_50` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=5222 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_50`
--

LOCK TABLES `flow_data_relocations.relocations_50` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_50` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_50` VALUES (1,50,'HT0111-01','HT0111-02',14630.000000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_50` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_51`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_51` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4925 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_51`
--

LOCK TABLES `flow_data_relocations.relocations_51` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_51` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_51` VALUES (1,51,'HT0111-01','HT0111-02',6280.000000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_51` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_52`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_52` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4919 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_52`
--

LOCK TABLES `flow_data_relocations.relocations_52` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_52` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_52` VALUES (1,52,'HT0111-01','HT0111-02',6040.000000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_52` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_53`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_53` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=5028 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_53`
--

LOCK TABLES `flow_data_relocations.relocations_53` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_53` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_53` VALUES (1,53,'HT0111-01','HT0111-02',10880.000000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_53` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_54`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_54` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4847 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_54`
--

LOCK TABLES `flow_data_relocations.relocations_54` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_54` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_54` VALUES (1,54,'HT0111-01','HT0111-02',9920.000000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_54` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_diffwithref_55`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_diffwithref_55` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=5222 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_diffwithref_55`
--

LOCK TABLES `flow_data_relocations.relocations_diffwithref_55` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_diffwithref_55` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_diffwithref_55` VALUES (1,55,'HT0111-01','HT0111-02',7650.000000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_diffwithref_55` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_diffwithref_56`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_diffwithref_56` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4847 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_diffwithref_56`
--

LOCK TABLES `flow_data_relocations.relocations_diffwithref_56` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_diffwithref_56` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_diffwithref_56` VALUES (1,56,'HT0111-01','HT0111-02',1560.000000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_diffwithref_56` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_diffwithref_57`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_diffwithref_57` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4919 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_diffwithref_57`
--

LOCK TABLES `flow_data_relocations.relocations_diffwithref_57` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_diffwithref_57` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_diffwithref_57` VALUES (1,57,'HT0111-01','HT0111-02',-3470.000000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_diffwithref_57` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_diffwithref_58`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_diffwithref_58` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4925 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_diffwithref_58`
--

LOCK TABLES `flow_data_relocations.relocations_diffwithref_58` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_diffwithref_58` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_diffwithref_58` VALUES (1,58,'HT0111-01','HT0111-02',-3170.000000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_diffwithref_58` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_diffwithref_59`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_diffwithref_59` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4952 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_diffwithref_59`
--

LOCK TABLES `flow_data_relocations.relocations_diffwithref_59` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_diffwithref_59` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_diffwithref_59` VALUES (1,59,'HT0111-01','HT0111-02',30.000000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_diffwithref_59` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_diffwithref_60`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_diffwithref_60` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=5028 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_diffwithref_60`
--

LOCK TABLES `flow_data_relocations.relocations_diffwithref_60` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_diffwithref_60` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_diffwithref_60` VALUES (1,60,'HT0111-01','HT0111-02',2800.000000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_diffwithref_60` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_pctchangewithref_67`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_pctchangewithref_67` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4952 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_pctchangewithref_67`
--

LOCK TABLES `flow_data_relocations.relocations_pctchangewithref_67` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_pctchangewithref_67` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_pctchangewithref_67` VALUES (1,67,'HT0111-01','HT0111-02',0.280000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_pctchangewithref_67` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_pctchangewithref_68`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_pctchangewithref_68` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=5028 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_pctchangewithref_68`
--

LOCK TABLES `flow_data_relocations.relocations_pctchangewithref_68` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_pctchangewithref_68` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_pctchangewithref_68` VALUES (1,68,'HT0111-01','HT0111-02',24.790000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_pctchangewithref_68` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_pctchangewithref_69`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_pctchangewithref_69` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=5222 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_pctchangewithref_69`
--

LOCK TABLES `flow_data_relocations.relocations_pctchangewithref_69` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_pctchangewithref_69` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_pctchangewithref_69` VALUES (1,69,'HT0111-01','HT0111-02',67.740000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_pctchangewithref_69` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_pctchangewithref_70`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_pctchangewithref_70` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4925 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_pctchangewithref_70`
--

LOCK TABLES `flow_data_relocations.relocations_pctchangewithref_70` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_pctchangewithref_70` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_pctchangewithref_70` VALUES (1,70,'HT0111-01','HT0111-02',-28.030000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_pctchangewithref_70` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_pctchangewithref_71`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_pctchangewithref_71` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4847 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_pctchangewithref_71`
--

LOCK TABLES `flow_data_relocations.relocations_pctchangewithref_71` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_pctchangewithref_71` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_pctchangewithref_71` VALUES (1,71,'HT0111-01','HT0111-02',13.770000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_pctchangewithref_71` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_relocations.relocations_pctchangewithref_72`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_data_relocations.relocations_pctchangewithref_72` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int NOT NULL COMMENT 'The ID of the metadata for this data',
  `origin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the origin spatial unit that this data object relates to',
  `destination` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the destination spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_flow_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=4919 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data representing a flow between two spatial entities for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_relocations.relocations_pctchangewithref_72`
--

LOCK TABLES `flow_data_relocations.relocations_pctchangewithref_72` WRITE;
/*!40000 ALTER TABLE `flow_data_relocations.relocations_pctchangewithref_72` DISABLE KEYS */;
INSERT INTO `flow_data_relocations.relocations_pctchangewithref_72` VALUES (1,72,'HT0111-01','HT0111-02',-30.740000000);
/*!40000 ALTER TABLE `flow_data_relocations.relocations_pctchangewithref_72` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Dumping data for table `indicator`
--

LOCK TABLES `indicator` WRITE;
/*!40000 ALTER TABLE `indicator` DISABLE KEYS */;
INSERT INTO `indicator` VALUES (1,'residents.residents','residents',1,'https://www.flowgeek.org/methods/calculating-mobility-indicators/residents-indicators#residents','Residents','Estimates the number of people residing in an area during the month selected by the user.','The residents indicator estimates the number of people residing in each area during the month selected by the user.\n\nThe indicator is calculated from the net inflow indicator and the baseline number of residents in the area during a reference period.\n\nA subscriber\'s home location is determined by the area containing the cell tower which most frequently routed the subscriber\'s last network event (e.g. call, SMS message, or mobile data) of the day over the previous four weeks, updated monthly.','sequential',0,0.000000000,NULL,7.000000000,NULL,'{\"fr\": {\"label\": \"R\\u00e9sidents\", \"description\": \"Estime le nombre de personnes r\\u00e9sidant dans une zone pendant le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur.\", \"method\": \"L\'indicateur des r\\u00e9sidents estime le nombre de personnes r\\u00e9sidant dans chaque zone pendant le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur.\\n\\nL\'indicateur est calcul\\u00e9 \\u00e0 partir de l\'indicateur d\'afflux net et du nombre de base de r\\u00e9sidents dans la zone pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nL\'emplacement du domicile d\'un abonn\\u00e9 est d\\u00e9termin\\u00e9 par la zone dans laquelle se trouve la tour de t\\u00e9l\\u00e9phonie cellulaire qui a achemin\\u00e9 le plus fr\\u00e9quemment le dernier \\u00e9v\\u00e9nement r\\u00e9seau de l\'abonn\\u00e9 (par exemple, un appel, un message SMS, ou des donn\\u00e9es mobiles) de la journ\\u00e9e au cours des quatre semaines pr\\u00e9c\\u00e9dentes, avec une mise \\u00e0 jour mensuelle.\"}}'),(2,'residents.residents_perKm2','residents',2,'https://www.flowgeek.org/methods/calculating-mobility-indicators/residents-indicators#residents-km2','Residents per square km','Estimates the average number of people residing per square kilometre of an area during the month selected by the user.','The residents per square kilometre indicator estimates the average number of people residing per square kilometre of each area during the month selected by the user.\n\nThe indicator is calculated from the residents indicator and the geographic size of the area.\n\nA subscriber\'s home location is determined by the area containing the cell tower which most frequently routed the subscriber\'s last network event (e.g. call, SMS message, or mobile data) of the day over the previous four weeks, updated monthly.','sequential',2,0.000000000,NULL,NULL,NULL,'{\"fr\": {\"label\": \"Habitants par km\\u00b2\", \"description\": \"Estime le nombre moyen de personnes r\\u00e9sidant par kilom\\u00e8tre carr\\u00e9 d\'une zone pendant le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur.\", \"method\": \"L\'indicateur de r\\u00e9sidents par kilom\\u00e8tre carr\\u00e9 estime le nombre moyen de personnes r\\u00e9sidant par kilom\\u00e8tre carr\\u00e9 d\'une zone pendant le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur.\\n\\nL\'indicateur est calcul\\u00e9 \\u00e0 partir de l\'indicateur des r\\u00e9sidents et de la taille g\\u00e9ographique de la zone.\\n\\nL\'emplacement du domicile d\'un abonn\\u00e9 est d\\u00e9termin\\u00e9 par la zone dans laquelle se trouve la tour de t\\u00e9l\\u00e9phonie cellulaire qui a achemin\\u00e9 le plus fr\\u00e9quemment le dernier \\u00e9v\\u00e9nement r\\u00e9seau de l\'abonn\\u00e9 (par exemple, un appel, un message SMS, ou des donn\\u00e9es mobiles) de la journ\\u00e9e au cours des quatre semaines pr\\u00e9c\\u00e9dentes, avec une mise \\u00e0 jour mensuelle.\"}}'),(3,'residents.residents_diffwithref','residents',3,'https://www.flowgeek.org/methods/calculating-mobility-indicators/residents-indicators#residents-difference','Residents difference','Estimates the difference in the number of residents between a reference period and the month selected by the user.','For each area, the residents difference indicator estimates the difference in the number of residents between a reference period and the month selected by the user.\n\nThe indicator is calculated from residents indicator and the baseline number of residents in the area during a reference period.\n\nIf the number of residents has increased, the indicator will have a positive value; if the number of residents has decreased, the value will be negative.\n\nA subscriber\'s home location is determined by the area containing the cell tower which most frequently routed the subscriber\'s last network event (e.g. call, SMS message, or mobile data) of the day over the previous four weeks, updated monthly.','diverging',0,NULL,NULL,NULL,NULL,'{\"fr\": {\"label\": \"Diff\\u00e9rence entre les r\\u00e9sidents\", \"description\": \"Estime la diff\\u00e9rence du nombre de r\\u00e9sidents entre une p\\u00e9riode de r\\u00e9f\\u00e9rence et le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur.\", \"method\": \"Pour chaque zone, l\'indicateur de diff\\u00e9rence de r\\u00e9sidents estime la diff\\u00e9rence du nombre de r\\u00e9sidents entre une p\\u00e9riode de r\\u00e9f\\u00e9rence et le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur.\\n\\nL\'indicateur est calcul\\u00e9 \\u00e0 partir de l\'indicateur de r\\u00e9sidents et du nombre de r\\u00e9sidents de r\\u00e9f\\u00e9rence dans la zone pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nSi le nombre de r\\u00e9sidents a augment\\u00e9, l\'indicateur aura une valeur positive ; si le nombre de r\\u00e9sidents a diminu\\u00e9, la valeur sera n\\u00e9gative.\\n\\nL\'emplacement du domicile d\'un abonn\\u00e9 est d\\u00e9termin\\u00e9 par la zone dans laquelle se trouve la tour de t\\u00e9l\\u00e9phonie cellulaire qui a achemin\\u00e9 le plus fr\\u00e9quemment le dernier \\u00e9v\\u00e9nement r\\u00e9seau de l\'abonn\\u00e9 (par exemple, un appel, un message SMS, ou des donn\\u00e9es mobiles) de la journ\\u00e9e au cours des quatre semaines pr\\u00e9c\\u00e9dentes, avec une mise \\u00e0 jour mensuelle.\"}}'),(4,'residents.residents_pctchangewithref','residents',4,'https://www.flowgeek.org/methods/calculating-mobility-indicators/residents-indicators#residents-difference-percentage-change','Percent change in residents difference','Estimates the change in the number of residents between a reference period and the month selected by the user, expressed as a percentage of the baseline number of residents.','The percentage change in residents indicator estimates the change in the number of residents between a reference period and a given period of time, relative to the number of residents in the reference period. The difference is expressed as a percentage of a baseline value calculated for the reference period.\n\nThe indicator is calculated from the residents indicator and the baseline number of residents in the area during a reference period.\n\nIf the number of residents have increased, the indicator will have a positive value; if the number of residents has decreased, the value will be negative.\n\nA subscriber\'s home location is determined by the area containing the cell tower which most frequently routed the subscriber\'s last network event (e.g. call, SMS message, or mobile data) of the day over the previous four weeks, updated monthly.','diverging',2,-100.000000000,100.000000000,NULL,NULL,'{\"fr\": {\"label\": \"Variation en pourcentage de la diff\\u00e9rence de r\\u00e9sidents\", \"description\": \"Estime la variation du nombre de r\\u00e9sidents entre une p\\u00e9riode de r\\u00e9f\\u00e9rence et le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur, exprim\\u00e9e en pourcentage du nombre de r\\u00e9sidents de r\\u00e9f\\u00e9rence.\", \"method\": \"L\'indicateur de variation en pourcentage du nombre de r\\u00e9sidents estime la variation du nombre de r\\u00e9sidents entre une p\\u00e9riode de r\\u00e9f\\u00e9rence et une p\\u00e9riode donn\\u00e9e, par rapport au nombre de r\\u00e9sidents de la p\\u00e9riode de r\\u00e9f\\u00e9rence. La diff\\u00e9rence est exprim\\u00e9e en pourcentage d\'une valeur de r\\u00e9f\\u00e9rence calcul\\u00e9e pour la p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nL\'indicateur est calcul\\u00e9 \\u00e0 partir de l\'indicateur de r\\u00e9sidents et du nombre de r\\u00e9sidents de r\\u00e9f\\u00e9rence dans la zone pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nSi le nombre de r\\u00e9sidents a augment\\u00e9, l\'indicateur aura une valeur positive ; si le nombre de r\\u00e9sidents a diminu\\u00e9, la valeur sera n\\u00e9gative.\\n\\nL\'emplacement du domicile d\'un abonn\\u00e9 est d\\u00e9termin\\u00e9 par la zone dans laquelle se trouve la tour de t\\u00e9l\\u00e9phonie cellulaire qui a achemin\\u00e9 le plus fr\\u00e9quemment le dernier \\u00e9v\\u00e9nement r\\u00e9seau de l\'abonn\\u00e9 (par exemple, un appel, un message SMS, ou des donn\\u00e9es mobiles) de la journ\\u00e9e au cours des quatre semaines pr\\u00e9c\\u00e9dentes, avec une mise \\u00e0 jour mensuelle.\"}}'),(5,'residents.abnormality','residents',5,'https://www.flowgeek.org/methods/calculating-mobility-indicators/residents-indicators#residents-abnormality','Abnormality','Measures the deviation of the estimated number of people residing in a given area during the month selected by the user from the numbers of residents estimated during a reference period, expressed as an abnormality score (z-score).','The residents abnormality indicator measures the deviation of the estimated number of people residing in a given area during the month selected by the user from the numbers of residents estimated during a reference period, expressed as a z-score.\n\nThe indicator is calculated from the residents difference indicator and the mean absolute deviation in the number of residents in the area during a reference period.\n\nFor this indicator, a positive value greater than 3 indicates a statistically significant increase in the number of residents in a given area; a value less than -3 indicates a statistically significant decrease in residents. Values between 3 and -3 are within the bounds of normal variation based on the reference period.\n\nThis indicator describes how unusual the number of residents in an area is, given the amount of variation observed during the reference period. Higher absolute values indicate greater deviation from the normal variation in population, and therefore greater probability that the change is meaningful. Such changes may be associated with specific events or may be caused by technical issues. Very large abnormalities (absolute values greater than 6), however, may also be indicative of a technical issue.\n\nA subscriber\'s home location is determined by the area containing the cell tower which most frequently routed the subscriber\'s last network event (e.g. call, SMS message, or mobile data) of the day over the previous four weeks, updated monthly.','diverging',2,NULL,NULL,NULL,'[{\"max\": 3.0, \"min\": -3.0, \"width\": \"10%\"}, {\"max\": -3.0, \"min\": -6.0, \"width\": \"30%\"}, {\"max\": 6.0, \"min\": 3.0, \"width\": \"30%\"}, {\"max\": -6.0, \"min\": null, \"width\": \"100%\"}, {\"max\": null, \"min\": 6.0, \"width\": \"100%\"}]','{\"fr\": {\"label\": \"Anomalie\", \"description\": \"Mesure l\'\\u00e9cart entre le nombre estim\\u00e9 de personnes r\\u00e9sidant dans une zone donn\\u00e9e pendant le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur et le nombre de r\\u00e9sidents estim\\u00e9 pendant la p\\u00e9riode de r\\u00e9f\\u00e9rence, exprim\\u00e9 sous la forme d\'un score d\'anomalie (score z).\", \"method\": \"L\'indicateur d\'anomalie des r\\u00e9sidents mesure l\'\\u00e9cart entre le nombre estim\\u00e9 de personnes r\\u00e9sidant dans une zone donn\\u00e9e pendant le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur et le nombre de r\\u00e9sidents estim\\u00e9 pendant la p\\u00e9riode de r\\u00e9f\\u00e9rence, exprim\\u00e9 sous la forme d\'un score z.\\n\\nL\'indicateur est calcul\\u00e9 \\u00e0 partir de l\'indicateur de diff\\u00e9rence de r\\u00e9sidents et de l\'\\u00e9cart absolu moyen du nombre de r\\u00e9sidents dans la zone pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nPour cet indicateur, une valeur positive sup\\u00e9rieure \\u00e0 3 indique une augmentation statistiquement significative du nombre de r\\u00e9sidents dans une zone donn\\u00e9e ; une valeur inf\\u00e9rieure \\u00e0 -3 indique une diminution statistiquement significative des r\\u00e9sidents. Les valeurs entre 3 et -3 se situent dans les limites de la variation normale bas\\u00e9e sur la p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nCet indicateur d\\u00e9crit l\'ampleur du caract\\u00e8re inhabituel du nombre de r\\u00e9sidents dans une zone, compte tenu de l\'ampleur de la variation observ\\u00e9e pendant la p\\u00e9riode de r\\u00e9f\\u00e9rence. Des valeurs absolues plus \\u00e9lev\\u00e9es indiquent un plus grand \\u00e9cart par rapport \\u00e0 la variation normale de la population, et donc une plus grande probabilit\\u00e9 que le changement soit significatif. Des changements de la sorte pourraient \\u00eatre associ\\u00e9s \\u00e0 des \\u00e9v\\u00e9nements sp\\u00e9cifiques ou caus\\u00e9s par des probl\\u00e8mes techniques. Toutefois, des anomalies tr\\u00e8s importantes (valeurs absolues sup\\u00e9rieures \\u00e0 6) pourraient \\u00e9galement indiquer un probl\\u00e8me technique.\\n\\nL\'emplacement du domicile d\'un abonn\\u00e9 est d\\u00e9termin\\u00e9 par la zone dans laquelle se trouve la tour de t\\u00e9l\\u00e9phonie cellulaire qui a achemin\\u00e9 le plus fr\\u00e9quemment le dernier \\u00e9v\\u00e9nement r\\u00e9seau de l\'abonn\\u00e9 (par exemple, un appel, un message SMS, ou des donn\\u00e9es mobiles) de la journ\\u00e9e au cours des quatre semaines pr\\u00e9c\\u00e9dentes, avec une mise \\u00e0 jour mensuelle.\"}}'),(6,'residents.arrived','residents',6,'https://www.flowgeek.org/methods/calculating-mobility-indicators/residents-indicators#arrived-residents','Arrived residents','Estimates the total number of people who relocated into an area during the month selected by the user.','For each area, the arrived residents indicator estimates the total number of people who relocated to an area from any other area within the country during the month selected by the user.\n\nThe indicator is calculated from the sum of the counts of subscribers whose home location changed from one area to another area each month.\n\nA subscriber\'s home location is determined by the area containing the cell tower which most frequently routed the subscriber\'s last network event (e.g. call, SMS message, or mobile data) of the day over the previous four weeks, updated monthly.','sequential',0,0.000000000,NULL,NULL,NULL,'{\"fr\": {\"label\": \"R\\u00e9sidents arriv\\u00e9s\", \"description\": \"Estime le nombre total de personnes qui ont d\\u00e9m\\u00e9nag\\u00e9 dans une zone pendant le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur.\", \"method\": \"Pour chaque zone, l\'indicateur des r\\u00e9sidents arriv\\u00e9s estime le nombre total de personnes qui ont d\\u00e9m\\u00e9nag\\u00e9 vers une zone \\u00e0 partir de toute autre zone du pays pendant le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur.\\n\\nL\'indicateur est calcul\\u00e9 \\u00e0 partir de la somme des comptages des abonn\\u00e9s dont le lieu de r\\u00e9sidence a chang\\u00e9 d\'une zone \\u00e0 une autre chaque mois.\\n\\nL\'emplacement du domicile d\'un abonn\\u00e9 est d\\u00e9termin\\u00e9 par la zone dans laquelle se trouve la tour de t\\u00e9l\\u00e9phonie cellulaire qui a achemin\\u00e9 le plus fr\\u00e9quemment le dernier \\u00e9v\\u00e9nement r\\u00e9seau de l\'abonn\\u00e9 (par exemple, un appel, un message SMS, ou des donn\\u00e9es mobiles) de la journ\\u00e9e au cours des quatre semaines pr\\u00e9c\\u00e9dentes, avec une mise \\u00e0 jour mensuelle.\"}}'),(7,'residents.departed','residents',7,'https://www.flowgeek.org/methods/calculating-mobility-indicators/residents-indicators#departed-residents','Departed residents','Estimates the total number of people who relocated out of an area during the month selected by the user.','For each area, the departed residents indicator estimates the total number of people who relocated from an area to any other area within the country during the month selected by the user.\n\nThe indicator is calculated from the sum of the counts of subscribers whose home location changed from one area to another area during each month.\n\nA subscriber\'s home location is determined by the area containing the cell tower which most frequently routed the subscriber\'s last network event (e.g. call, SMS message, or mobile data) of the day over the previous four weeks, updated monthly.','sequential',0,0.000000000,NULL,NULL,NULL,'{\"fr\": {\"label\": \"R\\u00e9sidents d\\u00e9plac\\u00e9s\", \"description\": \"Estime le nombre total de personnes qui ont d\\u00e9m\\u00e9nag\\u00e9 hors d\'une zone pendant le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur.\", \"method\": \"Pour chaque zone, l\'indicateur des r\\u00e9sidents d\\u00e9plac\\u00e9s estime le nombre total de personnes qui ont d\\u00e9m\\u00e9nag\\u00e9 vers une zone \\u00e0 partir de toute autre zone du pays pendant le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur.\\n\\nL\'indicateur est calcul\\u00e9 \\u00e0 partir de la somme des comptages des abonn\\u00e9s dont le lieu de r\\u00e9sidence a chang\\u00e9 d\'une zone \\u00e0 une autre chaque mois.\\n\\nL\'emplacement du domicile d\'un abonn\\u00e9 est d\\u00e9termin\\u00e9 par la zone dans laquelle se trouve la tour de t\\u00e9l\\u00e9phonie cellulaire qui a achemin\\u00e9 le plus fr\\u00e9quemment le dernier \\u00e9v\\u00e9nement r\\u00e9seau de l\'abonn\\u00e9 (par exemple, un appel, un message SMS, ou des donn\\u00e9es mobiles) de la journ\\u00e9e au cours des quatre semaines pr\\u00e9c\\u00e9dentes, avec une mise \\u00e0 jour mensuelle.\"}}'),(8,'residents.delta_arrived','residents',8,'https://www.flowgeek.org/methods/calculating-mobility-indicators/residents-indicators#net-inflow','Net inflow','Estimates the difference between the number of people relocating into and out of an area during the month selected by the user.','For each area, the net inflow residents indicator estimates the difference between the number of people relocating into (arrived residents) and out of (departed residents) an area during the month selected by the user.\n\nThe indicator is calculated from the arrived and departed residents indicators.\n\nIf more people relocate into the area than out, the indicator will have a positive value; if more people relocate out of the area, the value will be negative.\n\nA subscriber\'s home location is determined by the area containing the cell tower which most frequently routed the subscriber\'s last network event (e.g. call, SMS message, or mobile data) of the day over the previous four weeks, updated monthly.','diverging',0,NULL,NULL,NULL,NULL,'{\"fr\": {\"label\": \"Afflux net\", \"description\": \"Estime la diff\\u00e9rence entre le nombre de personnes d\\u00e9m\\u00e9nageant vers et hors d\'une zone pendant le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur.\", \"method\": \"Pour chaque zone, l\'indicateur d\'afflux net de r\\u00e9sidents estime la diff\\u00e9rence entre le nombre de personnes ayant d\\u00e9m\\u00e9nag\\u00e9 dans (r\\u00e9sidents arriv\\u00e9s) et hors (r\\u00e9sidents partis) d\'une zone pendant le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur.\\n\\nCet indicateur est calcul\\u00e9 \\u00e0 partir des indicateurs relatifs aux r\\u00e9sidents arriv\\u00e9s et partis.\\n\\nSi les personnes qui s\'installent dans la zone sont plus nombreuses que celles qui la quittent, l\'indicateur aura une valeur positive ; si les personnes qui quittent la zone sont plus nombreuses, la valeur sera n\\u00e9gative.\\n\\nL\'emplacement du domicile d\'un abonn\\u00e9 est d\\u00e9termin\\u00e9 par la zone dans laquelle se trouve la tour de t\\u00e9l\\u00e9phonie cellulaire qui a achemin\\u00e9 le plus fr\\u00e9quemment le dernier \\u00e9v\\u00e9nement r\\u00e9seau de l\'abonn\\u00e9 (par exemple, un appel, un message SMS, ou des donn\\u00e9es mobiles) de la journ\\u00e9e au cours des quatre semaines pr\\u00e9c\\u00e9dentes, avec une mise \\u00e0 jour mensuelle.\"}}'),(9,'relocations.relocations','relocations',1,'https://www.flowgeek.org/methods/calculating-mobility-indicators/relocation-indicators#relocations','Relocations','Estimates the number of people who relocate from area A to area B during the month selected by the user.','For each pair of areas, the relocations indicator estimates the number of people who relocate from area A to area B during the month selected by the user.\n\nThe indicator is calculated from the number of subscribers whose home location changed from area A to area B during a given period or time.\n\nA subscriber\'s home location is determined by the area containing the cell tower which most frequently routed the subscriber\'s last network event (e.g. call, SMS message, or mobile data) of the day over the previous four weeks, updated monthly.','sequential',2,0.000000000,NULL,NULL,NULL,'{\"fr\": {\"label\": \"Changement de r\\u00e9sidence\", \"description\": \"Estime le nombre de personnes qui ont d\\u00e9m\\u00e9nag\\u00e9 de la zone A \\u00e0 la zone B pendant le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur.\", \"method\": \"Pour chaque paire de zones, l\'indicateur de changement de r\\u00e9sidence estime le nombre de personnes qui d\\u00e9m\\u00e9nagent de la zone A \\u00e0 la zone B pendant le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur.\\n\\nL\'indicateur est calcul\\u00e9 \\u00e0 partir du nombre d\'abonn\\u00e9s dont le lieu de r\\u00e9sidence est pass\\u00e9 de la zone A \\u00e0 la zone B pendant une p\\u00e9riode donn\\u00e9e.\\n\\nL\'emplacement du domicile d\'un abonn\\u00e9 est d\\u00e9termin\\u00e9 par la zone dans laquelle se trouve la tour de t\\u00e9l\\u00e9phonie cellulaire qui a achemin\\u00e9 le plus fr\\u00e9quemment le dernier \\u00e9v\\u00e9nement r\\u00e9seau de l\'abonn\\u00e9 (par exemple, un appel, un message SMS, ou des donn\\u00e9es mobiles) de la journ\\u00e9e au cours des quatre semaines pr\\u00e9c\\u00e9dentes, avec une mise \\u00e0 jour mensuelle.\"}}'),(10,'relocations.relocations_diffwithref','relocations',2,'https://www.flowgeek.org/methods/calculating-mobility-indicators/relocation-indicators#relocations-difference','Relocations difference','Estimates the change in the number of relocations from area A to area B between a reference period and the month selected by the user.','The relocations difference indicator estimates the difference in number of relocations from area A to area B between a reference period and the month selected by the user.\n\nThe indicator is calculated from the relocations indicator and the baseline number of relocations during a reference period.\n\nIf the number of relocations has increased, the indicator will have a positive value; if the number has decreased, the value will be negative.\n\nA subscriber\'s home location is determined by the area containing the cell tower which most frequently routed the subscriber\'s last network event (e.g. call, SMS message, or mobile data) of the day over the previous four weeks, updated monthly.','diverging',0,NULL,NULL,NULL,NULL,'{\"fr\": {\"label\": \"Diff\\u00e9rence de changements de r\\u00e9sidence\", \"description\": \"Estime la variation du nombre de changements de r\\u00e9sidence de la zone A vers la zone B entre une p\\u00e9riode de r\\u00e9f\\u00e9rence et le mois choisi par l\'utilisateur.\", \"method\": \"L\'indicateur de diff\\u00e9rence de changements de r\\u00e9sidence estime la variation du nombre de changements de r\\u00e9sidence de la zone A vers la zone B entre une p\\u00e9riode de r\\u00e9f\\u00e9rence et le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur.\\n\\nL\'indicateur est calcul\\u00e9 \\u00e0 partir de l\'indicateur de changement de r\\u00e9sidence et du nombre de changements de r\\u00e9sidence de r\\u00e9f\\u00e9rence pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nSi le nombre de changements de r\\u00e9sidence a augment\\u00e9, l\'indicateur aura une valeur positive ; si le nombre de changements de r\\u00e9sidence a diminu\\u00e9, la valeur sera n\\u00e9gative.\\n\\nL\'emplacement du domicile d\'un abonn\\u00e9 est d\\u00e9termin\\u00e9 par la zone dans laquelle se trouve la tour de t\\u00e9l\\u00e9phonie cellulaire qui a achemin\\u00e9 le plus fr\\u00e9quemment le dernier \\u00e9v\\u00e9nement r\\u00e9seau de l\'abonn\\u00e9 (par exemple, un appel, un message SMS, ou des donn\\u00e9es mobiles) de la journ\\u00e9e au cours des quatre semaines pr\\u00e9c\\u00e9dentes, avec une mise \\u00e0 jour mensuelle.\"}}'),(11,'relocations.relocations_pctchangewithref','relocations',3,'https://www.flowgeek.org/methods/calculating-mobility-indicators/relocation-indicators#relocations-difference-percentage-change','Percent change in relocations difference','Estimates the change in the number of relocations from area A to area B between a reference period and the month selected by the user, expressed as a percentage of the baseline number of relocations.','The percentage change in relocations difference indicator estimates the change in relocations from area A to area B relative to the number of relocations between these areas during the reference period. The difference is expressed as a percentage of a baseline value calculated for the reference period.\n\nThe indicator is calculated from the relocations indicator and the baseline number of relocations during a reference period.\n\nIf the number of relocations has increased, the indicator will have a positive value; if the number of relocations has decreased, the value will be negative.\n\nA subscriber\'s home location is determined by the area containing the cell tower which most frequently routed the subscriber\'s last network event (e.g. call, SMS message, or mobile data) of the day over the previous four weeks, updated monthly.','diverging',2,NULL,NULL,NULL,NULL,'{\"fr\": {\"label\": \"Variation en pourcentage de la diff\\u00e9rence de changements de r\\u00e9sidence\", \"description\": \"Estime la variation du nombre de changements de r\\u00e9sidence de la zone A vers la zone B entre une p\\u00e9riode de r\\u00e9f\\u00e9rence et le mois choisi par l\'utilisateur, exprim\\u00e9e en pourcentage du nombre de changements de r\\u00e9sidence de r\\u00e9f\\u00e9rence.\", \"method\": \"L\'indicateur de variation en pourcentage de la diff\\u00e9rence de changements de r\\u00e9sidence estime la variation des changements de r\\u00e9sidence de la zone A vers la zone B par rapport au nombre de changements de r\\u00e9sidence entre ces zones pendant la p\\u00e9riode de r\\u00e9f\\u00e9rence. La diff\\u00e9rence est exprim\\u00e9e en pourcentage d\'une valeur de r\\u00e9f\\u00e9rence calcul\\u00e9e pour la p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nL\'indicateur est calcul\\u00e9 \\u00e0 partir de l\'indicateur de changements de r\\u00e9sidence et du nombre de changements de r\\u00e9sidence de r\\u00e9f\\u00e9rence pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nSi le nombre de changements de r\\u00e9sidence a augment\\u00e9, l\'indicateur aura une valeur positive ; si le nombre de changements de r\\u00e9sidence a diminu\\u00e9, la valeur sera n\\u00e9gative.\\n\\nL\'emplacement du domicile d\'un abonn\\u00e9 est d\\u00e9termin\\u00e9 par la zone dans laquelle se trouve la tour de t\\u00e9l\\u00e9phonie cellulaire qui a achemin\\u00e9 le plus fr\\u00e9quemment le dernier \\u00e9v\\u00e9nement r\\u00e9seau de l\'abonn\\u00e9 (par exemple, un appel, un message SMS, ou des donn\\u00e9es mobiles) de la journ\\u00e9e au cours des quatre semaines pr\\u00e9c\\u00e9dentes, avec une mise \\u00e0 jour mensuelle.\"}}'),(12,'relocations.abnormality','relocations',4,'https://www.flowgeek.org/methods/calculating-mobility-indicators/relocation-indicators#relocations-abnormality','Abnormality','Measures the deviation in the estimated number of people relocating from area A to area B during the time period of interest from the numbers of relocations estimated during a reference period, expressed as an abnormality score (z-score).','The relocations abnormality indicator measures the deviation in the estimated number of relocating from area A to area B during the month selected by the user from the numbers of relocations estimated during a reference period, expressed as a z-score.\n\nA positive value for this indicator greater than 3 indicates a statistically significant increase in the number of relocations; a value less than -3 indicates a statistically significant decrease in relocations.\n\nThis indicator describes how unusual the number of relocations from area A to area B is, given the amount of variation observed during the reference period. Higher absolute values indicate greater deviation from the normal variation in relocations, and therefore greater probability that the change is meaningful. Such changes may be associated with specific events or may be caused by technical issues. Very large abnormalities (absolute values greater than 6), however, may also be indicative of a technical issue.\n\nWe calculate the relocations abnormality indicator using the relocations difference indicator and the mean absolute deviation in the number of relocations during a reference period.\n\nA subscriber\'s home location is determined by the area containing the cell tower which most frequently routed the subscriber\'s last network event (e.g. call, SMS message, or mobile data) of the day over the previous four weeks, updated monthly.','diverging',2,-6.000000000,6.000000000,NULL,'[{\"max\": 3.0, \"min\": -3.0, \"width\": \"2%\"}, {\"max\": -3.0, \"min\": -6.0, \"width\": \"20%\"}, {\"max\": 6.0, \"min\": 3.0, \"width\": \"20%\"}, {\"max\": -6.0, \"min\": null, \"width\": \"80%\"}, {\"max\": null, \"min\": 6.0, \"width\": \"80%\"}]','{\"fr\": {\"label\": \"Anomalie des changements de r\\u00e9sidence\", \"description\": \"Mesure l\'\\u00e9cart du nombre estim\\u00e9 de changements de r\\u00e9sidence de la zone A vers la zone B pendant la p\\u00e9riode d\'int\\u00e9r\\u00eat par rapport au nombre de changements de r\\u00e9sidence estim\\u00e9 pendant la p\\u00e9riode de r\\u00e9f\\u00e9rence, exprim\\u00e9 sous la forme d\'un score d\'anomalie (score z).\", \"method\": \"L\'indicateur d\'anomalie des changements de r\\u00e9sidence mesure l\'\\u00e9cart entre le nombre estim\\u00e9 de changements de r\\u00e9sidence de la zone A vers la zone B pendant le mois s\\u00e9lectionn\\u00e9 par l\'utilisateur et le nombre de changements de r\\u00e9sidence estim\\u00e9 pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence, exprim\\u00e9 sous la forme d\'un score z.\\n\\nPour cet indicateur, une valeur positive sup\\u00e9rieure \\u00e0 3 indique une augmentation statistiquement significative du nombre de changements de r\\u00e9sidence ; une valeur inf\\u00e9rieure \\u00e0 -3 indique une diminution statistiquement significative des changements de r\\u00e9sidence.\\n\\nCet indicateur d\\u00e9crit l\'ampleur du caract\\u00e8re inhabituel du nombre de changements de r\\u00e9sidence de la zone A vers la zone B, compte tenu de l\'ampleur de la variation observ\\u00e9e pendant la p\\u00e9riode de r\\u00e9f\\u00e9rence. Des valeurs absolues plus \\u00e9lev\\u00e9es indiquent un plus grand \\u00e9cart par rapport \\u00e0 la variation normale des changements de r\\u00e9sidence , et donc une plus grande probabilit\\u00e9 que le changement soit significatif. Des changements de la sorte pourraient \\u00eatre associ\\u00e9s \\u00e0 des \\u00e9v\\u00e9nements sp\\u00e9cifiques ou caus\\u00e9s par des probl\\u00e8mes techniques. Toutefois, des anomalies tr\\u00e8s importantes (valeurs absolues sup\\u00e9rieures \\u00e0 6) pourraient \\u00e9galement indiquer un probl\\u00e8me technique.\\n\\nNous calculons l\'indicateur d\'anomalie des changements de r\\u00e9sidence en utilisant l\'indicateur de diff\\u00e9rence des changements de r\\u00e9sidence et l\'\\u00e9cart absolu moyen du nombre de changements de r\\u00e9sidence pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nL\'emplacement du domicile d\'un abonn\\u00e9 est d\\u00e9termin\\u00e9 par la zone dans laquelle se trouve la tour de t\\u00e9l\\u00e9phonie cellulaire qui a achemin\\u00e9 le plus fr\\u00e9quemment le dernier \\u00e9v\\u00e9nement r\\u00e9seau de l\'abonn\\u00e9 (par exemple, un appel, un message SMS, ou des donn\\u00e9es mobiles) de la journ\\u00e9e au cours des quatre semaines pr\\u00e9c\\u00e9dentes, avec une mise \\u00e0 jour mensuelle.\"}}'),(13,'presence.presence','presence',1,'https://www.flowgeek.org/methods/calculating-mobility-indicators/presence-indicators#presence','Presence','Estimates the number of people who are present in a given area on the day(s) selected by the user.','The presence indicator estimates the number of people who are present in a given area at some point on the day(s) selected by the user.\n\nWe calculate the presence indicator from the number of unique subscribers who have been active in a given area on the day(s) selected by the user.\n\nSubscribers are determined to have been present in an area on a given day if they have a network event (e.g. a call) routed by a cell tower in that area.','sequential',0,0.000000000,NULL,NULL,NULL,'{\"fr\": {\"label\": \"Pr\\u00e9sence\", \"description\": \"Estime le nombre de personnes pr\\u00e9sentes dans une zone donn\\u00e9e le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur.\", \"method\": \"L\'indicateur de pr\\u00e9sence estime le nombre de personnes pr\\u00e9sentes dans une zone donn\\u00e9e \\u00e0 un moment donn\\u00e9 du ou des jours s\\u00e9lectionn\\u00e9s par l\'utilisateur.\\n\\nNous calculons l\'indicateur de pr\\u00e9sence \\u00e0 partir du nombre d\'abonn\\u00e9s uniques qui ont \\u00e9t\\u00e9 actifs dans une zone donn\\u00e9e le ou les jours choisis par l\'utilisateur.\\n\\nLes abonn\\u00e9s sont consid\\u00e9r\\u00e9s comme ayant \\u00e9t\\u00e9 pr\\u00e9sents dans une zone un jour donn\\u00e9 lorsqu\'un \\u00e9v\\u00e9nement r\\u00e9seau (par exemple un appel) est achemin\\u00e9 par une tour de t\\u00e9l\\u00e9phonie cellulaire dans cette zone.\"}}'),(14,'presence.presence_perKm2','presence',2,'https://www.flowgeek.org/methods/calculating-mobility-indicators/presence-indicators#presence-km2','Presence per square km','Estimates the average number of people present per square kilometre of an area during the day(s) selected by the user.','The presence per square km estimates the average number of people present per square kilometre of an area during the day(s) selected by the user.\n\nThe indicator is calculated from the presence indicator and the geographic size of the area.\n\nSubscribers are determined to have been present in an area on a given day if they have a network event (e.g. a call) routed by a cell tower in that area.','sequential',2,0.000000000,NULL,NULL,NULL,'{\"fr\": {\"label\": \"Pr\\u00e9sence par km\\u00b2\", \"description\": \"Estime le nombre moyen de personnes pr\\u00e9sentes par kilom\\u00e8tre carr\\u00e9 d\'une zone pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur.\", \"method\": \"La pr\\u00e9sence par km\\u00b2 estime le nombre moyen de personnes pr\\u00e9sentes par kilom\\u00e8tre carr\\u00e9 d\'une zone pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur.\\n\\nL\'indicateur est calcul\\u00e9 \\u00e0 partir de l\'indicateur de pr\\u00e9sence et de la taille g\\u00e9ographique de la zone.\\n\\nLes abonn\\u00e9s sont consid\\u00e9r\\u00e9s comme ayant \\u00e9t\\u00e9 pr\\u00e9sents dans une zone un jour donn\\u00e9 lorsqu\'un \\u00e9v\\u00e9nement r\\u00e9seau (par exemple un appel) est achemin\\u00e9 par une tour de t\\u00e9l\\u00e9phonie cellulaire dans cette zone.\"}}'),(15,'presence.presence_diffwithref','presence',3,'https://www.flowgeek.org/methods/calculating-mobility-indicators/presence-indicators#presence-difference','Presence difference','Estimates the difference in the number of people who are present in an area during the day(s) selected by the user compared to the number present during a reference period.','The presence difference indicator estimates the difference in the number of people who are present in an area during the day(s) selected by the user compared to the number present during a reference period.\n\nThe indicator is calculated from the presence indicator and the baseline number of people during a reference period.\n\nIf the number of people present in the area has increased, the indicator will have a positive value; if the number has decreased, the value will be negative.\n\nSubscribers are determined to have been present in an area on a given day if they have a network event (e.g. a call) routed by a cell tower in that area.','diverging',0,NULL,NULL,NULL,NULL,'{\"fr\": {\"label\": \"Diff\\u00e9rence de pr\\u00e9sence\", \"description\": \"Estime la diff\\u00e9rence entre le nombre de personnes pr\\u00e9sentes dans une zone pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur et le nombre de personnes pr\\u00e9sentes pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence.\", \"method\": \"L\'indicateur de diff\\u00e9rence de pr\\u00e9sence estime la diff\\u00e9rence entre le nombre de personnes pr\\u00e9sentes dans une zone pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur et le nombre de personnes pr\\u00e9sentes pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nL\'indicateur est calcul\\u00e9 \\u00e0 partir de l\'indicateur de pr\\u00e9sence et du nombre de r\\u00e9f\\u00e9rence de personnes pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nSi le nombre de personnes pr\\u00e9sentes dans la zone a augment\\u00e9, l\'indicateur aura une valeur positive ; si le nombre a diminu\\u00e9, la valeur sera n\\u00e9gative.\\n\\nLes abonn\\u00e9s sont consid\\u00e9r\\u00e9s comme ayant \\u00e9t\\u00e9 pr\\u00e9sents dans une zone un jour donn\\u00e9 lorsqu\'un \\u00e9v\\u00e9nement r\\u00e9seau (par exemple un appel) est achemin\\u00e9 par une tour de t\\u00e9l\\u00e9phonie cellulaire dans cette zone.\"}}'),(16,'presence.presence_pctchangewithref','presence',4,'https://www.flowgeek.org/methods/calculating-mobility-indicators/presence-indicators#presence-difference-percentage-change','Percent change in presence difference','Estimates the change in the number of people present in an area during the day(s) selected by the user relative to the number of people present in the area in the reference period, expressed as a percentage.','The percentage change in presence indicator estimates the change in the number of people present in an area during the day(s) selected by the user relative to the number of people present in the area in the reference period. The difference is expressed as a percentage of a baseline value calculated for the reference period.\n\nThe indicator is calculated from the presence indicator and the baseline number of people during a reference period.\n\nIf the number of people present in the area has increased, the indicator will have a positive value; if the number of people present in the area has decreased, the value will be negative.\n\nSubscribers are determined to have been present in an area on a given day if they have a network event (e.g. a call) routed by a cell tower in that area.','diverging',2,NULL,NULL,NULL,NULL,'{\"fr\": {\"label\": \"Variation en pourcentage de la diff\\u00e9rence de pr\\u00e9sence\", \"description\": \"Estime la variation du nombre de personnes pr\\u00e9sentes dans une zone au cours du ou des jours s\\u00e9lectionn\\u00e9s par l\'utilisateur par rapport au nombre de personnes pr\\u00e9sentes dans la zone pendant la p\\u00e9riode de r\\u00e9f\\u00e9rence, exprim\\u00e9e en pourcentage.\", \"method\": \"L\'indicateur de variation de pr\\u00e9sence en pourcentage estime la variation du nombre de personnes pr\\u00e9sentes dans une zone pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur par rapport au nombre de personnes pr\\u00e9sentes dans la zone pendant la p\\u00e9riode de r\\u00e9f\\u00e9rence. La diff\\u00e9rence est exprim\\u00e9e en pourcentage d\'une valeur de r\\u00e9f\\u00e9rence calcul\\u00e9e pour la p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nL\'indicateur est calcul\\u00e9 \\u00e0 partir de l\'indicateur de pr\\u00e9sence et du nombre de r\\u00e9f\\u00e9rence de personnes pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nSi le nombre de personnes pr\\u00e9sentes dans la zone a augment\\u00e9, l\'indicateur aura une valeur positive ; si le nombre de personnes pr\\u00e9sentes dans la zone a diminu\\u00e9, la valeur sera n\\u00e9gative.\\n\\nLes abonn\\u00e9s sont consid\\u00e9r\\u00e9s comme ayant \\u00e9t\\u00e9 pr\\u00e9sents dans une zone un jour donn\\u00e9 lorsqu\'un \\u00e9v\\u00e9nement r\\u00e9seau (par exemple un appel) est achemin\\u00e9 par une tour de t\\u00e9l\\u00e9phonie cellulaire dans cette zone.\"}}'),(17,'presence.abnormality','presence',5,'https://www.flowgeek.org/methods/calculating-mobility-indicators/presence-indicators#presence-abnormality','Abnormality','Measures the deviation of the number of people present in a given area during the day(s) selected by the user relative to a reference period, expressed as an abnormality score (z-score).','The presence abnormality indicator measures the deviation of the number of people present in a given area during the day(s) selected by the user relative to a reference period, expressed as a z-score.\n\nA positive value for this indicator greater than 3 indicates a statistically significant increase in the number of people present in a given area; a value less than -3 indicates a statistically significant decrease in presence.\n\nThis indicator describes how unusual the number of people in an area is, given the amount of variation observed during the reference period. Higher absolute values indicate greater deviation from the normal variation in presence, and therefore greater probability that the change is meaningful. Such changes may be associated with specific events or may be caused by technical issues. Very large abnormalities (absolute values greater than 6), however, may also be indicative of a technical issue.\n\nThe indicator is calculated from the presence difference indicator and the mean absolute deviation in presence during a reference period.\n\nSubscribers are determined to have been present in an area on a given day if they have a network event (e.g. a call) routed by a cell tower in that area.','diverging',2,NULL,NULL,NULL,NULL,'{\"fr\": {\"label\": \"Anomalie\", \"description\": \"Mesure l\'\\u00e9cart du nombre de personnes pr\\u00e9sentes dans une zone donn\\u00e9e pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur par rapport \\u00e0 une p\\u00e9riode de r\\u00e9f\\u00e9rence, exprim\\u00e9 sous la forme d\'un score d\'anomalie (score z).\", \"method\": \"L\'indicateur d\'anomalie de pr\\u00e9sence mesure l\'\\u00e9cart du nombre de personnes pr\\u00e9sentes dans une zone donn\\u00e9e pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur par rapport \\u00e0 une p\\u00e9riode de r\\u00e9f\\u00e9rence, exprim\\u00e9 sous la forme d\'un score z.\\n\\nPour cet indicateur, une valeur positive sup\\u00e9rieure \\u00e0 3 indique une augmentation statistiquement significative du nombre de personnes pr\\u00e9sentes dans une zone donn\\u00e9e ; une valeur inf\\u00e9rieure \\u00e0 -3 indique une diminution statistiquement significative de la pr\\u00e9sence.\\n\\nCet indicateur d\\u00e9crit l\'ampleur du caract\\u00e8re inhabituel du nombre de personnes dans une zone, compte tenu de l\'ampleur de la variation observ\\u00e9e pendant la p\\u00e9riode de r\\u00e9f\\u00e9rence. Des valeurs absolues plus \\u00e9lev\\u00e9es indiquent un plus grand \\u00e9cart par rapport \\u00e0 la variation normale de pr\\u00e9sence, et donc une plus grande probabilit\\u00e9 que le changement soit significatif. Des changements de la sorte pourraient \\u00eatre associ\\u00e9s \\u00e0 des \\u00e9v\\u00e9nements sp\\u00e9cifiques ou caus\\u00e9s par des probl\\u00e8mes techniques. Toutefois, des anomalies tr\\u00e8s importantes (valeurs absolues sup\\u00e9rieures \\u00e0 6) pourraient \\u00e9galement indiquer un probl\\u00e8me technique.\\n\\nL\'indicateur est calcul\\u00e9 \\u00e0 partir de l\'indicateur de diff\\u00e9rence de pr\\u00e9sence et de l\'\\u00e9cart absolu moyen de pr\\u00e9sence pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nLes abonn\\u00e9s sont consid\\u00e9r\\u00e9s comme ayant \\u00e9t\\u00e9 pr\\u00e9sents dans une zone un jour donn\\u00e9 lorsqu\'un \\u00e9v\\u00e9nement r\\u00e9seau (par exemple un appel) est achemin\\u00e9 par une tour de t\\u00e9l\\u00e9phonie cellulaire dans cette zone.\"}}'),(18,'presence.trips_in','presence',6,'https://www.flowgeek.org/methods/calculating-mobility-indicators/presence-indicators#trips-in','Trips in','Estimates the number of trips into an area from any other areas during the day(s) selected by the user.','The trips in indicator estimates the number of trips into an area from any other areas during the day(s) selected by the user. When data shows multiple trips between areas in a single day for a given subscriber (from A to B, then B to C), then the indicator captures all trips (AB, BC).\n\nUnlike the travellers in indicator, which only counts each unique subscriber once, this indicator includes multiple trips into an area by the same subscriber.\n\nWe calculate the trips in indicator from the sum of the counts of subscribers who were present in an area of interest after being present in any other area during the day(s) selected by the user.\n\nSubscribers are determined to have been present in an area on a given day if they have a network event (e.g. a call) routed by a cell tower in that area.','sequential',0,0.000000000,NULL,NULL,NULL,'{\"fr\": {\"label\": \"D\\u00e9placements entrants\", \"description\": \"Estime le nombre de d\\u00e9placements dans une zone \\u00e0 partir d\'autres zones pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur.\", \"method\": \"L\'indicateur des d\\u00e9placements entrants estime le nombre de d\\u00e9placements dans une zone \\u00e0 partir d\'autres zones pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur. Lorsque les donn\\u00e9es indiquent des d\\u00e9placements multiples entre les zones au cours d\'une m\\u00eame journ\\u00e9e pour un abonn\\u00e9 donn\\u00e9 (de A \\u00e0 B, puis de B \\u00e0 C), l\'indicateur prend en compte tous les d\\u00e9placements (AB, BC).\\n\\n\\u00c0 la diff\\u00e9rence de l\'indicateur des voyageurs entrants, qui ne compte qu\'une seule fois chaque abonn\\u00e9 unique, cet indicateur inclut les d\\u00e9placements multiples dans une zone par le m\\u00eame abonn\\u00e9.\\n\\nNous calculons l\'indicateur des d\\u00e9placements entrants \\u00e0 partir de la somme des comptages des abonn\\u00e9s qui \\u00e9taient pr\\u00e9sents dans une zone d\'int\\u00e9r\\u00eat apr\\u00e8s avoir \\u00e9t\\u00e9 pr\\u00e9sents dans une autre zone pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur.\\n\\nLes abonn\\u00e9s sont consid\\u00e9r\\u00e9s comme ayant \\u00e9t\\u00e9 pr\\u00e9sents dans une zone un jour donn\\u00e9 lorsqu\'un \\u00e9v\\u00e9nement r\\u00e9seau (par exemple un appel) est achemin\\u00e9 par une tour de t\\u00e9l\\u00e9phonie cellulaire dans cette zone.\"}}'),(19,'presence.trips_out','presence',7,'https://www.flowgeek.org/methods/calculating-mobility-indicators/presence-indicators#trips-out','Trips out','Estimates the number of trips from an area to any other area during the day(s) selected by the user.','The trips out indicator estimates the number of trips from an area to any other area during the day(s) selected by the user. When data shows multiple trips in a single day for a given subscriber (from A to B, then B to C), then the indicator captures all trips (AB, BC).\n\nUnlike the travellers out indicator which only counts each unique subscriber once, this indicator also includes multiple trips out of an area by the same subscriber.\n\nWe calculate the trips in indicator from the sum of the counts of subscribers who were present in any other area after being present in an area of interest during the day(s) selected by the user.\n\nSubscribers are determined to have been present in an area on a given day if they have a network event (e.g. a call) routed by a cell tower in that area.','sequential',0,0.000000000,NULL,NULL,NULL,'{\"fr\": {\"label\": \"D\\u00e9placements sortants\", \"description\": \"Estime le nombre de d\\u00e9placements d\'une zone vers une autre zone pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur.\", \"method\": \"L\'indicateur de d\\u00e9placements sortants estime le nombre de d\\u00e9placements d\'une zone vers une autre zone au cours du ou des jours s\\u00e9lectionn\\u00e9s par l\'utilisateur. Lorsque les donn\\u00e9es indiquent plusieurs d\\u00e9placements dans une m\\u00eame journ\\u00e9e pour un abonn\\u00e9 donn\\u00e9 (de A \\u00e0 B, puis de B \\u00e0 C), l\'indicateur prend en compte tous les d\\u00e9placements (AB, BC).\\n\\n\\u00c0 la diff\\u00e9rence de l\'indicateur de voyageurs sortants qui ne compte qu\'une seule fois chaque abonn\\u00e9 unique, cet indicateur inclut \\u00e9galement les d\\u00e9placements multiples d\'un m\\u00eame abonn\\u00e9 hors d\'une zone.\\n\\nNous calculons l\'indicateur des d\\u00e9placements entrants \\u00e0 partir de la somme des comptages des abonn\\u00e9s qui \\u00e9taient pr\\u00e9sents dans une autre zone apr\\u00e8s avoir \\u00e9t\\u00e9 pr\\u00e9sents dans une zone d\'int\\u00e9r\\u00eat pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur.\\n\\nLes abonn\\u00e9s sont consid\\u00e9r\\u00e9s comme ayant \\u00e9t\\u00e9 pr\\u00e9sents dans une zone un jour donn\\u00e9 lorsqu\'un \\u00e9v\\u00e9nement r\\u00e9seau (par exemple un appel) est achemin\\u00e9 par une tour de t\\u00e9l\\u00e9phonie cellulaire dans cette zone.\"}}'),(20,'movements.travellers','movements',1,'https://www.flowgeek.org/methods/calculating-mobility-indicators/movement-indicators#travellers','Travellers','Estimates the number of people visiting area B after being present in area A during the day(s) selected by the user.','The travellers indicator estimates the number of people visiting area B after being present in area A (i.e. travelled from A to B) during the day(s) selected by the user.\n\nWe calculate the travellers indicator from the number of subscribers who were present in area B after being present in area A during the day(s) selected by the user.\n\nSubscribers are determined to have been present in an area on a given day if they have a network event (e.g. a call) routed by a cell tower in that area.','sequential',0,0.000000000,NULL,NULL,NULL,'{\"fr\": {\"label\": \"Voyageurs\", \"description\": \"Estime le nombre de personnes qui visitent la zone B apr\\u00e8s avoir \\u00e9t\\u00e9 pr\\u00e9sentes dans la zone A pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur.\", \"method\": \"L\'indicateur de voyageurs estime le nombre de personnes qui visitent la zone B apr\\u00e8s avoir \\u00e9t\\u00e9 pr\\u00e9sentes dans la zone A (c\'est-\\u00e0-dire avoir voyag\\u00e9 de A \\u00e0 B) pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur.\\n\\nNous calculons l\'indicateur de voyageurs \\u00e0 partir du nombre d\'abonn\\u00e9s qui \\u00e9taient pr\\u00e9sents dans la zone B apr\\u00e8s avoir \\u00e9t\\u00e9 pr\\u00e9sents dans la zone A au cours du ou des jours s\\u00e9lectionn\\u00e9s par l\'utilisateur.\\n\\nLes abonn\\u00e9s sont consid\\u00e9r\\u00e9s comme ayant \\u00e9t\\u00e9 pr\\u00e9sents dans une zone un jour donn\\u00e9 lorsqu\'un \\u00e9v\\u00e9nement r\\u00e9seau (par exemple un appel) est achemin\\u00e9 par une tour de t\\u00e9l\\u00e9phonie cellulaire dans cette zone.\"}}'),(21,'movements.travellers_diffwithref','movements',2,'https://www.flowgeek.org/methods/calculating-mobility-indicators/movement-indicators#travellers-difference','Travellers difference','Estimates the change in the number of people travelling from area A to B during a period of time compared to the baseline number of travellers from A to B during a reference period.','The travellers indicator estimates the number of people visiting area B after being present in area A (i.e. travelled from A to B) during the day(s) selected by the user.\n\nWe calculate the travellers indicator from the number of subscribers who were present in area B after being present in area A during the day(s) selected by the user.\n\nSubscribers are determined to have been present in an area on a given day if they have a network event (e.g. a call) routed by a cell tower in that area.','diverging',0,NULL,NULL,NULL,NULL,'{\"fr\": {\"label\": \"Diff\\u00e9rence de voyageurs\", \"description\": \"Estime la variation du nombre de personnes voyageant de la zone A \\u00e0 B pendant une p\\u00e9riode donn\\u00e9e par rapport au nombre de base de voyageurs de A \\u00e0 B pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence.\", \"method\": \"L\'indicateur de diff\\u00e9rence de voyageurs estime la variation du nombre de personnes voyageant de la zone A \\u00e0 la zone B pendant une p\\u00e9riode donn\\u00e9e par rapport au nombre de voyageurs de r\\u00e9f\\u00e9rence pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nSi le nombre de voyageurs a augment\\u00e9, l\'indicateur aura une valeur positive ; si le nombre de voyageurs a diminu\\u00e9, la valeur sera n\\u00e9gative.\\n\\nNous calculons l\'indicateur de diff\\u00e9rence de voyageurs \\u00e0 partir de l\'indicateur de voyageurs et du nombre de r\\u00e9f\\u00e9rence de voyageurs entre des paires de zones pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nLes abonn\\u00e9s sont consid\\u00e9r\\u00e9s comme ayant \\u00e9t\\u00e9 pr\\u00e9sents dans une zone un jour donn\\u00e9 lorsqu\'un \\u00e9v\\u00e9nement r\\u00e9seau (par exemple un appel) est achemin\\u00e9 par une tour de t\\u00e9l\\u00e9phonie cellulaire dans cette zone.\"}}'),(22,'movements.travellers_pctchangewithref','movements',3,'https://www.flowgeek.org/methods/calculating-mobility-indicators/movement-indicators#travellers-difference-percentage-change','Percent change in travellers difference','Estimates the change in the number of people travelling from area A to B during the day(s) selected by the user relative to the baseline number of travellers from A to B in the reference period, expressed as a percentage.','The percentage change in travellers indicator estimates the change in the number of people travelling from area A to area B during the day(s) selected by the user relative to the baseline number of travellers from A to B in the reference period. The difference is expressed as a percentage of a baseline value calculated for the reference period.\n\nIf the number of travellers has increased, the indicator will have a positive value; if the number of travellers has decreased, the value will be negative.\n\nWe calculate the percentage change in travellers difference indicator from the travellers indicator and the baseline number of travellers between pairs of areas during the day(s) selected by the user.\n\nSubscribers are determined to have been present in an area on a given day if they have a network event (e.g. a call) routed by a cell tower in that area.','diverging',2,NULL,NULL,NULL,NULL,'{\"fr\": {\"label\": \"Variation en pourcentage de la diff\\u00e9rence de voyageurs\", \"description\": \"Estime la variation du nombre de personnes voyageant de la zone A \\u00e0 B pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur par rapport au nombre de r\\u00e9f\\u00e9rence de voyageurs de A \\u00e0 B pendant la p\\u00e9riode de r\\u00e9f\\u00e9rence, exprim\\u00e9e en pourcentage.\", \"method\": \"La variation en pourcentage de l\'indicateur de voyageurs estime la variation du nombre de personnes voyageant de la zone A \\u00e0 B pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur par rapport au nombre de r\\u00e9f\\u00e9rence de voyageurs de A \\u00e0 B pendant la p\\u00e9riode de r\\u00e9f\\u00e9rence. La diff\\u00e9rence est exprim\\u00e9e en pourcentage d\'une valeur de r\\u00e9f\\u00e9rence calcul\\u00e9e pour la p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nSi le nombre de voyageurs a augment\\u00e9, l\'indicateur aura une valeur positive ; si le nombre de voyageurs a diminu\\u00e9, la valeur sera n\\u00e9gative.\\n\\nNous calculons le pourcentage de variation de l\'indicateur de diff\\u00e9rence de voyageurs \\u00e0 partir de l\'indicateur de voyageurs et du nombre de voyageurs de r\\u00e9f\\u00e9rence entre les paires de zones pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur.\\n\\nLes abonn\\u00e9s sont consid\\u00e9r\\u00e9s comme ayant \\u00e9t\\u00e9 pr\\u00e9sents dans une zone un jour donn\\u00e9 lorsqu\'un \\u00e9v\\u00e9nement r\\u00e9seau (par exemple un appel) est achemin\\u00e9 par une tour de t\\u00e9l\\u00e9phonie cellulaire dans cette zone.\"}}'),(23,'movements.abnormality','movements',4,'https://www.flowgeek.org/methods/calculating-mobility-indicators/movement-indicators#travellers-abnormality','Abnormality','Measures the deviation in the estimated number of people travelling from area A to B during the day(s) selected by the user from the numbers of travellers from A to B estimated during a reference period, expressed as a z-score.','The travellers abnormality indicator measures the deviation in the estimated number of people travelling from area A to area B during the day(s) selected by the user from the numbers of travellers from A to B estimated during a reference period, expressed as a z-score.\n\nA positive value for this indicator greater than 3 indicates a statistically significant increase in the number of travellers; a value less than -3 indicates a statistically significant decrease.\n\nThis indicator describes how unusual the number of travellers from area A to area B is, given the amount of variation observed during the reference period. Higher absolute values indicate greater deviation from the normal variation in numbers of travellers, and therefore greater probability that the change is meaningful. Such changes may be associated with specific events or may be caused by technical issues. Very large abnormalities (absolute values greater than 6), however, may also be indicative of a technical issue.\n\nWe calculate the travellers abnormality indicator using the travellers difference indicator and the mean absolute deviation in the number of travellers between pairs of areas during a reference period.\n\nSubscribers are determined to have been present in an area on a given day if they have a network event (e.g. a call) routed by a cell tower in that area.','diverging',2,-6.000000000,6.000000000,NULL,'[{\"max\": 3.0, \"min\": -3.0, \"width\": \"2%\"}, {\"max\": -3.0, \"min\": -6.0, \"width\": \"20%\"}, {\"max\": 6.0, \"min\": 3.0, \"width\": \"20%\"}, {\"max\": -6.0, \"min\": null, \"width\": \"80%\"}, {\"max\": null, \"min\": 6.0, \"width\": \"80%\"}]','{\"fr\": {\"label\": \"Anomalie\", \"description\": \"Mesure l\'\\u00e9cart entre le nombre estim\\u00e9 de personnes voyageant de la zone A \\u00e0 B pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur et le nombre de voyageurs de A \\u00e0 B estim\\u00e9 pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence, exprim\\u00e9 sous la forme d\'un score z.\", \"method\": \"L\'indicateur d\'anomalie des voyageurs mesure l\'\\u00e9cart entre le nombre estim\\u00e9 de personnes voyageant de la zone A \\u00e0 la zone B pendant le ou les jours s\\u00e9lectionn\\u00e9s par l\'utilisateur et le nombre de voyageurs de A \\u00e0 B estim\\u00e9 pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence, exprim\\u00e9 sous la forme d\'un score z. \\n\\nPour cet indicateur, une valeur positive sup\\u00e9rieure \\u00e0 3 indique une augmentation statistiquement significative du nombre de voyageurs ; une valeur inf\\u00e9rieure \\u00e0 -3 indique une diminution statistiquement significative.\\n\\nCet indicateur d\\u00e9crit l\'ampleur du caract\\u00e8re inhabituel du nombre de voyageurs de la zone A vers la zone B, compte tenu de l\'ampleur de la variation observ\\u00e9e pendant la p\\u00e9riode de r\\u00e9f\\u00e9rence. Des valeurs absolues plus \\u00e9lev\\u00e9es indiquent un plus grand \\u00e9cart par rapport \\u00e0 la variation normale du nombre de voyageurs, et donc une plus grande probabilit\\u00e9 que le changement soit significatif. Des changements de la sorte pourraient \\u00eatre associ\\u00e9s \\u00e0 des \\u00e9v\\u00e9nements sp\\u00e9cifiques ou caus\\u00e9s par des probl\\u00e8mes techniques. Toutefois, des anomalies tr\\u00e8s importantes (valeurs absolues sup\\u00e9rieures \\u00e0 6) pourraient \\u00e9galement indiquer un probl\\u00e8me technique.\\n\\nNous calculons l\'indicateur d\'anomalie des voyageurs en combinant l\'indicateur de diff\\u00e9rence des voyageurs et l\'\\u00e9cart absolu moyen du nombre de voyageurs entre des paires de zones pendant une p\\u00e9riode de r\\u00e9f\\u00e9rence.\\n\\nLes abonn\\u00e9s sont consid\\u00e9r\\u00e9s comme ayant \\u00e9t\\u00e9 pr\\u00e9sents dans une zone un jour donn\\u00e9 lorsqu\'un \\u00e9v\\u00e9nement r\\u00e9seau (par exemple un appel) est achemin\\u00e9 par une tour de t\\u00e9l\\u00e9phonie cellulaire dans cette zone.\"}}');
/*!40000 ALTER TABLE `indicator` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` VALUES (1,1,'en','English','🇬🇧',1),(2,2,'fr','French','🇫🇷',0),(3,3,'ht','Haitian Creole','🇭🇹',0);
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `metadata`
--

LOCK TABLES `metadata` WRITE;
/*!40000 ALTER TABLE `metadata` DISABLE KEYS */;
INSERT INTO `metadata` VALUES (1,1,'2023-02-21T13:36:08','v0.1-demo','residents','residents.residents',3,2,'2020-02-01 00:00:00',730,544650),(2,2,'2023-02-21T13:36:08','v0.1-demo','residents','residents.residents',3,2,'2020-03-01 00:00:00',480,540640),(3,3,'2023-02-21T13:36:08','v0.1-demo','residents','residents.residents',3,2,'2020-04-01 00:00:00',730,547210),(4,4,'2023-02-21T13:36:08','v0.1-demo','residents','residents.residents',3,2,'2020-07-01 00:00:00',480,553560),(5,5,'2023-02-21T13:36:08','v0.1-demo','residents','residents.residents',3,2,'2020-06-01 00:00:00',480,552290),(6,6,'2023-02-21T13:36:08','v0.1-demo','residents','residents.residents',3,2,'2020-05-01 00:00:00',480,541950),(7,7,'2023-02-21T13:36:09','v0.1-demo','residents','residents.residents_perKm2',3,2,'2020-03-01 00:00:00',20,31350),(8,8,'2023-02-21T13:36:09','v0.1-demo','residents','residents.residents_perKm2',3,2,'2020-04-01 00:00:00',20,31420),(9,9,'2023-02-21T13:36:09','v0.1-demo','residents','residents.residents_perKm2',3,2,'2020-06-01 00:00:00',20,32170),(10,10,'2023-02-21T13:36:09','v0.1-demo','residents','residents.residents_perKm2',3,2,'2020-02-01 00:00:00',20,29940),(11,11,'2023-02-21T13:36:09','v0.1-demo','residents','residents.residents_perKm2',3,2,'2020-05-01 00:00:00',20,32240),(12,12,'2023-02-21T13:36:09','v0.1-demo','residents','residents.residents_perKm2',3,2,'2020-07-01 00:00:00',20,32130),(13,13,'2023-02-21T13:36:09','v0.1-demo','residents','residents.arrived',3,2,'2020-07-01 00:00:00',70,257970),(14,14,'2023-02-21T13:36:09','v0.1-demo','residents','residents.arrived',3,2,'2020-05-01 00:00:00',90,312430),(15,15,'2023-02-21T13:36:09','v0.1-demo','residents','residents.arrived',3,2,'2020-06-01 00:00:00',100,436830),(16,16,'2023-02-21T13:36:09','v0.1-demo','residents','residents.arrived',3,2,'2020-03-01 00:00:00',90,243470),(17,17,'2023-02-21T13:36:09','v0.1-demo','residents','residents.arrived',3,2,'2020-04-01 00:00:00',90,267070),(18,18,'2023-02-21T13:36:09','v0.1-demo','residents','residents.arrived',3,2,'2020-02-01 00:00:00',90,446860),(19,19,'2023-02-21T13:36:10','v0.1-demo','residents','residents.departed',3,2,'2020-06-01 00:00:00',100,426500),(20,20,'2023-02-21T13:36:10','v0.1-demo','residents','residents.departed',3,2,'2020-02-01 00:00:00',90,427110),(21,21,'2023-02-21T13:36:10','v0.1-demo','residents','residents.departed',3,2,'2020-03-01 00:00:00',90,247470),(22,22,'2023-02-21T13:36:10','v0.1-demo','residents','residents.departed',3,2,'2020-07-01 00:00:00',70,256700),(23,23,'2023-02-21T13:36:10','v0.1-demo','residents','residents.departed',3,2,'2020-05-01 00:00:00',90,317680),(24,24,'2023-02-21T13:36:10','v0.1-demo','residents','residents.departed',3,2,'2020-04-01 00:00:00',90,260510),(25,25,'2023-02-21T13:36:10','v0.1-demo','residents','residents.delta_arrived',3,2,'2020-06-01 00:00:00',-5150,10330),(26,26,'2023-02-21T13:36:10','v0.1-demo','residents','residents.delta_arrived',3,2,'2020-04-01 00:00:00',-5910,6560),(27,27,'2023-02-21T13:36:10','v0.1-demo','residents','residents.delta_arrived',3,2,'2020-03-01 00:00:00',-4000,12640),(28,28,'2023-02-21T13:36:10','v0.1-demo','residents','residents.delta_arrived',3,2,'2020-02-01 00:00:00',-8310,19760),(29,29,'2023-02-21T13:36:10','v0.1-demo','residents','residents.delta_arrived',3,2,'2020-05-01 00:00:00',-5260,7280),(30,30,'2023-02-21T13:36:10','v0.1-demo','residents','residents.delta_arrived',3,2,'2020-07-01 00:00:00',-4180,5200),(31,31,'2023-02-21T13:36:10','v0.1-demo','residents','residents.residents_diffwithref',3,2,'2020-07-01 00:00:00',-18200,14530),(32,32,'2023-02-21T13:36:10','v0.1-demo','residents','residents.residents_diffwithref',3,2,'2020-04-01 00:00:00',-14590,10430),(33,33,'2023-02-21T13:36:10','v0.1-demo','residents','residents.residents_diffwithref',3,2,'2020-02-01 00:00:00',-10180,10360),(34,34,'2023-02-21T13:36:10','v0.1-demo','residents','residents.residents_diffwithref',3,2,'2020-03-01 00:00:00',-12180,12870),(35,35,'2023-02-21T13:36:10','v0.1-demo','residents','residents.residents_diffwithref',3,2,'2020-05-01 00:00:00',-12290,15460),(36,36,'2023-02-21T13:36:10','v0.1-demo','residents','residents.residents_diffwithref',3,2,'2020-06-01 00:00:00',-15800,14870),(37,37,'2023-02-21T13:36:11','v0.1-demo','residents','residents.abnormality',3,2,'2020-02-01 00:00:00',-7,14),(38,38,'2023-02-21T13:36:11','v0.1-demo','residents','residents.abnormality',3,2,'2020-03-01 00:00:00',-10,11),(39,39,'2023-02-21T13:36:11','v0.1-demo','residents','residents.abnormality',3,2,'2020-05-01 00:00:00',-12,9),(40,40,'2023-02-21T13:36:11','v0.1-demo','residents','residents.abnormality',3,2,'2020-07-01 00:00:00',-7,7),(41,41,'2023-02-21T13:36:11','v0.1-demo','residents','residents.abnormality',3,2,'2020-04-01 00:00:00',-10,11),(42,42,'2023-02-21T13:36:11','v0.1-demo','residents','residents.abnormality',3,2,'2020-06-01 00:00:00',-9,11),(43,43,'2023-02-21T13:36:11','v0.1-demo','residents','residents.residents_pctchangewithref',3,2,'2020-02-01 00:00:00',-5,7),(44,44,'2023-02-21T13:36:11','v0.1-demo','residents','residents.residents_pctchangewithref',3,2,'2020-04-01 00:00:00',-6,6),(45,45,'2023-02-21T13:36:11','v0.1-demo','residents','residents.residents_pctchangewithref',3,2,'2020-06-01 00:00:00',-7,5),(46,46,'2023-02-21T13:36:11','v0.1-demo','residents','residents.residents_pctchangewithref',3,2,'2020-03-01 00:00:00',-5,8),(47,47,'2023-02-21T13:36:11','v0.1-demo','residents','residents.residents_pctchangewithref',3,2,'2020-05-01 00:00:00',-5,6),(48,48,'2023-02-21T13:36:11','v0.1-demo','residents','residents.residents_pctchangewithref',3,2,'2020-07-01 00:00:00',-5,5),(49,49,'2023-02-21T13:36:19','v0.1-demo','relocations','relocations.relocations',3,2,'2020-03-01 00:00:00',60,23320),(50,50,'2023-02-21T13:36:19','v0.1-demo','relocations','relocations.relocations',3,2,'2020-04-01 00:00:00',60,22160),(51,51,'2023-02-21T13:36:19','v0.1-demo','relocations','relocations.relocations',3,2,'2020-05-01 00:00:00',60,29070),(52,52,'2023-02-21T13:36:19','v0.1-demo','relocations','relocations.relocations',3,2,'2020-02-01 00:00:00',60,42630),(53,53,'2023-02-21T13:36:19','v0.1-demo','relocations','relocations.relocations',3,2,'2020-07-01 00:00:00',60,18910),(54,54,'2023-02-21T13:36:19','v0.1-demo','relocations','relocations.relocations',3,2,'2020-06-01 00:00:00',60,40490),(55,55,'2023-02-21T13:36:21','v0.1-demo','relocations','relocations.relocations_diffwithref',3,2,'2020-04-01 00:00:00',-7760,7650),(56,56,'2023-02-21T13:36:21','v0.1-demo','relocations','relocations.relocations_diffwithref',3,2,'2020-06-01 00:00:00',-9020,18880),(57,57,'2023-02-21T13:36:21','v0.1-demo','relocations','relocations.relocations_diffwithref',3,2,'2020-02-01 00:00:00',-8720,21290),(58,58,'2023-02-21T13:36:21','v0.1-demo','relocations','relocations.relocations_diffwithref',3,2,'2020-05-01 00:00:00',-3910,11070),(59,59,'2023-02-21T13:36:21','v0.1-demo','relocations','relocations.relocations_diffwithref',3,2,'2020-03-01 00:00:00',-8080,9010),(60,60,'2023-02-21T13:36:21','v0.1-demo','relocations','relocations.relocations_diffwithref',3,2,'2020-07-01 00:00:00',-8730,9120),(61,61,'2023-02-21T13:36:24','v0.1-demo','relocations','relocations.abnormality',3,2,'2020-04-01 00:00:00',-2,16),(62,62,'2023-02-21T13:36:24','v0.1-demo','relocations','relocations.abnormality',3,2,'2020-02-01 00:00:00',-2,11),(63,63,'2023-02-21T13:36:24','v0.1-demo','relocations','relocations.abnormality',3,2,'2020-07-01 00:00:00',-2,11),(64,64,'2023-02-21T13:36:24','v0.1-demo','relocations','relocations.abnormality',3,2,'2020-03-01 00:00:00',-2,9),(65,65,'2023-02-21T13:36:24','v0.1-demo','relocations','relocations.abnormality',3,2,'2020-06-01 00:00:00',-2,10),(66,66,'2023-02-21T13:36:24','v0.1-demo','relocations','relocations.abnormality',3,2,'2020-05-01 00:00:00',-3,13),(67,67,'2023-02-21T13:36:26','v0.1-demo','relocations','relocations.relocations_pctchangewithref',3,2,'2020-03-01 00:00:00',-50,184),(68,68,'2023-02-21T13:36:26','v0.1-demo','relocations','relocations.relocations_pctchangewithref',3,2,'2020-07-01 00:00:00',-45,155),(69,69,'2023-02-21T13:36:26','v0.1-demo','relocations','relocations.relocations_pctchangewithref',3,2,'2020-04-01 00:00:00',-46,209),(70,70,'2023-02-21T13:36:26','v0.1-demo','relocations','relocations.relocations_pctchangewithref',3,2,'2020-05-01 00:00:00',-50,162),(71,71,'2023-02-21T13:36:26','v0.1-demo','relocations','relocations.relocations_pctchangewithref',3,2,'2020-06-01 00:00:00',-52,172),(72,72,'2023-02-21T13:36:26','v0.1-demo','relocations','relocations.relocations_pctchangewithref',3,2,'2020-02-01 00:00:00',-48,160),(73,73,'2023-02-21T13:36:30','v0.1-demo','presence','presence.presence',3,4,'2020-02-07 00:00:00',1920,449010),(74,74,'2023-02-21T13:36:30','v0.1-demo','presence','presence.presence',3,4,'2020-02-02 00:00:00',2080,480630),(75,75,'2023-02-21T13:36:30','v0.1-demo','presence','presence.presence',3,4,'2020-02-06 00:00:00',2220,474690),(76,76,'2023-02-21T13:36:30','v0.1-demo','presence','presence.presence',3,4,'2020-02-05 00:00:00',2400,576950),(77,77,'2023-02-21T13:36:30','v0.1-demo','presence','presence.presence',3,4,'2020-02-04 00:00:00',2100,403550),(78,78,'2023-02-21T13:36:30','v0.1-demo','presence','presence.presence',3,4,'2020-02-03 00:00:00',2720,611190),(79,79,'2023-02-21T13:36:30','v0.1-demo','presence','presence.presence',3,4,'2020-02-01 00:00:00',1810,557520),(80,80,'2023-02-21T13:36:31','v0.1-demo','presence','presence.presence_perKm2',3,4,'2020-02-01 00:00:00',40,30350),(81,81,'2023-02-21T13:36:31','v0.1-demo','presence','presence.presence_perKm2',3,4,'2020-02-03 00:00:00',40,33280),(82,82,'2023-02-21T13:36:31','v0.1-demo','presence','presence.presence_perKm2',3,4,'2020-02-05 00:00:00',30,34010),(83,83,'2023-02-21T13:36:31','v0.1-demo','presence','presence.presence_perKm2',3,4,'2020-02-07 00:00:00',40,28230),(84,84,'2023-02-21T13:36:31','v0.1-demo','presence','presence.presence_perKm2',3,4,'2020-02-06 00:00:00',40,31470),(85,85,'2023-02-21T13:36:31','v0.1-demo','presence','presence.presence_perKm2',3,4,'2020-02-02 00:00:00',40,26470),(86,86,'2023-02-21T13:36:31','v0.1-demo','presence','presence.presence_perKm2',3,4,'2020-02-04 00:00:00',30,29030),(87,87,'2023-02-21T13:36:31','v0.1-demo','presence','presence.trips_in',3,4,'2020-02-03 00:00:00',60,156180),(88,88,'2023-02-21T13:36:31','v0.1-demo','presence','presence.trips_in',3,4,'2020-02-04 00:00:00',60,156790),(89,89,'2023-02-21T13:36:31','v0.1-demo','presence','presence.trips_in',3,4,'2020-02-02 00:00:00',60,156240),(90,90,'2023-02-21T13:36:31','v0.1-demo','presence','presence.trips_in',3,4,'2020-02-06 00:00:00',60,156160),(91,91,'2023-02-21T13:36:31','v0.1-demo','presence','presence.trips_in',3,4,'2020-02-07 00:00:00',60,156200),(92,92,'2023-02-21T13:36:31','v0.1-demo','presence','presence.trips_in',3,4,'2020-02-05 00:00:00',60,156300),(93,93,'2023-02-21T13:36:31','v0.1-demo','presence','presence.trips_in',3,4,'2020-02-01 00:00:00',70,156360),(94,94,'2023-02-21T13:36:31','v0.1-demo','presence','presence.trips_out',3,4,'2020-02-03 00:00:00',60,154970),(95,95,'2023-02-21T13:36:31','v0.1-demo','presence','presence.trips_out',3,4,'2020-02-01 00:00:00',70,155860),(96,96,'2023-02-21T13:36:31','v0.1-demo','presence','presence.trips_out',3,4,'2020-02-05 00:00:00',60,156200),(97,97,'2023-02-21T13:36:31','v0.1-demo','presence','presence.trips_out',3,4,'2020-02-07 00:00:00',60,157430),(98,98,'2023-02-21T13:36:31','v0.1-demo','presence','presence.trips_out',3,4,'2020-02-06 00:00:00',60,158550),(99,99,'2023-02-21T13:36:31','v0.1-demo','presence','presence.trips_out',3,4,'2020-02-02 00:00:00',60,157690),(100,100,'2023-02-21T13:36:31','v0.1-demo','presence','presence.trips_out',3,4,'2020-02-04 00:00:00',60,155250),(101,101,'2023-02-21T13:36:32','v0.1-demo','presence','presence.abnormality',3,4,'2020-02-01 00:00:00',-2,2),(102,102,'2023-02-21T13:36:32','v0.1-demo','presence','presence.abnormality',3,4,'2020-02-07 00:00:00',-2,2),(103,103,'2023-02-21T13:36:32','v0.1-demo','presence','presence.abnormality',3,4,'2020-02-03 00:00:00',-2,2),(104,104,'2023-02-21T13:36:32','v0.1-demo','presence','presence.abnormality',3,4,'2020-02-04 00:00:00',-1,2),(105,105,'2023-02-21T13:36:32','v0.1-demo','presence','presence.abnormality',3,4,'2020-02-06 00:00:00',-2,2),(106,106,'2023-02-21T13:36:32','v0.1-demo','presence','presence.abnormality',3,4,'2020-02-05 00:00:00',-2,2),(107,107,'2023-02-21T13:36:32','v0.1-demo','presence','presence.abnormality',3,4,'2020-02-02 00:00:00',-2,2),(108,108,'2023-02-21T13:36:32','v0.1-demo','presence','presence.presence_diffwithref',3,4,'2020-02-02 00:00:00',-64900,43610),(109,109,'2023-02-21T13:36:32','v0.1-demo','presence','presence.presence_diffwithref',3,4,'2020-02-04 00:00:00',-141980,36460),(110,110,'2023-02-21T13:36:32','v0.1-demo','presence','presence.presence_diffwithref',3,4,'2020-02-01 00:00:00',-74800,44830),(111,111,'2023-02-21T13:36:32','v0.1-demo','presence','presence.presence_diffwithref',3,4,'2020-02-07 00:00:00',-96520,60690),(112,112,'2023-02-21T13:36:32','v0.1-demo','presence','presence.presence_diffwithref',3,4,'2020-02-05 00:00:00',-53000,31410),(113,113,'2023-02-21T13:36:32','v0.1-demo','presence','presence.presence_diffwithref',3,4,'2020-02-03 00:00:00',-55230,65650),(114,114,'2023-02-21T13:36:32','v0.1-demo','presence','presence.presence_diffwithref',3,4,'2020-02-06 00:00:00',-70840,73430),(115,115,'2023-02-21T13:36:33','v0.1-demo','presence','presence.presence_pctchangewithref',3,4,'2020-02-03 00:00:00',-27,30),(116,116,'2023-02-21T13:36:33','v0.1-demo','presence','presence.presence_pctchangewithref',3,4,'2020-02-01 00:00:00',-27,25),(117,117,'2023-02-21T13:36:33','v0.1-demo','presence','presence.presence_pctchangewithref',3,4,'2020-02-05 00:00:00',-29,25),(118,118,'2023-02-21T13:36:33','v0.1-demo','presence','presence.presence_pctchangewithref',3,4,'2020-02-07 00:00:00',-28,25),(119,119,'2023-02-21T13:36:33','v0.1-demo','presence','presence.presence_pctchangewithref',3,4,'2020-02-06 00:00:00',-26,32),(120,120,'2023-02-21T13:36:33','v0.1-demo','presence','presence.presence_pctchangewithref',3,4,'2020-02-04 00:00:00',-27,30),(121,121,'2023-02-21T13:36:33','v0.1-demo','presence','presence.presence_pctchangewithref',3,4,'2020-02-02 00:00:00',-21,27),(122,122,'2023-02-21T13:36:41','v0.1-demo','movements','movements.travellers',3,4,'2020-02-07 00:00:00',60,17390),(123,123,'2023-02-21T13:36:41','v0.1-demo','movements','movements.travellers',3,4,'2020-02-04 00:00:00',60,17460),(124,124,'2023-02-21T13:36:41','v0.1-demo','movements','movements.travellers',3,4,'2020-02-03 00:00:00',60,17320),(125,125,'2023-02-21T13:36:41','v0.1-demo','movements','movements.travellers',3,4,'2020-02-05 00:00:00',60,17360),(126,126,'2023-02-21T13:36:41','v0.1-demo','movements','movements.travellers',3,4,'2020-02-01 00:00:00',60,17430),(127,127,'2023-02-21T13:36:41','v0.1-demo','movements','movements.travellers',3,4,'2020-02-06 00:00:00',60,17620),(128,128,'2023-02-21T13:36:41','v0.1-demo','movements','movements.travellers',3,4,'2020-02-02 00:00:00',60,17180),(129,129,'2023-02-21T13:36:43','v0.1-demo','movements','movements.abnormality',3,4,'2020-02-03 00:00:00',-5,3),(130,130,'2023-02-21T13:36:43','v0.1-demo','movements','movements.abnormality',3,4,'2020-02-05 00:00:00',-4,4),(131,131,'2023-02-21T13:36:43','v0.1-demo','movements','movements.abnormality',3,4,'2020-02-01 00:00:00',-3,3),(132,132,'2023-02-21T13:36:43','v0.1-demo','movements','movements.abnormality',3,4,'2020-02-02 00:00:00',-4,3),(133,133,'2023-02-21T13:36:43','v0.1-demo','movements','movements.abnormality',3,4,'2020-02-04 00:00:00',-3,4),(134,134,'2023-02-21T13:36:43','v0.1-demo','movements','movements.abnormality',3,4,'2020-02-06 00:00:00',-3,4),(135,135,'2023-02-21T13:36:43','v0.1-demo','movements','movements.abnormality',3,4,'2020-02-07 00:00:00',-3,3),(136,136,'2023-02-21T13:36:45','v0.1-demo','movements','movements.travellers_diffwithref',3,4,'2020-02-07 00:00:00',-99,155),(137,137,'2023-02-21T13:36:45','v0.1-demo','movements','movements.travellers_diffwithref',3,4,'2020-02-04 00:00:00',-146,221),(138,138,'2023-02-21T13:36:45','v0.1-demo','movements','movements.travellers_diffwithref',3,4,'2020-02-06 00:00:00',-244,383),(139,139,'2023-02-21T13:36:45','v0.1-demo','movements','movements.travellers_diffwithref',3,4,'2020-02-03 00:00:00',-239,168),(140,140,'2023-02-21T13:36:45','v0.1-demo','movements','movements.travellers_diffwithref',3,4,'2020-02-02 00:00:00',-141,169),(141,141,'2023-02-21T13:36:45','v0.1-demo','movements','movements.travellers_diffwithref',3,4,'2020-02-01 00:00:00',-64,189),(142,142,'2023-02-21T13:36:45','v0.1-demo','movements','movements.travellers_diffwithref',3,4,'2020-02-05 00:00:00',-133,242),(143,143,'2023-02-21T13:36:47','v0.1-demo','movements','movements.travellers_pctchangewithref',3,4,'2020-02-03 00:00:00',-5,4),(144,144,'2023-02-21T13:36:47','v0.1-demo','movements','movements.travellers_pctchangewithref',3,4,'2020-02-01 00:00:00',-4,5),(145,145,'2023-02-21T13:36:47','v0.1-demo','movements','movements.travellers_pctchangewithref',3,4,'2020-02-07 00:00:00',-4,4),(146,146,'2023-02-21T13:36:47','v0.1-demo','movements','movements.travellers_pctchangewithref',3,4,'2020-02-02 00:00:00',-5,4),(147,147,'2023-02-21T13:36:47','v0.1-demo','movements','movements.travellers_pctchangewithref',3,4,'2020-02-06 00:00:00',-4,4),(148,148,'2023-02-21T13:36:47','v0.1-demo','movements','movements.travellers_pctchangewithref',3,4,'2020-02-05 00:00:00',-5,4),(149,149,'2023-02-21T13:36:47','v0.1-demo','movements','movements.travellers_pctchangewithref',3,4,'2020-02-04 00:00:00',-4,4);
/*!40000 ALTER TABLE `metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Create admin mappings for test data
--



/*!40000 ALTER TABLE `flowkit_ui_backend`.`scope_mapping` DISABLE KEYS */;
INSERT INTO `flowkit_ui_backend`.`scope_mapping` VALUES (1, 'admin', 1),(2, 'admin', 2),(3, 'admin', 3),(4, 'admin', 4),(5, 'admin', 5),(6, 'admin', 6),(7, 'admin', 7),(8, 'admin', 8),(9, 'admin', 9),(10, 'admin', 10),(11, 'admin', 11),(12, 'admin', 12),(13, 'admin', 13),(14, 'admin', 14),(15, 'admin', 15),(16, 'admin', 16),(17, 'admin', 17),(18, 'admin', 18),(19, 'admin', 19),(20, 'admin', 20),(21, 'admin', 21),(22, 'admin', 22),(23, 'admin', 23),(24, 'admin', 24),(25, 'admin', 25),(26, 'admin', 26),(27, 'admin', 27),(28, 'admin', 28),(29, 'admin', 29),(30, 'admin', 30),(31, 'admin', 31),(32, 'admin', 32),(33, 'admin', 33),(34, 'admin', 34),(35, 'admin', 35),(36, 'admin', 36),(37, 'admin', 37),(38, 'admin', 38),(39, 'admin', 39),(40, 'admin', 40),(41, 'admin', 41),(42, 'admin', 42),(43, 'admin', 43),(44, 'admin', 44),(45, 'admin', 45),(46, 'admin', 46),(47, 'admin', 47),(48, 'admin', 48),(49, 'admin', 49),(50, 'admin', 50),(51, 'admin', 51),(52, 'admin', 52),(53, 'admin', 53),(54, 'admin', 54),(55, 'admin', 55),(56, 'admin', 56),(57, 'admin', 57),(58, 'admin', 58),(59, 'admin', 59),(60, 'admin', 60),(61, 'admin', 61),(62, 'admin', 62),(63, 'admin', 63),(64, 'admin', 64),(65, 'admin', 65),(66, 'admin', 66),(67, 'admin', 67),(68, 'admin', 68),(69, 'admin', 69),(70, 'admin', 70),(71, 'admin', 71),(72, 'admin', 72),(73, 'admin', 73),(74, 'admin', 74),(75, 'admin', 75),(76, 'admin', 76),(77, 'admin', 77),(78, 'admin', 78),(79, 'admin', 79),(80, 'admin', 80),(81, 'admin', 81),(82, 'admin', 82),(83, 'admin', 83),(84, 'admin', 84),(85, 'admin', 85),(86, 'admin', 86),(87, 'admin', 87),(88, 'admin', 88),(89, 'admin', 89),(90, 'admin', 90),(91, 'admin', 91),(92, 'admin', 92),(93, 'admin', 93),(94, 'admin', 94),(95, 'admin', 95),(96, 'admin', 96),(97, 'admin', 97),(98, 'admin', 98),(99, 'admin', 99),(100, 'admin', 100),(101, 'admin', 101),(102, 'admin', 102),(103, 'admin', 103),(104, 'admin', 104),(105, 'admin', 105),(106, 'admin', 106),(107, 'admin', 107),(108, 'admin', 108),(109, 'admin', 109),(110, 'admin', 110),(111, 'admin', 111),(112, 'admin', 112),(113, 'admin', 113),(114, 'admin', 114),(115, 'admin', 115),(116, 'admin', 116),(117, 'admin', 117),(118, 'admin', 118),(119, 'admin', 119),(120, 'admin', 120),(121, 'admin', 121),(122, 'admin', 122),(123, 'admin', 123),(124, 'admin', 124),(125, 'admin', 125),(126, 'admin', 126),(127, 'admin', 127),(128, 'admin', 128),(129, 'admin', 129),(130, 'admin', 130),(131, 'admin', 131),(132, 'admin', 132),(133, 'admin', 133),(134, 'admin', 134),(135, 'admin', 135),(136, 'admin', 136),(137, 'admin', 137),(138, 'admin', 138),(139, 'admin', 139),(140, 'admin', 140),(141, 'admin', 141),(142, 'admin', 142),(143, 'admin', 143),(144, 'admin', 144),(145, 'admin', 145),(146, 'admin', 146),(147, 'admin', 147),(148, 'admin', 148),(149, 'admin', 149);
/*!40000 ALTER TABLE `flowkit_ui_backend`.`scope_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `single_location_data`
--

LOCK TABLES `single_location_data` WRITE;
/*!40000 ALTER TABLE `single_location_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `single_location_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.abnormality_101`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.abnormality_101` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.abnormality_101`
--

LOCK TABLES `single_location_data_presence.abnormality_101` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.abnormality_101` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.abnormality_101` VALUES (1,101,'HT0111-01',0.110000000);
/*!40000 ALTER TABLE `single_location_data_presence.abnormality_101` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.abnormality_102`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.abnormality_102` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.abnormality_102`
--

LOCK TABLES `single_location_data_presence.abnormality_102` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.abnormality_102` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.abnormality_102` VALUES (1,102,'HT0111-01',-0.870000000);
/*!40000 ALTER TABLE `single_location_data_presence.abnormality_102` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.abnormality_103`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.abnormality_103` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.abnormality_103`
--

LOCK TABLES `single_location_data_presence.abnormality_103` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.abnormality_103` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.abnormality_103` VALUES (1,103,'HT0111-01',0.590000000);
/*!40000 ALTER TABLE `single_location_data_presence.abnormality_103` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.abnormality_104`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.abnormality_104` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.abnormality_104`
--

LOCK TABLES `single_location_data_presence.abnormality_104` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.abnormality_104` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.abnormality_104` VALUES (1,104,'HT0111-01',-1.290000000);
/*!40000 ALTER TABLE `single_location_data_presence.abnormality_104` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.abnormality_105`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.abnormality_105` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.abnormality_105`
--

LOCK TABLES `single_location_data_presence.abnormality_105` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.abnormality_105` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.abnormality_105` VALUES (1,105,'HT0111-01',-0.640000000);
/*!40000 ALTER TABLE `single_location_data_presence.abnormality_105` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.abnormality_106`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.abnormality_106` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.abnormality_106`
--

LOCK TABLES `single_location_data_presence.abnormality_106` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.abnormality_106` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.abnormality_106` VALUES (1,106,'HT0111-01',0.280000000);
/*!40000 ALTER TABLE `single_location_data_presence.abnormality_106` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.abnormality_107`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.abnormality_107` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.abnormality_107`
--

LOCK TABLES `single_location_data_presence.abnormality_107` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.abnormality_107` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.abnormality_107` VALUES (1,107,'HT0111-01',-0.590000000);
/*!40000 ALTER TABLE `single_location_data_presence.abnormality_107` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_73`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_73` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_73`
--

LOCK TABLES `single_location_data_presence.presence_73` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_73` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_73` VALUES (1,73,'HT0111-01',449010.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_73` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_74`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_74` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_74`
--

LOCK TABLES `single_location_data_presence.presence_74` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_74` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_74` VALUES (1,74,'HT0111-01',480630.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_74` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_75`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_75` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_75`
--

LOCK TABLES `single_location_data_presence.presence_75` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_75` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_75` VALUES (1,75,'HT0111-01',474690.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_75` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_76`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_76` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_76`
--

LOCK TABLES `single_location_data_presence.presence_76` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_76` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_76` VALUES (1,76,'HT0111-01',576950.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_76` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_77`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_77` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_77`
--

LOCK TABLES `single_location_data_presence.presence_77` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_77` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_77` VALUES (1,77,'HT0111-01',403550.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_77` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_78`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_78` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_78`
--

LOCK TABLES `single_location_data_presence.presence_78` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_78` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_78` VALUES (1,78,'HT0111-01',611190.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_78` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_79`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_79` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_79`
--

LOCK TABLES `single_location_data_presence.presence_79` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_79` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_79` VALUES (1,79,'HT0111-01',557520.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_79` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_diffwithref_108`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_diffwithref_108` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_diffwithref_108`
--

LOCK TABLES `single_location_data_presence.presence_diffwithref_108` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_diffwithref_108` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_diffwithref_108` VALUES (1,108,'HT0111-01',-64900.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_diffwithref_108` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_diffwithref_109`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_diffwithref_109` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_diffwithref_109`
--

LOCK TABLES `single_location_data_presence.presence_diffwithref_109` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_diffwithref_109` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_diffwithref_109` VALUES (1,109,'HT0111-01',-141980.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_diffwithref_109` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_diffwithref_110`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_diffwithref_110` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_diffwithref_110`
--

LOCK TABLES `single_location_data_presence.presence_diffwithref_110` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_diffwithref_110` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_diffwithref_110` VALUES (1,110,'HT0111-01',11990.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_diffwithref_110` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_diffwithref_111`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_diffwithref_111` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_diffwithref_111`
--

LOCK TABLES `single_location_data_presence.presence_diffwithref_111` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_diffwithref_111` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_diffwithref_111` VALUES (1,111,'HT0111-01',-96520.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_diffwithref_111` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_diffwithref_112`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_diffwithref_112` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_diffwithref_112`
--

LOCK TABLES `single_location_data_presence.presence_diffwithref_112` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_diffwithref_112` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_diffwithref_112` VALUES (1,112,'HT0111-01',31410.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_diffwithref_112` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_diffwithref_113`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_diffwithref_113` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_diffwithref_113`
--

LOCK TABLES `single_location_data_presence.presence_diffwithref_113` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_diffwithref_113` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_diffwithref_113` VALUES (1,113,'HT0111-01',65650.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_diffwithref_113` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_diffwithref_114`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_diffwithref_114` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_diffwithref_114`
--

LOCK TABLES `single_location_data_presence.presence_diffwithref_114` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_diffwithref_114` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_diffwithref_114` VALUES (1,114,'HT0111-01',-70840.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_diffwithref_114` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_pctchangewithref_115`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_pctchangewithref_115` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_pctchangewithref_115`
--

LOCK TABLES `single_location_data_presence.presence_pctchangewithref_115` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_pctchangewithref_115` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_pctchangewithref_115` VALUES (1,115,'HT0111-01',12.030000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_pctchangewithref_115` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_pctchangewithref_116`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_pctchangewithref_116` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_pctchangewithref_116`
--

LOCK TABLES `single_location_data_presence.presence_pctchangewithref_116` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_pctchangewithref_116` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_pctchangewithref_116` VALUES (1,116,'HT0111-01',2.190000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_pctchangewithref_116` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_pctchangewithref_117`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_pctchangewithref_117` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_pctchangewithref_117`
--

LOCK TABLES `single_location_data_presence.presence_pctchangewithref_117` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_pctchangewithref_117` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_pctchangewithref_117` VALUES (1,117,'HT0111-01',5.760000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_pctchangewithref_117` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_pctchangewithref_118`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_pctchangewithref_118` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_pctchangewithref_118`
--

LOCK TABLES `single_location_data_presence.presence_pctchangewithref_118` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_pctchangewithref_118` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_pctchangewithref_118` VALUES (1,118,'HT0111-01',-17.700000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_pctchangewithref_118` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_pctchangewithref_119`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_pctchangewithref_119` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_pctchangewithref_119`
--

LOCK TABLES `single_location_data_presence.presence_pctchangewithref_119` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_pctchangewithref_119` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_pctchangewithref_119` VALUES (1,119,'HT0111-01',-12.980000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_pctchangewithref_119` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_pctchangewithref_120`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_pctchangewithref_120` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_pctchangewithref_120`
--

LOCK TABLES `single_location_data_presence.presence_pctchangewithref_120` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_pctchangewithref_120` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_pctchangewithref_120` VALUES (1,120,'HT0111-01',-26.030000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_pctchangewithref_120` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_pctchangewithref_121`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_pctchangewithref_121` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_pctchangewithref_121`
--

LOCK TABLES `single_location_data_presence.presence_pctchangewithref_121` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_pctchangewithref_121` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_pctchangewithref_121` VALUES (1,121,'HT0111-01',-11.900000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_pctchangewithref_121` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_perKm2_80`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_perKm2_80` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_perKm2_80`
--

LOCK TABLES `single_location_data_presence.presence_perKm2_80` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_perKm2_80` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_perKm2_80` VALUES (1,80,'HT0111-01',30350.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_perKm2_80` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_perKm2_81`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_perKm2_81` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_perKm2_81`
--

LOCK TABLES `single_location_data_presence.presence_perKm2_81` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_perKm2_81` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_perKm2_81` VALUES (1,81,'HT0111-01',33280.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_perKm2_81` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_perKm2_82`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_perKm2_82` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_perKm2_82`
--

LOCK TABLES `single_location_data_presence.presence_perKm2_82` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_perKm2_82` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_perKm2_82` VALUES (1,82,'HT0111-01',31410.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_perKm2_82` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_perKm2_83`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_perKm2_83` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_perKm2_83`
--

LOCK TABLES `single_location_data_presence.presence_perKm2_83` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_perKm2_83` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_perKm2_83` VALUES (1,83,'HT0111-01',24450.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_perKm2_83` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_perKm2_84`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_perKm2_84` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_perKm2_84`
--

LOCK TABLES `single_location_data_presence.presence_perKm2_84` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_perKm2_84` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_perKm2_84` VALUES (1,84,'HT0111-01',25840.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_perKm2_84` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_perKm2_85`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_perKm2_85` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_perKm2_85`
--

LOCK TABLES `single_location_data_presence.presence_perKm2_85` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_perKm2_85` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_perKm2_85` VALUES (1,85,'HT0111-01',26170.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_perKm2_85` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.presence_perKm2_86`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.presence_perKm2_86` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.presence_perKm2_86`
--

LOCK TABLES `single_location_data_presence.presence_perKm2_86` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.presence_perKm2_86` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.presence_perKm2_86` VALUES (1,86,'HT0111-01',21970.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.presence_perKm2_86` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.trips_in_87`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.trips_in_87` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.trips_in_87`
--

LOCK TABLES `single_location_data_presence.trips_in_87` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.trips_in_87` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.trips_in_87` VALUES (1,87,'HT0111-01',156180.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.trips_in_87` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.trips_in_88`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.trips_in_88` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.trips_in_88`
--

LOCK TABLES `single_location_data_presence.trips_in_88` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.trips_in_88` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.trips_in_88` VALUES (1,88,'HT0111-01',156790.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.trips_in_88` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.trips_in_89`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.trips_in_89` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.trips_in_89`
--

LOCK TABLES `single_location_data_presence.trips_in_89` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.trips_in_89` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.trips_in_89` VALUES (1,89,'HT0111-01',156240.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.trips_in_89` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.trips_in_90`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.trips_in_90` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.trips_in_90`
--

LOCK TABLES `single_location_data_presence.trips_in_90` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.trips_in_90` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.trips_in_90` VALUES (1,90,'HT0111-01',156160.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.trips_in_90` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.trips_in_91`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.trips_in_91` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.trips_in_91`
--

LOCK TABLES `single_location_data_presence.trips_in_91` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.trips_in_91` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.trips_in_91` VALUES (1,91,'HT0111-01',156200.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.trips_in_91` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.trips_in_92`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.trips_in_92` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.trips_in_92`
--

LOCK TABLES `single_location_data_presence.trips_in_92` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.trips_in_92` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.trips_in_92` VALUES (1,92,'HT0111-01',156300.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.trips_in_92` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.trips_in_93`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.trips_in_93` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.trips_in_93`
--

LOCK TABLES `single_location_data_presence.trips_in_93` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.trips_in_93` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.trips_in_93` VALUES (1,93,'HT0111-01',156360.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.trips_in_93` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.trips_out_100`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.trips_out_100` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.trips_out_100`
--

LOCK TABLES `single_location_data_presence.trips_out_100` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.trips_out_100` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.trips_out_100` VALUES (1,100,'HT0111-01',155250.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.trips_out_100` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.trips_out_94`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.trips_out_94` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.trips_out_94`
--

LOCK TABLES `single_location_data_presence.trips_out_94` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.trips_out_94` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.trips_out_94` VALUES (1,94,'HT0111-01',154970.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.trips_out_94` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.trips_out_95`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.trips_out_95` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.trips_out_95`
--

LOCK TABLES `single_location_data_presence.trips_out_95` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.trips_out_95` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.trips_out_95` VALUES (1,95,'HT0111-01',155860.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.trips_out_95` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.trips_out_96`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.trips_out_96` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.trips_out_96`
--

LOCK TABLES `single_location_data_presence.trips_out_96` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.trips_out_96` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.trips_out_96` VALUES (1,96,'HT0111-01',156200.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.trips_out_96` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.trips_out_97`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.trips_out_97` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.trips_out_97`
--

LOCK TABLES `single_location_data_presence.trips_out_97` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.trips_out_97` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.trips_out_97` VALUES (1,97,'HT0111-01',157430.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.trips_out_97` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.trips_out_98`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.trips_out_98` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.trips_out_98`
--

LOCK TABLES `single_location_data_presence.trips_out_98` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.trips_out_98` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.trips_out_98` VALUES (1,98,'HT0111-01',158550.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.trips_out_98` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_presence.trips_out_99`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_presence.trips_out_99` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_presence.trips_out_99`
--

LOCK TABLES `single_location_data_presence.trips_out_99` WRITE;
/*!40000 ALTER TABLE `single_location_data_presence.trips_out_99` DISABLE KEYS */;
INSERT INTO `single_location_data_presence.trips_out_99` VALUES (1,99,'HT0111-01',157690.000000000);
/*!40000 ALTER TABLE `single_location_data_presence.trips_out_99` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.abnormality_37`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.abnormality_37` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=425 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.abnormality_37`
--

LOCK TABLES `single_location_data_residents.abnormality_37` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.abnormality_37` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.abnormality_37` VALUES (1,37,'HT0111-01',-0.680000000);
/*!40000 ALTER TABLE `single_location_data_residents.abnormality_37` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.abnormality_38`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.abnormality_38` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=424 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.abnormality_38`
--

LOCK TABLES `single_location_data_residents.abnormality_38` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.abnormality_38` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.abnormality_38` VALUES (1,38,'HT0111-01',-1.740000000);
/*!40000 ALTER TABLE `single_location_data_residents.abnormality_38` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.abnormality_39`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.abnormality_39` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=425 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.abnormality_39`
--

LOCK TABLES `single_location_data_residents.abnormality_39` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.abnormality_39` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.abnormality_39` VALUES (1,39,'HT0111-01',-1.400000000);
/*!40000 ALTER TABLE `single_location_data_residents.abnormality_39` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.abnormality_40`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.abnormality_40` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=425 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.abnormality_40`
--

LOCK TABLES `single_location_data_residents.abnormality_40` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.abnormality_40` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.abnormality_40` VALUES (1,40,'HT0111-01',1.690000000);
/*!40000 ALTER TABLE `single_location_data_residents.abnormality_40` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.abnormality_41`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.abnormality_41` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=425 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.abnormality_41`
--

LOCK TABLES `single_location_data_residents.abnormality_41` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.abnormality_41` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.abnormality_41` VALUES (1,41,'HT0111-01',0.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.abnormality_41` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.abnormality_42`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.abnormality_42` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=425 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.abnormality_42`
--

LOCK TABLES `single_location_data_residents.abnormality_42` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.abnormality_42` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.abnormality_42` VALUES (1,42,'HT0111-01',1.350000000);
/*!40000 ALTER TABLE `single_location_data_residents.abnormality_42` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.arrived_13`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.arrived_13` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=524 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.arrived_13`
--

LOCK TABLES `single_location_data_residents.arrived_13` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.arrived_13` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.arrived_13` VALUES (1,13,'HT0111-01',257970.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.arrived_13` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.arrived_14`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.arrived_14` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=527 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.arrived_14`
--

LOCK TABLES `single_location_data_residents.arrived_14` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.arrived_14` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.arrived_14` VALUES (1,14,'HT0111-01',312430.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.arrived_14` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.arrived_15`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.arrived_15` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=522 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.arrived_15`
--

LOCK TABLES `single_location_data_residents.arrived_15` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.arrived_15` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.arrived_15` VALUES (1,15,'HT0111-01',436830.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.arrived_15` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.arrived_16`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.arrived_16` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=520 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.arrived_16`
--

LOCK TABLES `single_location_data_residents.arrived_16` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.arrived_16` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.arrived_16` VALUES (1,16,'HT0111-01',243470.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.arrived_16` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.arrived_17`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.arrived_17` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=521 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.arrived_17`
--

LOCK TABLES `single_location_data_residents.arrived_17` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.arrived_17` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.arrived_17` VALUES (1,17,'HT0111-01',267070.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.arrived_17` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.arrived_18`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.arrived_18` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=520 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.arrived_18`
--

LOCK TABLES `single_location_data_residents.arrived_18` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.arrived_18` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.arrived_18` VALUES (1,18,'HT0111-01',446860.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.arrived_18` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.delta_arrived_25`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.delta_arrived_25` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=522 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.delta_arrived_25`
--

LOCK TABLES `single_location_data_residents.delta_arrived_25` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.delta_arrived_25` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.delta_arrived_25` VALUES (1,25,'HT0111-01',10330.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.delta_arrived_25` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.delta_arrived_26`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.delta_arrived_26` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=521 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.delta_arrived_26`
--

LOCK TABLES `single_location_data_residents.delta_arrived_26` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.delta_arrived_26` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.delta_arrived_26` VALUES (1,26,'HT0111-01',6560.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.delta_arrived_26` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.delta_arrived_27`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.delta_arrived_27` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=520 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.delta_arrived_27`
--

LOCK TABLES `single_location_data_residents.delta_arrived_27` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.delta_arrived_27` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.delta_arrived_27` VALUES (1,27,'HT0111-01',-4000.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.delta_arrived_27` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.delta_arrived_28`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.delta_arrived_28` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=520 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.delta_arrived_28`
--

LOCK TABLES `single_location_data_residents.delta_arrived_28` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.delta_arrived_28` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.delta_arrived_28` VALUES (1,28,'HT0111-01',19760.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.delta_arrived_28` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.delta_arrived_29`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.delta_arrived_29` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=527 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.delta_arrived_29`
--

LOCK TABLES `single_location_data_residents.delta_arrived_29` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.delta_arrived_29` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.delta_arrived_29` VALUES (1,29,'HT0111-01',-5260.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.delta_arrived_29` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.delta_arrived_30`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.delta_arrived_30` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=524 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.delta_arrived_30`
--

LOCK TABLES `single_location_data_residents.delta_arrived_30` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.delta_arrived_30` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.delta_arrived_30` VALUES (1,30,'HT0111-01',1270.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.delta_arrived_30` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.departed_19`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.departed_19` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=522 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.departed_19`
--

LOCK TABLES `single_location_data_residents.departed_19` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.departed_19` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.departed_19` VALUES (1,19,'HT0111-01',426500.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.departed_19` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.departed_20`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.departed_20` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=520 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.departed_20`
--

LOCK TABLES `single_location_data_residents.departed_20` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.departed_20` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.departed_20` VALUES (1,20,'HT0111-01',427110.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.departed_20` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.departed_21`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.departed_21` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=520 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.departed_21`
--

LOCK TABLES `single_location_data_residents.departed_21` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.departed_21` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.departed_21` VALUES (1,21,'HT0111-01',247470.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.departed_21` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.departed_22`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.departed_22` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=524 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.departed_22`
--

LOCK TABLES `single_location_data_residents.departed_22` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.departed_22` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.departed_22` VALUES (1,22,'HT0111-01',256700.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.departed_22` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.departed_23`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.departed_23` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=527 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.departed_23`
--

LOCK TABLES `single_location_data_residents.departed_23` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.departed_23` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.departed_23` VALUES (1,23,'HT0111-01',317680.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.departed_23` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.departed_24`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.departed_24` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=521 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.departed_24`
--

LOCK TABLES `single_location_data_residents.departed_24` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.departed_24` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.departed_24` VALUES (1,24,'HT0111-01',260510.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.departed_24` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_1`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_1` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=520 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_1`
--

LOCK TABLES `single_location_data_residents.residents_1` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_1` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_1` VALUES (1,1,'HT0111-01',544650.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_2`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=520 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_2`
--

LOCK TABLES `single_location_data_residents.residents_2` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_2` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_2` VALUES (1,2,'HT0111-01',540640.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_3`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_3` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=521 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_3`
--

LOCK TABLES `single_location_data_residents.residents_3` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_3` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_3` VALUES (1,3,'HT0111-01',547210.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_4`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_4` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=524 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_4`
--

LOCK TABLES `single_location_data_residents.residents_4` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_4` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_4` VALUES (1,4,'HT0111-01',553560.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_4` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_5`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_5` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=522 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_5`
--

LOCK TABLES `single_location_data_residents.residents_5` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_5` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_5` VALUES (1,5,'HT0111-01',552290.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_6`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_6` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=527 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_6`
--

LOCK TABLES `single_location_data_residents.residents_6` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_6` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_6` VALUES (1,6,'HT0111-01',541950.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_6` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_diffwithref_31`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_diffwithref_31` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=498 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_diffwithref_31`
--

LOCK TABLES `single_location_data_residents.residents_diffwithref_31` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_diffwithref_31` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_diffwithref_31` VALUES (1,31,'HT0111-01',8030.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_diffwithref_31` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_diffwithref_32`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_diffwithref_32` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=497 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_diffwithref_32`
--

LOCK TABLES `single_location_data_residents.residents_diffwithref_32` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_diffwithref_32` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_diffwithref_32` VALUES (1,32,'HT0111-01',1680.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_diffwithref_32` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_diffwithref_33`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_diffwithref_33` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=497 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_diffwithref_33`
--

LOCK TABLES `single_location_data_residents.residents_diffwithref_33` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_diffwithref_33` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_diffwithref_33` VALUES (1,33,'HT0111-01',-880.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_diffwithref_33` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_diffwithref_34`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_diffwithref_34` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=496 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_diffwithref_34`
--

LOCK TABLES `single_location_data_residents.residents_diffwithref_34` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_diffwithref_34` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_diffwithref_34` VALUES (1,34,'HT0111-01',-4890.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_diffwithref_34` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_diffwithref_35`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_diffwithref_35` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=498 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_diffwithref_35`
--

LOCK TABLES `single_location_data_residents.residents_diffwithref_35` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_diffwithref_35` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_diffwithref_35` VALUES (1,35,'HT0111-01',-3580.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_diffwithref_35` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_diffwithref_36`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_diffwithref_36` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=497 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_diffwithref_36`
--

LOCK TABLES `single_location_data_residents.residents_diffwithref_36` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_diffwithref_36` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_diffwithref_36` VALUES (1,36,'HT0111-01',6760.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_diffwithref_36` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_pctchangewithref_43`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_pctchangewithref_43` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=497 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_pctchangewithref_43`
--

LOCK TABLES `single_location_data_residents.residents_pctchangewithref_43` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_pctchangewithref_43` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_pctchangewithref_43` VALUES (1,43,'HT0111-01',-0.160000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_pctchangewithref_43` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_pctchangewithref_44`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_pctchangewithref_44` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=497 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_pctchangewithref_44`
--

LOCK TABLES `single_location_data_residents.residents_pctchangewithref_44` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_pctchangewithref_44` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_pctchangewithref_44` VALUES (1,44,'HT0111-01',0.310000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_pctchangewithref_44` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_pctchangewithref_45`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_pctchangewithref_45` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=497 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_pctchangewithref_45`
--

LOCK TABLES `single_location_data_residents.residents_pctchangewithref_45` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_pctchangewithref_45` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_pctchangewithref_45` VALUES (1,45,'HT0111-01',1.240000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_pctchangewithref_45` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_pctchangewithref_46`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_pctchangewithref_46` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=496 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_pctchangewithref_46`
--

LOCK TABLES `single_location_data_residents.residents_pctchangewithref_46` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_pctchangewithref_46` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_pctchangewithref_46` VALUES (1,46,'HT0111-01',-0.900000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_pctchangewithref_46` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_pctchangewithref_47`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_pctchangewithref_47` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=498 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_pctchangewithref_47`
--

LOCK TABLES `single_location_data_residents.residents_pctchangewithref_47` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_pctchangewithref_47` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_pctchangewithref_47` VALUES (1,47,'HT0111-01',-0.660000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_pctchangewithref_47` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_pctchangewithref_48`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_pctchangewithref_48` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=498 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_pctchangewithref_48`
--

LOCK TABLES `single_location_data_residents.residents_pctchangewithref_48` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_pctchangewithref_48` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_pctchangewithref_48` VALUES (1,48,'HT0111-01',1.470000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_pctchangewithref_48` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_perKm2_10`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_perKm2_10` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=520 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_perKm2_10`
--

LOCK TABLES `single_location_data_residents.residents_perKm2_10` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_perKm2_10` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_perKm2_10` VALUES (1,10,'HT0111-01',29650.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_perKm2_10` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_perKm2_11`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_perKm2_11` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=527 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_perKm2_11`
--

LOCK TABLES `single_location_data_residents.residents_perKm2_11` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_perKm2_11` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_perKm2_11` VALUES (1,11,'HT0111-01',29510.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_perKm2_11` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_perKm2_12`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_perKm2_12` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=524 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_perKm2_12`
--

LOCK TABLES `single_location_data_residents.residents_perKm2_12` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_perKm2_12` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_perKm2_12` VALUES (1,12,'HT0111-01',30140.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_perKm2_12` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_perKm2_7`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_perKm2_7` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=520 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_perKm2_7`
--

LOCK TABLES `single_location_data_residents.residents_perKm2_7` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_perKm2_7` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_perKm2_7` VALUES (1,7,'HT0111-01',29430.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_perKm2_7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_perKm2_8`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_perKm2_8` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=521 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_perKm2_8`
--

LOCK TABLES `single_location_data_residents.residents_perKm2_8` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_perKm2_8` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_perKm2_8` VALUES (1,8,'HT0111-01',29790.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_perKm2_8` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_location_data_residents.residents_perKm2_9`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `single_location_data_residents.residents_perKm2_9` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdid` int DEFAULT NULL COMMENT 'The ID of the metadata for this data',
  `spatial_unit_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The identifier for the single spatial unit that this data object relates to',
  `data` decimal(20,9) DEFAULT NULL COMMENT 'The data',
  PRIMARY KEY (`id`),
  KEY `index_single_location_data_mdid` (`mdid`)
) ENGINE=InnoDB AUTO_INCREMENT=522 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data referring to exactly one spatial unit for one metadata instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_location_data_residents.residents_perKm2_9`
--

LOCK TABLES `single_location_data_residents.residents_perKm2_9` WRITE;
/*!40000 ALTER TABLE `single_location_data_residents.residents_perKm2_9` DISABLE KEYS */;
INSERT INTO `single_location_data_residents.residents_perKm2_9` VALUES (1,9,'HT0111-01',30070.000000000);
/*!40000 ALTER TABLE `single_location_data_residents.residents_perKm2_9` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `spatial_resolution`
--

LOCK TABLES `spatial_resolution` WRITE;
/*!40000 ALTER TABLE `spatial_resolution` DISABLE KEYS */;
INSERT INTO `spatial_resolution` VALUES (1,1,'Department',1,'In the administrative divisions of Haiti, the department is the first of four levels of government.','{\"arcs\": [[[0.0, 0.0], [1.0, 0.0], [1.0, 1.0], [0.0, 1.0], [0.0, 0.0]],[[1.0, 0.0], [2.0, 0.0], [2.0, 1.0], [1.0, 1.0], [1.0, 0.0]]], \"coordinates\": [],\"objects\": {\"admin2\": {\"geometries\": [{\"arcs\": [[0], [1]],\"type\": \"MultiLineString\",\"properties\": {\"ADM0_EN\": \"Haiti\", \"ADM0_FR\": \"Haïti\", \"ADM0_HT\": \"Ayiti\", \"ADM1_EN\": \"Grande\'Anse\", \"ADM1_FR\": \"Grande\'Anse\", \"ADM1_HT\": \"Grandans\", \"ADM2_EN\": \"Bonbon\", \"ADM2_FR\": \"Bonbon\", \"ADM2_HT\": null, \"centroid\": {\"type\": \"Point\", \"coordinates\": [0.5,0.5]}, \"ADM0_PCODE\": \"HT\", \"ADM1_PCODE\": \"HT08\", \"ADM2_PCODE\": \"HT0813\"}}],\"type\": \"GeometryCollection\"}},\"type\": \"Topology\"}', '{\"fr\": {\"label\": \"Commune\", \"description\": \"La commune est une division administrative de deuxi\\u00e8me niveau en Ha\\u00efti.\"}}');
INSERT INTO `spatial_resolution` VALUES (3,3,'Communal section',3,'A communal section is a third-level administrative division in Haiti.','{\"arcs\": [[[0.0, 0.0], [1.0, 0.0], [1.0, 1.0], [0.0, 1.0], [0.0, 0.0]],[[1.0, 0.0], [2.0, 0.0], [2.0, 1.0], [1.0, 1.0], [1.0, 0.0]]],\"coordinates\": [],\"objects\": {\"admin2\": {\"geometries\": [{\"arcs\": [[0], [1]],\"type\": \"MultiLineString\",\"properties\": {\"ADM0_EN\": \"Haiti\", \"ADM0_FR\": \"Haïti\", \"ADM0_HT\": \"Ayiti\", \"ADM1_EN\": \"West\", \"ADM1_FR\": \"Ouest\", \"ADM1_HT\": \"Lwès\", \"ADM2_EN\": \"Croix-Des-Bouquets\", \"ADM2_FR\": \"Croix-Des-Bouquets\", \"ADM2_HT\": null, \"ADM3_EN\": \"10e Section des Orangers\", \"ADM3_FR\": \"10e Section des Orangers\", \"ADM3_HT\": null, \"centroid\": {\"type\": \"Point\", \"coordinates\": [-72.303305535, 18.74617793]}, \"ADM0_PCODE\": \"HT\", \"ADM1_PCODE\": \"HT01\", \"ADM2_PCODE\": \"HT0131\", \"ADM3_PCODE\": \"HT0131-10\"}}],\"type\": \"GeometryCollection\"}},\"type\": \"Topology\"}','{\"fr\": {\"label\": \"Section communale\", \"description\": \"La section communale est une division administrative de troisi\\u00e8me niveau en Ha\\u00efti.\"}}');
/*!40000 ALTER TABLE `spatial_resolution` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `temporal_resolution`
--

LOCK TABLES `temporal_resolution` WRITE;
/*!40000 ALTER TABLE `temporal_resolution` DISABLE KEYS */;
INSERT INTO `temporal_resolution` VALUES (1,1,'Year',0,'years',1,'%Y',10,'A full year','{\"fr\": {\"label\": \"Ann\\u00e9e\", \"description\": \"Ann\\u00e9e compl\\u00e8te\"}}'),(2,2,'Month',1,'months',1,'%Y-%m',12,'A calendar month','{\"fr\": {\"label\": \"Mois\", \"description\": \"Mois civil\"}}'),(3,3,'Week',2,'weeks',1,'%Gw%V',12,'A calendar week, i.e. 7 days from Monday 00:00:00 until Sunday 23:59:59','{\"fr\": {\"label\": \"Semaine\", \"description\": \"Semaine calendaire, soit 7 jours du lundi 00:00:00 au dimanche 23:59:59\"}}'),(4,4,'Day',3,'days',1,'%Y-%m-%d',7,'A day starting at 00:00:00 and ending at 23:59:59 on the same date','{\"fr\": {\"label\": \"Journ\\u00e9e\", \"description\": \"Une journ\\u00e9e commen\\u00e7ant \\u00e0 00:00:00 et se terminant \\u00e0 23:59:59 \\u00e0 la m\\u00eame date\"}}');
/*!40000 ALTER TABLE `temporal_resolution` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-19 10:32:44
