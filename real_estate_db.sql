-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: real_estate_db
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `favorite_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `property_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`favorite_id`),
  UNIQUE KEY `unique_favorite` (`user_id`,`property_id`),
  KEY `property_id` (`property_id`),
  CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` VALUES (1,2,4,'2025-12-10 07:42:04'),(2,2,5,'2025-12-10 07:42:04'),(3,3,1,'2025-12-10 07:42:04'),(4,3,2,'2025-12-10 07:42:04'),(5,4,4,'2025-12-10 07:42:04'),(6,4,11,'2025-12-10 07:42:04');
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `properties`
--

DROP TABLE IF EXISTS `properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `properties` (
  `property_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `property_type` enum('HOUSE','APARTMENT','LAND','COMMERCIAL') COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_type` enum('SALE','RENT') COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(15,2) NOT NULL,
  `area` decimal(10,2) NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `district` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ward` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bedrooms` int DEFAULT NULL,
  `bathrooms` int DEFAULT NULL,
  `status` enum('PENDING','APPROVED','REJECTED','SOLD') COLLATE utf8mb4_unicode_ci DEFAULT 'PENDING',
  `view_count` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`property_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `properties_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `properties`
--

LOCK TABLES `properties` WRITE;
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` VALUES (1,2,'Bán nhà mặt phố Trần Duy Hưng, 5 tầng, kinh doanh đỉnh','Nhà mặt phố vị trí đắc địa, 5 tầng 1 tum, mặt tiền 4.5m, kinh doanh sầm uất. Kết cấu: Tầng 1 kinh doanh, các tầng trên ở. Nhà mới xây, full nội thất cao cấp. Gần trường học, bệnh viện, siêu thị. Giá có thể thương lượng cho khách thiện chí.','HOUSE','SALE',15000000000.00,80.00,'Số 123 Trần Duy Hưng','Hà Nội','Cầu Giấy','Dịch Vọng',4,5,'APPROVED',156,'2025-12-10 07:42:04','2025-12-10 07:42:04'),(2,2,'Bán biệt thự Vinhomes Riverside, 250m2, view sông tuyệt đẹp','Biệt thự đơn lập, vị trí góc view sông Hồng tuyệt đẹp. Thiết kế hiện đại, sân vườn rộng rãi. Full nội thất cao cấp nhập khẩu. An ninh 24/7, tiện ích đầy đủ trong khu. Giá bao gồm toàn bộ nội thất.','HOUSE','SALE',45000000000.00,250.00,'Vinhomes Riverside','Hà Nội','Long Biên','Việt Hưng',5,6,'APPROVED',203,'2025-12-10 07:42:04','2025-12-10 07:42:04'),(3,3,'Bán nhà phố Láng Hạ, 4 tầng, ô tô vào nhà','Nhà phố 4 tầng, mặt tiền 5m, sâu 12m. Ô tô vào tận nhà. Kết cấu chắc chắn, thiết kế thông minh. Gần Royal City, Vincom. Phù hợp ở hoặc kinh doanh văn phòng.','HOUSE','SALE',12000000000.00,60.00,'45 Láng Hạ','Hà Nội','Đống Đa','Láng Hạ',4,3,'APPROVED',89,'2025-12-10 07:42:04','2025-12-10 07:42:04'),(4,3,'Bán căn hộ 3PN Times City, 110m2, view công viên','Căn hộ 3 phòng ngủ, tầng cao, view công viên Nhật Bản đẹp. Full nội thất gỗ cao cấp. Hướng Đông Nam, thoáng mát. Gần trường học quốc tế, bệnh viện, siêu thị. Giá tốt cho khách thiện chí.','APARTMENT','SALE',4500000000.00,110.00,'Times City','Hà Nội','Hai Bà Trưng','Vĩnh Tuy',3,2,'APPROVED',178,'2025-12-10 07:42:04','2025-12-10 07:42:04'),(5,4,'Cần bán gấp căn 2PN Vinhomes Smart City, 68m2','Căn hộ 2PN, tầng trung, hướng Đông Nam. Nội thất cơ bản. Chủ đầu tư uy tín, tiện ích đầy đủ. Giá rẻ hơn thị trường 200 triệu. Cần bán gấp trong tháng này.','APARTMENT','SALE',2300000000.00,68.00,'Vinhomes Smart City','Hà Nội','Nam Từ Liêm','Đại Mỗ',2,1,'APPROVED',234,'2025-12-10 07:42:04','2025-12-10 07:42:04'),(6,4,'Bán căn Penthouse Royal City, 200m2, 2 tầng','Penthouse 2 tầng, diện tích 200m2, tầng cao nhất. View toàn cảnh thành phố. Thiết kế sang trọng, nội thất cao cấp. Có hồ bơi riêng trên sân thượng. Giá bao gồm toàn bộ nội thất và 3 chỗ đỗ xe.','APARTMENT','SALE',18000000000.00,200.00,'Royal City','Hà Nội','Thanh Xuân','Thanh Xuân Trung',4,4,'PENDING',45,'2025-12-10 07:42:04','2025-12-10 07:42:04'),(7,2,'Bán đất mặt đường Quốc lộ 21B, 300m2, thổ cư 100%','Đất mặt đường Quốc lộ 21B, mặt tiền 12m, sâu 25m. Thổ cư 100%, sổ đỏ chính chủ. Vị trí đắc địa, gần khu công nghiệp, dân cư đông. Phù hợp kinh doanh hoặc xây nhà ở.','LAND','SALE',6000000000.00,300.00,'Quốc lộ 21B','Hà Nội','Ứng Hòa','Liên Bạt',0,0,'APPROVED',92,'2025-12-10 07:42:04','2025-12-10 07:42:04'),(8,5,'Đất nền khu đô thị Dương Nội, 80m2, giá đầu tư','Đất nền khu đô thị Dương Nội, đã có hạ tầng hoàn thiện. Sổ đỏ trao tay ngay. Vị trí đẹp, gần trường học, chợ. Giá đầu tư tốt, sinh lời cao.','LAND','SALE',3200000000.00,80.00,'Khu đô thị Dương Nội','Hà Nội','Hà Đông','Dương Nội',0,0,'APPROVED',67,'2025-12-10 07:42:04','2025-12-10 07:42:04'),(9,3,'Bán shophouse Vinhomes Metropolis, 120m2, 4 tầng','Shophouse vị trí đắc địa, mặt đường chính, 4 tầng. Đã có khách thuê kinh doanh ổn định. Lợi nhuận 8%/năm. Phù hợp đầu tư cho thuê hoặc tự kinh doanh.','COMMERCIAL','SALE',25000000000.00,120.00,'Vinhomes Metropolis','Hà Nội','Ba Đình','Liễu Giai',0,3,'APPROVED',112,'2025-12-10 07:42:04','2025-12-10 07:42:04'),(10,4,'Cho thuê nhà nguyên căn Hoàng Cầu, 4 tầng','Nhà nguyên căn 4 tầng, mặt tiền 4m, thang máy. Full nội thất cơ bản. Phù hợp làm văn phòng, spa, nhà hàng. Giá thuê 30 triệu/tháng, có thể thương lượng cho khách thuê dài hạn.','HOUSE','RENT',30000000.00,70.00,'78 Hoàng Cầu','Hà Nội','Đống Đa','Trung Liệt',4,3,'APPROVED',145,'2025-12-10 07:42:04','2025-12-10 07:42:04'),(11,5,'Cho thuê căn hộ 2PN Goldmark City, full nội thất','Căn hộ 2PN, 75m2, full nội thất đẹp. Tầng cao, view hồ. Tiện ích đầy đủ: hồ bơi, gym, siêu thị. Giá thuê 12 triệu/tháng, chưa bao gồm phí dịch vụ.','APARTMENT','RENT',12000000.00,75.00,'Goldmark City','Hà Nội','Bắc Từ Liêm','Phú Đô',2,2,'APPROVED',98,'2025-12-10 07:42:04','2025-12-10 07:42:04'),(12,2,'Cho thuê căn studio 35m2 The Sun Avenue, giá tốt','Căn studio 35m2, tầng 15, view sông. Full nội thất cao cấp, máy giặt, tủ lạnh, điều hòa. An ninh 24/7. Giá thuê 8 triệu/tháng.','APARTMENT','RENT',8000000.00,35.00,'The Sun Avenue','Hồ Chí Minh','Quận 2','An Phú',1,1,'APPROVED',76,'2025-12-10 07:42:04','2025-12-10 07:42:04'),(13,3,'Cho thuê mặt bằng kinh doanh mặt phố Tây Sơn','Mặt bằng tầng 1, diện tích 50m2, mặt tiền 5m. Vị trí đắc địa, dân cư đông. Phù hợp kinh doanh cafe, quần áo, mỹ phẩm. Giá thuê 25 triệu/tháng.','COMMERCIAL','RENT',25000000.00,50.00,'234 Tây Sơn','Hà Nội','Đống Đa','Quang Trung',0,1,'APPROVED',54,'2025-12-10 07:42:04','2025-12-10 07:42:04'),(14,4,'Bán nhà phố Thái Hà, 5 tầng, kinh doanh tốt','Nhà mặt phố Thái Hà, 5 tầng, mặt tiền 4m. Vị trí kinh doanh sầm uất. Giá 18 tỷ có thể thương lượng.','HOUSE','SALE',18000000000.00,65.00,'56 Thái Hà','Hà Nội','Đống Đa','Trung Liệt',4,4,'PENDING',5,'2025-12-10 07:42:04','2025-12-10 07:42:04'),(15,5,'Cho thuê căn hộ 3PN Vinhomes Green Bay','Căn hộ 3PN, 95m2, full nội thất. View hồ đẹp. Giá thuê 15 triệu/tháng.','APARTMENT','RENT',15000000.00,95.00,'Vinhomes Green Bay','Hà Nội','Nam Từ Liêm','Mễ Trì',3,2,'PENDING',2,'2025-12-10 07:42:04','2025-12-10 07:42:04'),(16,5,'Bán nhà giá rẻ quá đất quá người','Nhà đẹp, giá siêu rẻ, mua ngay kẻo hết!','HOUSE','SALE',500000000.00,100.00,'Đâu đó','Hà Nội','Đâu đó','Đâu đó',3,2,'REJECTED',1,'2025-12-10 07:42:04','2025-12-10 07:42:04'),(17,8,'Bán nhà 3 tầng phố Trần Duy Hưng','Nhà mặt tiền','HOUSE','SALE',4000000000.00,100.00,'Phố Trần Duy Hưng','Hà Nội','Cầu Giấy','Dịch Vọng',3,2,'PENDING',0,'2025-12-11 09:43:59','2025-12-11 09:43:59');
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_images`
--

DROP TABLE IF EXISTS `property_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property_images` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `property_id` int NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_main` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`image_id`),
  KEY `property_id` (`property_id`),
  CONSTRAINT `property_images_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_images`
--

LOCK TABLES `property_images` WRITE;
/*!40000 ALTER TABLE `property_images` DISABLE KEYS */;
INSERT INTO `property_images` VALUES (1,1,'/uploads/house1_main.jpg',1,'2025-12-10 07:42:04'),(2,1,'/uploads/house1_2.jpg',0,'2025-12-10 07:42:04'),(3,1,'/uploads/house1_3.jpg',0,'2025-12-10 07:42:04'),(4,2,'/uploads/villa1_main.jpg',1,'2025-12-10 07:42:04'),(5,2,'/uploads/villa1_2.jpg',0,'2025-12-10 07:42:04'),(6,2,'/uploads/villa1_3.jpg',0,'2025-12-10 07:42:04'),(7,3,'/uploads/house2_main.jpg',1,'2025-12-10 07:42:04'),(8,3,'/uploads/house2_2.jpg',0,'2025-12-10 07:42:04'),(9,4,'/uploads/apt1_main.jpg',1,'2025-12-10 07:42:04'),(10,4,'/uploads/apt1_2.jpg',0,'2025-12-10 07:42:04'),(11,4,'/uploads/apt1_3.jpg',0,'2025-12-10 07:42:04'),(12,5,'/uploads/apt2_main.jpg',1,'2025-12-10 07:42:04'),(13,5,'/uploads/apt2_2.jpg',0,'2025-12-10 07:42:04'),(14,6,'/uploads/penthouse1_main.jpg',1,'2025-12-10 07:42:04'),(15,6,'/uploads/penthouse1_2.jpg',0,'2025-12-10 07:42:04'),(16,7,'/uploads/land1_main.jpg',1,'2025-12-10 07:42:04'),(17,8,'/uploads/land2_main.jpg',1,'2025-12-10 07:42:04'),(18,9,'/uploads/shop1_main.jpg',1,'2025-12-10 07:42:04'),(19,9,'/uploads/shop1_2.jpg',0,'2025-12-10 07:42:04'),(20,10,'/uploads/rent_house1_main.jpg',1,'2025-12-10 07:42:04'),(21,11,'/uploads/rent_apt1_main.jpg',1,'2025-12-10 07:42:04'),(22,12,'/uploads/rent_studio1_main.jpg',1,'2025-12-10 07:42:04'),(23,13,'/uploads/rent_shop1_main.jpg',1,'2025-12-10 07:42:04'),(24,1,'https://picsum.photos/800/600?random=1',1,'2025-12-10 07:45:30'),(25,1,'https://picsum.photos/800/600?random=2',0,'2025-12-10 07:45:30'),(26,1,'https://picsum.photos/800/600?random=3',0,'2025-12-10 07:45:30'),(27,2,'https://picsum.photos/800/600?random=4',1,'2025-12-10 07:45:30'),(28,2,'https://picsum.photos/800/600?random=5',0,'2025-12-10 07:45:30'),(29,2,'https://picsum.photos/800/600?random=6',0,'2025-12-10 07:45:30'),(30,3,'https://picsum.photos/800/600?random=7',1,'2025-12-10 07:45:30'),(31,3,'https://picsum.photos/800/600?random=8',0,'2025-12-10 07:45:30'),(32,4,'https://picsum.photos/800/600?random=9',1,'2025-12-10 07:45:30'),(33,4,'https://picsum.photos/800/600?random=10',0,'2025-12-10 07:45:30'),(34,4,'https://picsum.photos/800/600?random=11',0,'2025-12-10 07:45:30'),(35,5,'https://picsum.photos/800/600?random=12',1,'2025-12-10 07:45:30'),(36,5,'https://picsum.photos/800/600?random=13',0,'2025-12-10 07:45:30'),(37,6,'https://picsum.photos/800/600?random=14',1,'2025-12-10 07:45:30'),(38,6,'https://picsum.photos/800/600?random=15',0,'2025-12-10 07:45:30'),(39,7,'https://picsum.photos/800/600?random=16',1,'2025-12-10 07:45:30'),(40,8,'https://picsum.photos/800/600?random=17',1,'2025-12-10 07:45:30'),(41,9,'https://picsum.photos/800/600?random=18',1,'2025-12-10 07:45:30'),(42,9,'https://picsum.photos/800/600?random=19',0,'2025-12-10 07:45:30'),(43,10,'https://picsum.photos/800/600?random=20',1,'2025-12-10 07:45:30'),(44,11,'https://picsum.photos/800/600?random=21',1,'2025-12-10 07:45:30'),(45,12,'https://picsum.photos/800/600?random=22',1,'2025-12-10 07:45:30'),(46,13,'https://picsum.photos/800/600?random=23',1,'2025-12-10 07:45:30'),(47,14,'https://picsum.photos/800/600?random=24',1,'2025-12-10 07:45:30'),(48,15,'https://picsum.photos/800/600?random=25',1,'2025-12-10 07:45:30'),(49,16,'https://picsum.photos/800/600?random=26',1,'2025-12-10 07:45:30'),(50,1,'/uploads/house1_main.jpg',1,'2025-12-10 17:13:59'),(51,1,'/uploads/house1_2.jpg',0,'2025-12-10 17:13:59'),(52,1,'/uploads/house1_3.jpg',0,'2025-12-10 17:13:59'),(53,2,'/uploads/villa1_main.jpg',1,'2025-12-10 17:13:59'),(54,2,'/uploads/villa1_2.jpg',0,'2025-12-10 17:13:59'),(55,2,'/uploads/villa1_3.jpg',0,'2025-12-10 17:13:59'),(56,3,'/uploads/house2_main.jpg',1,'2025-12-10 17:13:59'),(57,3,'/uploads/house2_2.jpg',0,'2025-12-10 17:13:59'),(58,4,'/uploads/apt1_main.jpg',1,'2025-12-10 17:13:59'),(59,4,'/uploads/apt1_2.jpg',0,'2025-12-10 17:13:59'),(60,4,'/uploads/apt1_3.jpg',0,'2025-12-10 17:13:59'),(61,5,'/uploads/apt2_main.jpg',1,'2025-12-10 17:13:59'),(62,5,'/uploads/apt2_2.jpg',0,'2025-12-10 17:13:59'),(63,6,'/uploads/penthouse1_main.jpg',1,'2025-12-10 17:13:59'),(64,6,'/uploads/penthouse1_2.jpg',0,'2025-12-10 17:13:59'),(65,7,'/uploads/land1_main.jpg',1,'2025-12-10 17:13:59'),(66,8,'/uploads/land2_main.jpg',1,'2025-12-10 17:13:59'),(67,9,'/uploads/shop1_main.jpg',1,'2025-12-10 17:13:59'),(68,9,'/uploads/shop1_2.jpg',0,'2025-12-10 17:13:59'),(69,10,'/uploads/rent_house1_main.jpg',1,'2025-12-10 17:13:59'),(70,11,'/uploads/rent_apt1_main.jpg',1,'2025-12-10 17:13:59'),(71,12,'/uploads/rent_studio1_main.jpg',1,'2025-12-10 17:13:59'),(72,13,'/uploads/rent_shop1_main.jpg',1,'2025-12-10 17:13:59'),(73,17,'/uploads/1765446239653_photo-1600596542815-ffad4c1539a9.jpg',1,'2025-12-11 09:43:59');
/*!40000 ALTER TABLE `property_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` enum('USER','ADMIN') COLLATE utf8mb4_unicode_ci DEFAULT 'USER',
  `status` enum('ACTIVE','BLOCKED') COLLATE utf8mb4_unicode_ci DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9','Administrator','admin@realestate.vn','0901234567','ADMIN','ACTIVE','2025-12-10 07:42:04','2025-12-10 07:42:04'),(2,'nguyenvana','6ca13d52ca70c883e0f0bb101e425a89e8624de51db2d2392593af6a84118090','Nguyễn Văn A','nguyenvana@gmail.com','0912345678','USER','ACTIVE','2025-12-10 07:42:04','2025-12-10 07:42:04'),(3,'tranthib','6ca13d52ca70c883e0f0bb101e425a89e8624de51db2d2392593af6a84118090','Trần Thị B','tranthib@gmail.com','0923456789','USER','ACTIVE','2025-12-10 07:42:04','2025-12-10 07:42:04'),(4,'levanc','6ca13d52ca70c883e0f0bb101e425a89e8624de51db2d2392593af6a84118090','Lê Văn C','levanc@gmail.com','0934567890','USER','ACTIVE','2025-12-10 07:42:04','2025-12-10 07:42:04'),(5,'phamthid','6ca13d52ca70c883e0f0bb101e425a89e8624de51db2d2392593af6a84118090','Phạm Thị D','phamthid@gmail.com','0945678901','USER','ACTIVE','2025-12-10 07:42:04','2025-12-10 07:42:04'),(6,'hoangvane','6ca13d52ca70c883e0f0bb101e425a89e8624de51db2d2392593af6a84118090','Hoàng Văn E','hoangvane@gmail.com','0956789012','USER','BLOCKED','2025-12-10 07:42:04','2025-12-10 07:42:04'),(7,'testuser','test123','Nguyễn Test','test@test.com','0999999999','USER','ACTIVE','2025-12-11 08:13:23','2025-12-11 08:13:23'),(8,'newuser','4d17fcbde3767e77a11f173cd1a1b2a6959b3cc2075d553759528e6be4149475','Nguyễn New','new@new.com','0888888888','USER','ACTIVE','2025-12-11 08:27:31','2025-12-11 08:27:31');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-11 16:52:52
