-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.29-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table project.bus
CREATE TABLE IF NOT EXISTS `bus` (
  `bus_id` int(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  `seat` int(20) NOT NULL,
  `color` varchar(20) DEFAULT NULL,
  `status` varchar(45) NOT NULL,
  `user_id` int(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`bus_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `bus_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table project.bus: ~3 rows (approximately)
/*!40000 ALTER TABLE `bus` DISABLE KEYS */;
INSERT INTO `bus` (`bus_id`, `type`, `seat`, `color`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
	(1, '2 ชั้น', 32, '#3068c1', '2', 8, NULL, NULL),
	(3, '2 ชั้น', 32, '#d61d4f', '2', 9, NULL, NULL),
	(4, '1 ชั้น', 24, '#dbe82c', '2', 8, '2018-02-16 18:58:50', '2018-02-16 18:58:50');
/*!40000 ALTER TABLE `bus` ENABLE KEYS */;

-- Dumping structure for table project.checkpoint_field
CREATE TABLE IF NOT EXISTS `checkpoint_field` (
  `check_id` int(20) NOT NULL AUTO_INCREMENT,
  `latitude` decimal(20,10) NOT NULL,
  `longitude` decimal(20,10) NOT NULL,
  `map_id` int(20) NOT NULL,
  `schedules_id` int(20) NOT NULL,
  `duration` varchar(150) DEFAULT NULL,
  `distance` varchar(150) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`check_id`),
  KEY `FK2_schedules_checkpoint` (`schedules_id`),
  KEY `FK2_map_schedules` (`map_id`),
  CONSTRAINT `FK2_map_schedules` FOREIGN KEY (`map_id`) REFERENCES `map` (`map_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK2_schedules_checkpoint` FOREIGN KEY (`schedules_id`) REFERENCES `schedules` (`schedules_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- Dumping data for table project.checkpoint_field: ~44 rows (approximately)
/*!40000 ALTER TABLE `checkpoint_field` DISABLE KEYS */;
INSERT INTO `checkpoint_field` (`check_id`, `latitude`, `longitude`, `map_id`, `schedules_id`, `duration`, `distance`, `created_date`, `updated_date`) VALUES
	(1, 13.9148466000, 100.5518308000, 1, 4, '10 hours 17 mins', '772 km', '2018-02-17 12:06:44', '2018-02-17 12:06:44'),
	(2, 13.9148466000, 100.5518308000, 1, 4, '10 hours 17 mins', '772 km', '2018-02-17 12:07:44', '2018-02-17 12:07:44'),
	(3, 13.9148104000, 100.5521978000, 1, 4, '10 hours 18 mins', '773 km', '2018-02-17 12:07:58', '2018-02-17 12:07:58'),
	(4, 13.9149738000, 100.5521933000, 1, 4, '10 hours 18 mins', '773 km', '2018-02-17 12:09:01', '2018-02-17 12:09:01'),
	(5, 13.9153606000, 100.5519801000, 1, 4, '10 hours 18 mins', '773 km', '2018-02-17 12:09:13', '2018-02-17 12:09:13'),
	(6, 13.9150147000, 100.5519081000, 1, 4, '10 hours 18 mins', '773 km', '2018-02-17 12:10:16', '2018-02-17 12:10:16'),
	(7, 13.9148289000, 100.5518553000, 1, 4, '10 hours 17 mins', '772 km', '2018-02-17 12:10:27', '2018-02-17 12:10:27'),
	(8, 13.9148289000, 100.5518553000, 1, 4, '10 hours 17 mins', '772 km', '2018-02-17 12:11:26', '2018-02-17 12:11:26'),
	(9, 13.9143296000, 100.5519311000, 1, 4, '10 hours 18 mins', '772 km', '2018-02-17 12:11:40', '2018-02-17 12:11:40'),
	(10, 13.9148451000, 100.5517970000, 1, 4, '10 hours 17 mins', '772 km', '2018-02-17 12:12:43', '2018-02-17 12:12:43'),
	(11, 13.9148619000, 100.5519128000, 1, 4, '10 hours 18 mins', '772 km', '2018-02-17 12:12:54', '2018-02-17 12:12:54'),
	(12, 13.9148359000, 100.5519229000, 1, 4, '10 hours 18 mins', '772 km', '2018-02-17 12:13:55', '2018-02-17 12:13:55'),
	(13, 13.9153412000, 100.5524928000, 1, 4, '10 hours 18 mins', '773 km', '2018-02-17 12:14:07', '2018-02-17 12:14:07'),
	(14, 13.9149780000, 100.5521873000, 1, 4, '10 hours 18 mins', '773 km', '2018-02-17 12:15:09', '2018-02-17 12:15:09'),
	(15, 13.9147634000, 100.5518201000, 1, 4, '10 hours 17 mins', '772 km', '2018-02-17 12:15:22', '2018-02-17 12:15:22'),
	(16, 13.9147769000, 100.5518024000, 1, 4, '10 hours 17 mins', '772 km', '2018-02-17 12:16:24', '2018-02-17 12:16:24'),
	(17, 13.9148800000, 100.5520627000, 1, 4, '10 hours 18 mins', '773 km', '2018-02-17 12:16:34', '2018-02-17 12:16:34'),
	(18, 13.9148800000, 100.5520627000, 1, 4, '10 hours 18 mins', '773 km', '2018-02-17 12:17:34', '2018-02-17 12:17:34'),
	(19, 13.9148173000, 100.5522561000, 1, 4, '10 hours 18 mins', '773 km', '2018-02-17 12:17:45', '2018-02-17 12:17:45'),
	(20, 13.9148056000, 100.5520766000, 1, 4, '10 hours 18 mins', '773 km', '2018-02-17 12:18:53', '2018-02-17 12:18:53'),
	(21, 13.9148399000, 100.5517992000, 1, 4, '10 hours 17 mins', '772 km', '2018-02-17 12:19:05', '2018-02-17 12:19:05'),
	(22, 13.9150673000, 100.5520539000, 1, 4, '10 hours 18 mins', '773 km', '2018-02-17 12:20:12', '2018-02-17 12:20:12'),
	(23, 13.9148466000, 100.5518308000, 1, 5, '10 hours 17 mins', '772 km', '2018-02-17 12:06:44', '2018-02-17 12:06:44'),
	(24, 13.9148466000, 100.5518308000, 1, 5, '10 hours 17 mins', '772 km', '2018-02-17 12:07:44', '2018-02-17 12:07:44'),
	(25, 13.9148104000, 100.5521978000, 1, 5, '10 hours 18 mins', '773 km', '2018-02-17 12:07:58', '2018-02-17 12:07:58'),
	(26, 13.9149738000, 100.5521933000, 1, 5, '10 hours 18 mins', '773 km', '2018-02-17 12:09:01', '2018-02-17 12:09:01'),
	(27, 13.9153606000, 100.5519801000, 1, 5, '10 hours 18 mins', '773 km', '2018-02-17 12:09:13', '2018-02-17 12:09:13'),
	(28, 13.9150147000, 100.5519081000, 1, 5, '10 hours 18 mins', '773 km', '2018-02-17 12:10:16', '2018-02-17 12:10:16'),
	(29, 13.9148289000, 100.5518553000, 1, 5, '10 hours 17 mins', '772 km', '2018-02-17 12:10:27', '2018-02-17 12:10:27'),
	(30, 13.9148289000, 100.5518553000, 1, 5, '10 hours 17 mins', '772 km', '2018-02-17 12:11:26', '2018-02-17 12:11:26'),
	(31, 13.9143296000, 100.5519311000, 1, 5, '10 hours 18 mins', '772 km', '2018-02-17 12:11:40', '2018-02-17 12:11:40'),
	(32, 13.9148451000, 100.5517970000, 1, 5, '10 hours 17 mins', '772 km', '2018-02-17 12:12:43', '2018-02-17 12:12:43'),
	(33, 13.9148619000, 100.5519128000, 1, 5, '10 hours 18 mins', '772 km', '2018-02-17 12:12:54', '2018-02-17 12:12:54'),
	(34, 13.9148359000, 100.5519229000, 1, 5, '10 hours 18 mins', '772 km', '2018-02-17 12:13:55', '2018-02-17 12:13:55'),
	(35, 13.9153412000, 100.5524928000, 1, 5, '10 hours 18 mins', '773 km', '2018-02-17 12:14:07', '2018-02-17 12:14:07'),
	(36, 13.9149780000, 100.5521873000, 1, 5, '10 hours 18 mins', '773 km', '2018-02-17 12:15:09', '2018-02-17 12:15:09'),
	(37, 13.9147634000, 100.5518201000, 1, 5, '10 hours 17 mins', '772 km', '2018-02-17 12:15:22', '2018-02-17 12:15:22'),
	(38, 13.9147769000, 100.5518024000, 1, 5, '10 hours 17 mins', '772 km', '2018-02-17 12:16:24', '2018-02-17 12:16:24'),
	(39, 13.9148800000, 100.5520627000, 1, 5, '10 hours 18 mins', '773 km', '2018-02-17 12:16:34', '2018-02-17 12:16:34'),
	(40, 13.9148800000, 100.5520627000, 1, 5, '10 hours 18 mins', '773 km', '2018-02-17 12:17:34', '2018-02-17 12:17:34'),
	(41, 13.9148173000, 100.5522561000, 1, 5, '10 hours 18 mins', '773 km', '2018-02-17 12:17:45', '2018-02-17 12:17:45'),
	(42, 13.9148056000, 100.5520766000, 1, 5, '10 hours 18 mins', '773 km', '2018-02-17 12:18:53', '2018-02-17 12:18:53'),
	(43, 13.9148399000, 100.5517992000, 1, 5, '10 hours 17 mins', '772 km', '2018-02-17 12:19:05', '2018-02-17 12:19:05'),
	(44, 13.9150673000, 100.5520539000, 1, 5, '10 hours 18 mins', '773 km', '2018-02-17 12:20:12', '2018-02-17 12:20:12');
/*!40000 ALTER TABLE `checkpoint_field` ENABLE KEYS */;

-- Dumping structure for table project.map
CREATE TABLE IF NOT EXISTS `map` (
  `map_id` int(20) NOT NULL AUTO_INCREMENT,
  `route` varchar(45) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `origin` varchar(150) DEFAULT NULL,
  `destination` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`map_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table project.map: ~2 rows (approximately)
/*!40000 ALTER TABLE `map` DISABLE KEYS */;
INSERT INTO `map` (`map_id`, `route`, `created_at`, `updated_at`, `origin`, `destination`) VALUES
	(1, 'BNK - CHM', NULL, '2018-02-17 02:42:27', '13.812436,100.546721', '19.929297,99.873415'),
	(2, 'CHM - BNK', '2018-02-17 04:39:33', '2018-02-17 04:39:33', NULL, NULL);
/*!40000 ALTER TABLE `map` ENABLE KEYS */;

-- Dumping structure for table project.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table project.migrations: ~2 rows (approximately)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Dumping structure for table project.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table project.password_resets: ~0 rows (approximately)
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Dumping structure for table project.report
CREATE TABLE IF NOT EXISTS `report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(255) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1_report_user_id` (`user_id`),
  CONSTRAINT `FK1_report_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table project.report: ~0 rows (approximately)
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
INSERT INTO `report` (`id`, `message`, `create_at`, `user_id`) VALUES
	(1, 'fdNFsjodfj;sdfhodsuf', '2018-02-07 20:53:55', 8);
/*!40000 ALTER TABLE `report` ENABLE KEYS */;

-- Dumping structure for table project.schedules
CREATE TABLE IF NOT EXISTS `schedules` (
  `schedules_id` int(20) NOT NULL AUTO_INCREMENT,
  `start` varchar(45) NOT NULL,
  `goal` varchar(45) NOT NULL,
  `map_id` int(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `bus_id` int(20) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `real_active_date` datetime NOT NULL,
  PRIMARY KEY (`schedules_id`),
  KEY `FK2_schedules_to_bus_id` (`bus_id`),
  KEY `FK2_scheduler_to_map_id` (`map_id`),
  CONSTRAINT `FK2_scheduler_to_map_id` FOREIGN KEY (`map_id`) REFERENCES `map` (`map_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK2_schedules_to_bus_id` FOREIGN KEY (`bus_id`) REFERENCES `bus` (`bus_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Dumping data for table project.schedules: ~2 rows (approximately)
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
INSERT INTO `schedules` (`schedules_id`, `start`, `goal`, `map_id`, `created_at`, `updated_at`, `bus_id`, `created_date`, `real_active_date`) VALUES
	(4, 'Bangkok', 'ChiangMai', 1, '2018-03-13 18:12:57', '2018-03-13 18:12:57', 1, '2018-01-12 20:35:00', '2018-03-13 00:00:00'),
	(5, 'Bangkok', 'ChiangMai', 1, '2018-03-13 18:46:03', '2018-03-13 18:46:03', 3, '2018-01-12 20:35:00', '2018-03-13 00:00:00');
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;

-- Dumping structure for table project.status
CREATE TABLE IF NOT EXISTS `status` (
  `status_id` int(20) NOT NULL AUTO_INCREMENT,
  `status_name` varchar(20) NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table project.status: ~2 rows (approximately)
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` (`status_id`, `status_name`) VALUES
	(1, 'Active'),
	(2, 'Inactive');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;

-- Dumping structure for table project.user
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(50) NOT NULL,
  `name` varchar(60) NOT NULL,
  `age` int(20) NOT NULL,
  `address` varchar(60) NOT NULL,
  `tel` varchar(20) NOT NULL,
  `status_id` int(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  KEY `status_id` (`status_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Dumping data for table project.user: ~3 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `username`, `password`, `name`, `age`, `address`, `tel`, `status_id`, `created_at`, `updated_at`) VALUES
	(1, 'patcha00', 'a1e2bc74f480a6ee9a8232f731530881', 'patchara meesawad', 21, '123/2 tiwanon road', '0879462846', 1, '0000-00-00 00:00:00', '2018-02-13 19:11:26'),
	(4, 'peter00', '04c8ee28793091f5150a9315c860935d', 'Peter Crouch', 25, '12/98 wall street', '017896523', 1, '0000-00-00 00:00:00', '2018-02-13 19:11:26'),
	(8, 'non', 'e10adc3949ba59abbe56e057f20f883e', 'non', 22, '12/74', '0785962345', 1, '0000-00-00 00:00:00', '2018-02-13 19:11:26'),
	(9, 'Frame', 'a8698009bce6d1b8c2128eddefc25aad', 'Frame', 22, '12/985', '0789456321', 1, '2018-02-13 12:12:05', '2018-02-13 12:19:07');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Dumping structure for table project.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table project.users: ~0 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'waranon petchthongyu', 'nonlexkaab@gmail.com', '$2y$10$QApv7TtPfTZaqWHfXN8q/.C5tO1VahYs0JfQsUWkZLlnnyOXmu7hG', 'F4YrbkfQiR2tZS0vl7wpgaWx85JWigdYx1ZEdJzXr73gTua4mKrbisOr1Dvh', '2018-02-13 11:49:48', '2018-02-13 11:49:48');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
