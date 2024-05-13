-- MariaDB dump 10.19-11.4.0-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: coffee_reach
-- ------------------------------------------------------
-- Server version	11.4.0-MariaDB-log

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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `ClienteID` uuid NOT NULL,
  `Nombre_Cliente` varchar(30) DEFAULT NULL,
  `Apellido_Cliente` varchar(30) DEFAULT NULL,
  `Telefono_Cliente` int(13) DEFAULT NULL,
  `Correo_Cliente` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ClienteID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleados` (
  `LoginID` uuid NOT NULL,
  `Nombre` varchar(30) DEFAULT NULL,
  `Apellido` varchar(30) DEFAULT NULL,
  `Fecha_nacimiento` date DEFAULT NULL,
  `Telefono` int(13) DEFAULT NULL,
  `Nombre_de_Usuario` varchar(30) DEFAULT NULL,
  `Contraseña` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`LoginID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido` (
  `PedidoID` uuid NOT NULL,
  `Estatus` varchar(30) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `Direccion` varchar(30) DEFAULT NULL,
  `Total_Pago` double DEFAULT NULL,
  `ClienteID` uuid DEFAULT NULL,
  `ProductoID` uuid DEFAULT NULL,
  PRIMARY KEY (`PedidoID`),
  KEY `fk_ClienteID_pedido` (`ClienteID`),
  CONSTRAINT `fk_ClienteID_pedido` FOREIGN KEY (`ClienteID`) REFERENCES `cliente` (`ClienteID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productos` (
  `ProductoID` uuid NOT NULL,
  `Nombre_Producto` varchar(30) DEFAULT NULL,
  `Tipo_Producto` varchar(30) DEFAULT NULL,
  `Precio` double DEFAULT NULL,
  `Descripcion` varchar(30) DEFAULT NULL,
  `Existencia` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`ProductoID`),
  CONSTRAINT `fk_ProductoID_pedido` FOREIGN KEY (`ProductoID`) REFERENCES `productos` (`ProductoID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repartidor`
--

DROP TABLE IF EXISTS `repartidor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repartidor` (
  `RepartidorID` uuid NOT NULL,
  `pedidoID` uuid DEFAULT NULL,
  `LoginID` uuid DEFAULT NULL,
  PRIMARY KEY (`RepartidorID`),
  KEY `fk_PedidoID` (`pedidoID`),
  KEY `fk_LoginID` (`LoginID`),
  CONSTRAINT `fk_LoginID` FOREIGN KEY (`LoginID`) REFERENCES `empleados` (`LoginID`),
  CONSTRAINT `fk_PedidoID` FOREIGN KEY (`pedidoID`) REFERENCES `pedido` (`PedidoID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repartidor`
--

LOCK TABLES `repartidor` WRITE;
/*!40000 ALTER TABLE `repartidor` DISABLE KEYS */;
/*!40000 ALTER TABLE `repartidor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket` (
  `TicketID` uuid NOT NULL,
  `Fecha_Ticket` date DEFAULT NULL,
  `PedidoID` uuid DEFAULT NULL,
  `Metodo_Pago` varchar(30) DEFAULT NULL,
  `Total_Pago` double DEFAULT NULL,
  PRIMARY KEY (`TicketID`),
  KEY `fk_PedidoID_ticket` (`PedidoID`),
  CONSTRAINT `fk_PedidoID_ticket` FOREIGN KEY (`PedidoID`) REFERENCES `pedido` (`PedidoID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventas` (
  `VentasID` uuid NOT NULL,
  `Total_venta` double DEFAULT NULL,
  `Propina` double DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `LoginID` uuid DEFAULT NULL,
  PRIMARY KEY (`VentasID`),
  KEY `fk_LoginID_ventas` (`LoginID`),
  CONSTRAINT `fk_LoginID_ventas` FOREIGN KEY (`LoginID`) REFERENCES `empleados` (`LoginID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-13 11:00:37
