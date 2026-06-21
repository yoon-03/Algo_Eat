-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: algoeatDB
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `blacklists`
--

DROP TABLE IF EXISTS `blacklists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blacklists` (
  `blacklist_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `food_id` int DEFAULT NULL,
  PRIMARY KEY (`blacklist_id`),
  UNIQUE KEY `user_id` (`user_id`,`food_id`),
  KEY `food_id` (`food_id`),
  CONSTRAINT `blacklists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `blacklists_ibfk_2` FOREIGN KEY (`food_id`) REFERENCES `foods` (`food_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blacklists`
--

LOCK TABLES `blacklists` WRITE;
/*!40000 ALTER TABLE `blacklists` DISABLE KEYS */;
/*!40000 ALTER TABLE `blacklists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `choice_logs`
--

DROP TABLE IF EXISTS `choice_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `choice_logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `action_type` enum('Bad','Good') DEFAULT NULL,
  `log_date` datetime(6) DEFAULT NULL,
  `food_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `FK1j3ot1gh6cog7b9nbo3wp4vp8` (`food_id`),
  KEY `FK77imlgrhex3lix9k64660rk63` (`user_id`),
  CONSTRAINT `FK1j3ot1gh6cog7b9nbo3wp4vp8` FOREIGN KEY (`food_id`) REFERENCES `food` (`Food_id`),
  CONSTRAINT `FK77imlgrhex3lix9k64660rk63` FOREIGN KEY (`user_id`) REFERENCES `user` (`User_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `choice_logs`
--

LOCK TABLES `choice_logs` WRITE;
/*!40000 ALTER TABLE `choice_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `choice_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `choicelogs`
--

DROP TABLE IF EXISTS `choicelogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `choicelogs` (
  `Log_id` int NOT NULL AUTO_INCREMENT,
  `ActionType` enum('Good','Bad') NOT NULL,
  `Log_Date` datetime DEFAULT CURRENT_TIMESTAMP,
  `User_id` int DEFAULT NULL,
  `Food_id` int DEFAULT NULL,
  PRIMARY KEY (`Log_id`),
  KEY `User_id` (`User_id`),
  KEY `Food_id` (`Food_id`),
  CONSTRAINT `choicelogs_ibfk_1` FOREIGN KEY (`User_id`) REFERENCES `user` (`User_id`),
  CONSTRAINT `choicelogs_ibfk_2` FOREIGN KEY (`Food_id`) REFERENCES `food` (`Food_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `choicelogs`
--

LOCK TABLES `choicelogs` WRITE;
/*!40000 ALTER TABLE `choicelogs` DISABLE KEYS */;
INSERT INTO `choicelogs` VALUES (2,'Bad','2026-05-06 13:04:07',1,1),(3,'Bad','2026-05-12 13:15:17',1,1);
/*!40000 ALTER TABLE `choicelogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food` (
  `Food_id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `calories` int DEFAULT NULL,
  `carbs` decimal(38,2) DEFAULT NULL,
  `protein` decimal(38,2) DEFAULT NULL,
  `fat` decimal(38,2) DEFAULT NULL,
  `Image_url` text,
  `Nation` varchar(255) DEFAULT NULL,
  `Type` varchar(255) DEFAULT NULL,
  `Ingredient` varchar(255) DEFAULT NULL,
  `Taste` varchar(255) DEFAULT NULL,
  `Category` varchar(255) DEFAULT NULL,
  `tag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Food_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (1,'돈코츠 라멘',650,72.00,25.00,28.00,'https://plus.unsplash.com/premium_photo-1723669629687-0e618541c49e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8JUVCJThGJTg4JUVDJUJEJTk0JUVDJUI4JUEwJTIwJUVCJTlEJUJDJUVCJUE5JTk4fGVufDB8fDB8fHww','일식','면류','돼지고기','[\"진한맛\", \"고소함\", \"부드러움\"]','메인',NULL),(2,'소유 라멘',520,70.00,20.00,15.00,'https://images.unsplash.com/photo-1736032555596-1d06da981070?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8JUVDJTg2JThDJUVDJTlDJUEwJTIwJUVCJTlEJUJDJUVCJUE5JTk4fGVufDB8fDB8fHww','일식','면류','간장','[\"깔끔함\", \"짭짤함\", \"담백함\"]','메인',NULL),(3,'미소 라멘',600,72.00,23.00,22.00,'https://images.unsplash.com/photo-1637024696628-02cb19cc1829?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8JUVCJUFGJUI4JUVDJTg2JThDJTIwJUVCJTlEJUJDJUVCJUE5JTk4fGVufDB8fDB8fHww','일식','면류','된장','[\"구수한맛\", \"진한맛\", \"짭짤함\"]','메인',NULL),(4,'생연어 초밥',450,65.00,22.00,10.00,'https://images.unsplash.com/photo-1744360515510-db7bf0f6def8?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8JUVDJTk3JUIwJUVDJTk2JUI0JTIwJUVDJUI0JTg4JUVCJUIwJUE1fGVufDB8fDB8fHww','일식','생식','연어','[\"부드러움\", \"깔끔함\", \"신선함\"]','메인',NULL),(5,'에비텐동',720,88.00,24.00,28.00,'https://media.istockphoto.com/id/1181571949/ko/%EC%82%AC%EC%A7%84/%EC%9D%BC%EB%B3%B8-%EC%97%AC%ED%96%89.webp?a=1&b=1&s=612x612&w=0&k=20&c=wZRx3kUF1xJtSaCrIRuK_u-jmb0KIsomX6-iX8agVYc=','일식','튀김류','해산물','[\"바삭함\", \"고소함\", \"짭짤함\"]','메인',NULL),(6,'가츠동',780,90.00,30.00,32.00,'https://media.istockphoto.com/id/1443571049/ko/%EC%82%AC%EC%A7%84/%EB%8F%BC%EC%A7%80%EA%B3%A0%EA%B8%B0-%EB%8F%88%EA%B0%80%EC%8A%A4-on-rice.webp?a=1&b=1&s=612x612&w=0&k=20&c=TMrka4YQQ4SQ9_WHDbLsbzhfCh5XVaAdhwkk5yBqmp8=','일식','밥류','돼지고기','[\"달콤함\", \"부드러움\", \"짭짤함\"]','메인',NULL),(7,'규동',650,85.00,28.00,20.00,'https://media.istockphoto.com/id/1445400957/ko/%EC%82%AC%EC%A7%84/%EA%B7%9C%EB%8F%99.webp?a=1&b=1&s=612x612&w=0&k=20&c=eggZ599g6HDctjT40C2hsUT6ATBbTH5Um_Xadfj6Ubc=','일식','밥류','소고기','[\"짭짤함\", \"고소함\", \"담백함\"]','메인',NULL),(8,'사케동',620,85.00,28.00,18.00,'https://media.istockphoto.com/id/542967134/ko/%EC%82%AC%EC%A7%84/%EC%B0%B8%EC%B9%98-%EC%96%B4%EB%9E%80.webp?a=1&b=1&s=612x612&w=0&k=20&c=I0nIafWE6CIBZY1hAR7jdr2SRdLz3qvTqApPFf7l3dQ=','일식','밥류','연어','[\"부드러움\", \"깔끔함\", \"감칠맛\"]','메인',NULL),(9,'순두부찌개',430,25.00,22.00,24.00,'https://media.istockphoto.com/id/1967538628/ko/%EC%82%AC%EC%A7%84/%EC%84%A0%EB%91%90%EB%B6%80-%EC%A7%80%EA%B0%80%EC%97%90.webp?a=1&b=1&s=612x612&w=0&k=20&c=aSoDDkRLkjwJhs1wTkn2i7rGVvA4wh7dDFSgXP0P7PQ=','한식','국물류','두부','[\"얼큰함\", \"부드러움\", \"감칠맛\"]','메인',NULL),(10,'돼지김치찌개',500,20.00,28.00,32.00,'https://images.unsplash.com/photo-1777113310299-c3e41dec4e0f?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fCVFQiU4RiVCQyVFQyVBNyU4MCVFQSVCOSU4MCVFQyVCOSU5OCVFQyVCMCU4QyVFQSVCMCU5Q3xlbnwwfHwwfHx8MA%3D%3D','한식','국물류','돼지고기','[\"매운맛\", \"새콤함\", \"진한맛\"]','메인',NULL),(11,'된장찌개',420,22.00,24.00,25.00,'https://media.istockphoto.com/id/927678596/ko/%EC%82%AC%EC%A7%84/%ED%95%9C%EA%B5%AD-%EC%8B%9D%ED%92%88-chungkukjang.webp?a=1&b=1&s=612x612&w=0&k=20&c=P7dQPSNLuC_keJW8BBna0sJbsUp-zQB7dHvT_FRr93Q=','한식','국물류','소고기','[\"고소함\", \"진한맛\", \"구수한맛\"]','메인',NULL),(12,'제육볶음',700,65.00,35.00,32.00,'https://media.istockphoto.com/id/2232665681/ko/%EC%82%AC%EC%A7%84/%EC%A0%9C%EC%9C%A1%EB%B3%B5%EA%B7%BC%EC%9D%B4%EB%9D%BC%EA%B3%A0-%EB%B6%88%EB%A6%AC%EB%8A%94-%EB%A7%A4%EC%9A%B4-%EB%8F%BC%EC%A7%80%EA%B3%A0%EA%B8%B0-%EB%B3%B6%EC%9D%8C.webp?a=1&b=1&s=612x612&w=0&k=20&c=GsPz52cfMpajOfEywxBLgc7tgmaNIgBKANV2DEnyvf0=','한식','볶음류','돼지고기','[\"매운맛\", \"달콤함\", \"진한맛\"]','메인',NULL),(13,'육회비빔밥',680,90.00,30.00,20.00,'https://images.unsplash.com/photo-1692525080138-f9d2208a0b30?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8JUVDJTlDJUExJUVEJTlBJThDJUVCJUI5JTg0JUVCJUI5JTk0JUVCJUIwJUE1fGVufDB8fDB8fHww','한식','밥류','소고기','[\"신선함\", \"고소함\", \"깔끔함\"]','메인',NULL),(14,'물냉면',520,90.00,20.00,8.00,'https://images.unsplash.com/photo-1678685387070-a3205043eb7e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8JUVCJUFDJUJDJUVCJTgzJTg5JUVCJUE5JUI0fGVufDB8fDB8fHww','한식','면류','소고기','[\"시원함\", \"새콤함\", \"깔끔함\"]','메인',NULL),(15,'비빔냉면',600,100.00,18.00,10.00,'https://media.istockphoto.com/id/2228269743/ko/%EC%82%AC%EC%A7%84/%EB%A7%A4%EC%BD%A4%ED%95%98%EA%B3%A0-%EC%95%BD%EA%B0%84-%EB%8B%AC%EC%BD%A4%ED%95%9C-%EB%83%89%EB%A9%B4%EC%97%90-%EC%8B%A0%EC%84%A0%ED%95%9C-%EC%95%BC%EC%B1%84%EC%99%80-%EC%83%81%ED%81%BC%ED%95%98%EA%B3%A0-%ED%92%8D%EB%AF%B8-%EA%B0%80%EB%93%9D%ED%95%9C-%EC%86%8C%EC%8A%A4%EB%A5%BC-%EC%84%9E%EC%9D%80-%EC%9A%94%EB%A6%AC%EC%9E%85%EB%8B%88%EB%8B%A4.webp?a=1&b=1&s=612x612&w=0&k=20&c=mkMAANoEyl9RT8VfXxx8vCo1W5HxV6GUnRldsy5IjGA=','한식','면류','고구마전분','[\"매운맛\", \"새콤함\", \"달콤함\"]','메인',NULL),(16,'떡볶이',550,95.00,10.00,12.00,'https://media.istockphoto.com/id/1152570620/ko/%EC%82%AC%EC%A7%84/%EB%A7%A4%EC%9A%B4-%EB%96%A1.webp?a=1&b=1&s=612x612&w=0&k=20&c=PYG10j3unSQMgjRtV4lX0q7AT_u-CgoDf-zwIjnd5Xw=','한식','조림류','떡','[\"매운맛\", \"달콤함\", \"쫄깃함\"]','메인',NULL),(17,'짜장면',700,105.00,22.00,18.00,'https://images.unsplash.com/photo-1749880185157-97eacfbfdeea?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8JUVDJUE3JTlDJUVDJTlFJUE1JUVCJUE5JUI0fGVufDB8fDB8fHww','중식','면류','춘장','[\"달콤함\", \"고소함\", \"진한맛\"]','메인',NULL),(18,'짬뽕',650,90.00,28.00,18.00,'https://media.istockphoto.com/id/1156012773/ko/%EC%82%AC%EC%A7%84/%ED%95%9C%EA%B5%AD%EC%9D%98-%EB%A7%A4%EC%9A%B4-%ED%95%B4%EC%82%B0%EB%AC%BC-%EA%B5%AD%EC%88%98.webp?a=1&b=1&s=612x612&w=0&k=20&c=zJGvPrC1j89CAMpQ-lCURUmXspXqWiG1aoosVOTIVfY=','중식','국물류','해산물','[\"얼큰함\", \"매운맛\", \"시원함\"]','메인',NULL),(19,'마라탕',750,45.00,35.00,45.00,'https://media.istockphoto.com/id/2219323789/ko/%EC%82%AC%EC%A7%84/%ED%9D%B0%EC%83%89-%EB%B0%B0%EA%B2%BD%EC%97%90-malatang.webp?a=1&b=1&s=612x612&w=0&k=20&c=hK6wsMplUVXDVDG40TDYw4iCLWbNdK_TaC9ronGgZe4=','중식','국물류','다양함','[\"얼큰함\", \"매운맛\", \"향신료\"]','메인',NULL),(20,'까르보나라',780,85.00,25.00,35.00,'https://images.unsplash.com/photo-1627207644206-a2040d60ecad?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8JUVBJUI5JThDJUVCJUE1JUI0JUVCJUIzJUI0JUVCJTgyJTk4JUVCJTlEJUJDfGVufDB8fDB8fHww','양식','면류','크림','[\"꾸덕함\", \"고소함\", \"진한맛\"]','메인',NULL),(21,'마르게리따 피자',800,90.00,32.00,32.00,'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8JUVCJUE3JTg4JUVCJUE1JUI0JUVBJUIyJThDJUVCJUE2JUFDJUVCJTk0JUIwJTIwJUVEJTk0JUJDJUVDJTlFJTkwfGVufDB8fDB8fHww','양식','구이류','치즈','[\"짭짤함\", \"신선함\", \"고소함\"]','메인',NULL),(22,'페퍼로니 피자',950,95.00,38.00,45.00,'https://plus.unsplash.com/premium_photo-1733259709671-9dbf22bf02cc?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8JUVEJThFJTk4JUVEJThEJUJDJUVCJUExJTlDJUVCJThCJTg4JTIwJUVEJTk0JUJDJUVDJTlFJTkwfGVufDB8fDB8fHww','양식','구이류','치즈','[\"짭짤함\", \"신선함\", \"고소함\"]','메인',NULL),(23,'안심 스테이크',620,20.00,45.00,40.00,'https://media.istockphoto.com/id/2217480971/ko/%EC%82%AC%EC%A7%84/%EB%8F%8C%ED%8C%90%EC%97%90-%ED%96%A5%EC%8B%A0%EB%A3%8C%EC%99%80-%ED%97%88%EB%B8%8C%EA%B0%80-%EC%9E%88%EB%8A%94-%EC%87%A0%EA%B3%A0%EA%B8%B0-%EB%A9%94%EB%8B%AC%EB%A6%AC%EC%98%A8.webp?a=1&b=1&s=612x612&w=0&k=20&c=fbWujUXnoGGAI0Zc9rvDrfHJ6iMhKwEy5apiT6hdRao=','양식','구이류','소고기','[\"부드러움\", \"담백함\", \"진한맛\"]','메인',NULL),(24,'소고기 쌀국수',520,75.00,28.00,12.00,'https://media.istockphoto.com/id/535168737/ko/%EC%82%AC%EC%A7%84/%EB%B2%A0%ED%8A%B8%EB%82%A8%EC%9D%B8-%ED%8F%AC-%EB%88%84%EB%93%A4%EC%88%98%ED%94%84-%EB%B3%B4%EA%B4%80%ED%86%B5.webp?a=1&b=1&s=612x612&w=0&k=20&c=CN8k8B6wnax7oRiTkWhPpGxsPSz50swi8iMlXjCaMJo=','아시안','국물류','소고기','[\"깔끔함\", \"담백함\", \"시원함\"]','메인',NULL),(25,'팟타이',680,90.00,25.00,24.00,'https://images.unsplash.com/photo-1559314809-0d155014e29e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8JUVEJThDJTlGJUVEJTgzJTgwJUVDJTlEJUI0fGVufDB8fDB8fHww','아시안','볶음류','면','[\"새콤함\", \"달콤함\", \"고소함\"]','메인',NULL),(26,'가라아게',420,25.00,25.00,24.00,'https://media.istockphoto.com/id/2211767530/ko/%EC%82%AC%EC%A7%84/%EA%B0%80%EB%9D%BC%EC%95%84%EA%B2%8C-%EC%A3%BC%EC%B9%B4-%EC%B2%AD%EC%8B%9D-%EC%A0%95%EC%8B%9D.webp?a=1&b=1&s=612x612&w=0&k=20&c=fPQxO65lL4UtuXUJQJiS7a60qMsC8PwauFSSlm6nFgg=','일식','튀김류','닭고기','[\"고소함\", \"짭짤함\", \"바삭함\"]','사이드',NULL),(27,'교자 만두',350,35.00,15.00,16.00,'https://media.istockphoto.com/id/1286079738/ko/%EC%82%AC%EC%A7%84/%EA%B0%84%EC%9E%A5%EA%B3%BC-%EC%A0%93%EA%B0%80%EB%9D%BD-%ED%83%91-%EB%B7%B0%EB%A5%BC-%EA%B3%81%EB%93%A4%EC%9D%B8-%EB%A7%8C%EB%91%90-%EA%B5%90%EC%9E%90-%ED%8A%80%EA%B9%80.webp?a=1&b=1&s=612x612&w=0&k=20&c=u2aQGsjT3XNtrr3ROPtPuKpGnqXB-eg5dHDGE5M-jd8=','일식','튀김류','돼지고기','[\"고소함\", \"바삭함\", \"담백함\"]','사이드',NULL),(28,'감자튀김',380,48.00,5.00,18.00,'https://images.unsplash.com/photo-1606755456206-b25206cde27e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fCVFQSVCMCU5MCVFQyU5RSU5MCVFRCU4QSU4MCVFQSVCOSU4MHxlbnwwfHwwfHx8MA%3D%3D','양식','튀김류','채소','[\"짭짤함\", \"고소함\", \"바삭함\"]','사이드',NULL),(29,'그릭 요거트',220,18.00,15.00,8.00,'https://media.istockphoto.com/id/927134424/ko/%EC%82%AC%EC%A7%84/%EC%9D%BC%EB%B0%98-%EC%9A%94%EA%B5%AC%EB%A5%B4%ED%8A%B8%EB%8A%94-%EC%8A%88%ED%8D%BC-%EA%B1%B4%EA%B0%95.webp?a=1&b=1&s=612x612&w=0&k=20&c=49Rsi6sKF3VA-wjKTYWJLE_hkXoKvmu4vcJFnbZwjXM=','카페','생식','유제품','[\"새콤함\", \"부드러움\", \"담백함\"]','디저트',NULL),(30,'초코케이크',430,55.00,6.00,22.00,'https://plus.unsplash.com/premium_photo-1715015439764-1e8d37d5c6c9?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8JUVDJUExJUIwJUVBJUIwJTgxJTIwJUVDJUI0JTg4JUVDJUJEJTk0JUVDJUJDJTgwJUVDJTlEJUI0JUVEJTgxJUFDfGVufDB8fDB8fHww','카페','베이킹','밀가루','[\"달콤함\", \"꾸덕함\", \"진한맛\"]','디저트',NULL),(31,'생크림케이크',380,48.00,5.00,20.00,'https://images.unsplash.com/photo-1774689407321-7b0ff1c77f85?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8JUVDJTgzJTlEJUVEJTgxJUFDJUVCJUE2JUJDJTIwJUVDJUJDJTgwJUVDJTlEJUI0JUVEJTgxJUFDfGVufDB8fDB8fHww','카페','베이킹','밀가루','[\"달콤함\", \"꾸덕함\", \"진한맛\"]','디저트',NULL),(32,'치즈케이크',420,40.00,8.00,26.00,'https://images.unsplash.com/photo-1635327173758-85badf17f995?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fCVFQyVCOSU5OCVFQyVBNiU4OCVFQyVCQyU4MCVFQyU5RCVCNCVFRCU4MSVBQ3xlbnwwfHwwfHx8MA%3D%3D','카페','베이킹','밀가루','[\"달콤함\", \"꾸덕함\", \"진한맛\"]','디저트',NULL),(33,'김밥',480,75.00,15.00,12.00,'https://images.unsplash.com/photo-1608731002187-d3448d224d18?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8JUVBJUI5JTgwJUVCJUIwJUE1fGVufDB8fDB8fHww','한식','밥류','채소','[\"간편함\", \"담백함\", \"고소함\"]','메인',NULL),(34,'비빔밥',600,90.00,18.00,18.00,'https://images.unsplash.com/photo-1741295017668-c8132acd6fc0?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8JUVCJUI5JTg0JUVCJUI5JTk0JUVCJUIwJUE1fGVufDB8fDB8fHww','한식','밥류','채소','[\"신선함\", \"고소함\", \"담백함\"]','메인',NULL),(35,'닭가슴살 샐러드',350,18.00,35.00,14.00,'https://media.istockphoto.com/id/155372562/ko/%EC%82%AC%EC%A7%84/%EA%B5%AC%EC%9A%B4-%EB%8B%AD-%EA%B0%80%EC%8A%B4%EC%82%B4.webp?a=1&b=1&s=612x612&w=0&k=20&c=4vvhNLcF5wk-LeZdijd4A8wpIQRsmKFW5Lhfu0wjlY4=','양식','샐러드','닭고기','[\"담백함\", \"신선함\", \"가벼움\"]','메인',NULL),(36,'햄버거',750,65.00,32.00,38.00,'https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8JUVEJTk2JTg0JUVCJUIyJTg0JUVBJUIxJUIwfGVufDB8fDB8fHww','양식','간편식','소고기','[\"진한맛\", \"고소함\", \"든든함\"]','메인',NULL),(37,'후라이드치킨',900,45.00,55.00,55.00,'https://images.unsplash.com/photo-1586793783658-261cddf883ef?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8JUVEJTlCJTg0JUVCJTlEJUJDJUVDJTlEJUI0JUVCJTkzJTlDJTIwJUVDJUI5JTk4JUVEJTgyJUE4fGVufDB8fDB8fHww','양식','튀김류','닭고기','[\"바삭함\", \"고소함\", \"짭짤함\"]','메인',NULL),(38,'오므라이스',720,95.00,22.00,26.00,'https://media.istockphoto.com/id/2194211780/ko/%EC%82%AC%EC%A7%84/%EC%9D%BC%EB%B3%B8-%EC%98%A4%EB%AC%B4-%EB%9D%BC%EC%9D%B4%EC%8A%A4.webp?a=1&b=1&s=612x612&w=0&k=20&c=sfLbSOiJq5ycopEf-XH1QlHlgR-aSsUBpeMhXvZLCdk=','양식','밥류','달걀','[\"부드러움\", \"달콤함\", \"고소함\"]','메인',NULL),(39,'카레라이스',750,105.00,22.00,25.00,'https://images.unsplash.com/photo-1746256856691-032ecff4240f?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8ODl8fCVFQyVCOSVCNCVFQiVBMCU4OCVFQiU5RCVCQyVFQyU5RCVCNCVFQyU4QSVBNHxlbnwwfHwwfHx8MA%3D%3D','일식','밥류','돼지고기','[\"진한맛\", \"부드러움\", \"향신료\"]','메인',NULL),(40,'우동',480,85.00,15.00,8.00,'https://images.unsplash.com/photo-1707201124182-099f3d98bb90?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8JUVDJTlBJUIwJUVCJThGJTk5fGVufDB8fDB8fHww','일식','면류','밀가루','[\"담백함\", \"시원함\", \"쫄깃함\"]','메인',NULL),(41,'볶음우동',650,90.00,20.00,22.00,'https://images.unsplash.com/photo-1603356880409-49f9a654bdc9?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Njd8fCVFQiVCMyVCNiVFQyU5RCU4QyVFQyU5QSVCMCVFQiU4RiU5OXxlbnwwfHwwfHx8MA%3D%3D','일식','면류','밀가루','[\"꾸덕함\", \"짭짤함\", \"향신료\"]','메인',NULL),(42,'볶음밥',680,95.00,18.00,24.00,'https://media.istockphoto.com/id/2212832600/ko/%EC%82%AC%EC%A7%84/%EB%8B%AC%EA%B1%80-%EB%B3%B6%EC%9D%8C%EB%B0%A5.webp?a=1&b=1&s=612x612&w=0&k=20&c=kf5j8b7R28lIb2hwJojGOfES7OcwUGx-IvO6s3lYg7w=','중식','밥류','달걀','[\"고소함\", \"담백함\", \"든든함\"]','메인',NULL);
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `foods`
--

DROP TABLE IF EXISTS `foods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `foods` (
  `food_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `calories` int DEFAULT '0',
  `nation` varchar(20) DEFAULT NULL,
  `category` varchar(20) DEFAULT NULL,
  `ingredient` varchar(20) DEFAULT NULL,
  `image_url` text,
  PRIMARY KEY (`food_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foods`
--

LOCK TABLES `foods` WRITE;
/*!40000 ALTER TABLE `foods` DISABLE KEYS */;
/*!40000 ALTER TABLE `foods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history` (
  `History_id` bigint NOT NULL AUTO_INCREMENT,
  `EatDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `quantity` decimal(38,2) DEFAULT NULL,
  `User_id` int DEFAULT NULL,
  `Food_id` int DEFAULT NULL,
  `eat_date` datetime(6) DEFAULT NULL,
  `MealType` enum('BREAKFAST','LUNCH','DINNER','SNACK') DEFAULT NULL,
  `meal_type` enum('BREAKFAST','DINNER','LUNCH','SNACK') DEFAULT NULL,
  PRIMARY KEY (`History_id`),
  KEY `User_id` (`User_id`),
  KEY `Food_id` (`Food_id`),
  CONSTRAINT `history_ibfk_1` FOREIGN KEY (`User_id`) REFERENCES `user` (`User_id`),
  CONSTRAINT `history_ibfk_2` FOREIGN KEY (`Food_id`) REFERENCES `food` (`Food_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
INSERT INTO `history` VALUES (1,'2026-05-30 19:37:18',1.00,2,23,'2026-05-30 19:37:18.848427',NULL,'LUNCH'),(2,'2026-05-30 19:44:36',1.00,2,21,'2026-05-30 19:44:36.295134',NULL,'LUNCH'),(4,'2026-05-30 20:08:01',1.00,2,40,'2026-05-30 20:08:00.869663',NULL,'LUNCH'),(5,'2026-05-30 20:14:58',1.00,2,7,'2026-05-30 20:14:58.477303',NULL,'LUNCH'),(6,'2026-05-30 20:20:35',1.00,2,41,'2026-05-30 20:20:35.365857',NULL,'LUNCH'),(7,'2026-05-30 20:21:34',1.00,2,7,'2026-05-30 20:21:34.237230',NULL,'LUNCH'),(8,'2026-05-30 20:26:18',1.00,2,40,'2026-05-30 20:26:18.382561',NULL,'LUNCH'),(9,'2026-05-30 20:31:51',1.00,2,39,'2026-05-30 20:31:51.395902',NULL,'LUNCH'),(10,'2026-06-01 16:25:40',1.00,2,6,'2026-06-01 16:25:40.528142',NULL,'LUNCH'),(11,'2026-06-01 16:27:22',1.00,2,1,'2026-06-01 16:27:22.634885',NULL,'LUNCH'),(12,'2026-06-01 16:28:26',1.00,2,39,'2026-06-01 16:28:26.249050',NULL,'LUNCH'),(13,'2026-06-01 16:41:56',1.00,2,1,'2026-06-01 16:41:56.505212',NULL,'LUNCH'),(14,'2026-06-01 16:42:23',1.00,2,2,'2026-06-01 16:42:23.249406',NULL,'BREAKFAST'),(15,'2026-06-01 16:42:55',1.00,2,17,'2026-06-01 16:42:55.727265',NULL,'DINNER'),(16,'2026-06-01 16:47:37',1.00,2,39,'2026-06-01 16:47:37.484475',NULL,'DINNER'),(17,'2026-06-02 13:13:51',1.00,2,10,'2026-06-02 13:13:51.791670',NULL,'LUNCH'),(18,'2026-06-02 13:15:29',1.00,2,39,'2026-06-02 13:15:29.707276',NULL,'LUNCH'),(19,'2026-06-02 16:15:02',1.00,2,18,'2026-06-02 16:15:02.836628',NULL,'LUNCH'),(20,'2026-06-02 16:19:50',1.00,2,29,'2026-06-02 16:19:50.233373',NULL,'LUNCH'),(21,'2026-06-02 16:31:21',1.00,2,38,'2026-06-02 16:31:21.703082',NULL,'LUNCH'),(22,'2026-06-02 16:41:52',1.00,2,13,'2026-06-02 16:41:52.742432',NULL,'BREAKFAST'),(23,'2026-06-02 16:42:22',1.00,2,39,'2026-06-02 16:42:22.128130',NULL,'BREAKFAST');
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `User_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Gender` enum('MALE','FEMALE') DEFAULT NULL,
  `age` int DEFAULT NULL,
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `NickName` varchar(10) DEFAULT NULL,
  `BlackList` varchar(255) DEFAULT NULL,
  `Preference` json DEFAULT NULL,
  `black_list` varchar(255) DEFAULT NULL,
  `nick_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`User_id`),
  UNIQUE KEY `Email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'test@test.com','1234',NULL,NULL,NULL,NULL,'테스트',NULL,'{\"type\": {\"면류\": 1}, \"taste\": {\"고소함\": 1, \"진한맛\": 1, \"부드러움\": 1}, \"nation\": {\"일식\": 1}, \"ingredient\": {\"돼지고기\": 1}}',NULL,NULL),(2,'T@naver.com','1234','MALE',23,177,56,NULL,NULL,'{\"type\": {\"면류\": 22, \"밥류\": 11, \"생식\": 1, \"간편식\": 1, \"구이류\": 2, \"볶음류\": 1, \"샐러드\": 1, \"튀김류\": 1}, \"taste\": {\"가벼움\": 1, \"고소함\": 18, \"깔끔함\": 5, \"꾸덕함\": 3, \"달콤함\": 6, \"담백함\": 15, \"든든함\": 1, \"매운맛\": 2, \"바삭함\": 1, \"새콤함\": 3, \"시원함\": 6, \"신선함\": 3, \"진한맛\": 19, \"짭짤함\": 10, \"쫄깃함\": 5, \"향신료\": 6, \"구수한맛\": 1, \"부드러움\": 15}, \"nation\": {\"양식\": 7, \"일식\": 26, \"중식\": 2, \"카페\": 1, \"한식\": 4}, \"ingredient\": {\"간장\": 3, \"달걀\": 1, \"된장\": 1, \"춘장\": 2, \"치즈\": 1, \"크림\": 2, \"닭고기\": 1, \"밀가루\": 6, \"소고기\": 7, \"유제품\": 1, \"돼지고기\": 14, \"고구마전분\": 1}}','48',NULL),(3,'Park@naver.com','1234','MALE',24,185,70,NULL,NULL,NULL,'',NULL),(4,'E@naver.com','1234','MALE',16,167,34,NULL,NULL,NULL,'',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `gender` enum('MALE','FEMALE') DEFAULT NULL,
  `age` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
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

-- Dump completed on 2026-06-09 15:39:50
