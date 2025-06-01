/*
 Navicat Premium Dump SQL

 Source Server         : project_web
 Source Server Type    : MariaDB
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : security_information

 Target Server Type    : MariaDB
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 01/06/2025 23:22:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account_users
-- ----------------------------
DROP TABLE IF EXISTS `account_users`;
CREATE TABLE `account_users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` int(11) NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` tinyint(4) NOT NULL,
  `locked` tinyint(4) NOT NULL,
  `code` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idUser`(`idUser`) USING BTREE,
  CONSTRAINT `account_users_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of account_users
-- ----------------------------
INSERT INTO `account_users` VALUES (1, 10, 'hoang', 'dmpiYXZ2dmFidmFidmJhdmFoYmh2YWJoaGJhSG9hbmdQaGFuMTIzNzk2NjU2QCMkJVFAI2ZjZnZ5Z2I=', 1, 0, NULL);
INSERT INTO `account_users` VALUES (2, 11, 'HoangPhan123', 'dmpiYXZ2dmFidmFidmJhdmFoYmh2YWJoaGJhSG9hbmdQaGFuMTIzNzk2NjU2QCMkJVFAI2ZjZnZ5Z2I=', 1, 0, 0);

-- ----------------------------
-- Table structure for addresses
-- ----------------------------
DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `commune` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of addresses
-- ----------------------------
INSERT INTO `addresses` VALUES (1, 'Thủ Đức', 'Hồ Chí Minh', 'Linh Trung', 'ktx');
INSERT INTO `addresses` VALUES (2, 'Hà Nội', 'Hà Nội', 'Đống Đa', 'Xã Đàn');
INSERT INTO `addresses` VALUES (3, 'Hồ Chí Minh', 'Hồ Chí Minh', 'Quận 1', 'Nguyễn Huệ');
INSERT INTO `addresses` VALUES (4, 'Hồ Chí Minh', 'Hồ Chí Minh', 'Quận 3', 'Lê Văn Sỹ');
INSERT INTO `addresses` VALUES (5, 'Đà Nẵng', 'Đà Nẵng', 'Hải Châu', 'Nguyễn Văn Linh');
INSERT INTO `addresses` VALUES (6, 'Đà Nẵng', 'Đà Nẵng', 'Sơn Trà', 'Võ Nguyên Giáp');
INSERT INTO `addresses` VALUES (7, 'Cần Thơ', 'Cần Thơ', 'Ninh Kiều', '30 Tháng 4');
INSERT INTO `addresses` VALUES (8, 'Hải Phòng', 'Hải Phòng', 'Lê Chân', 'Trần Nguyên Hãn');
INSERT INTO `addresses` VALUES (9, 'Huế', 'Thừa Thiên Huế', 'Phú Hội', 'Hùng Vương');
INSERT INTO `addresses` VALUES (10, 'Nha Trang', 'Khánh Hòa', 'Vĩnh Hải', 'Trần Phú');
INSERT INTO `addresses` VALUES (11, 'Sample City', 'Sample Province', 'Sample Commune', 'Sample Street');
INSERT INTO `addresses` VALUES (12, 'Test City for UserKey', 'Test Province for UserKey', 'Test Commune for UserKey', 'Test Street for UserKey');
INSERT INTO `addresses` VALUES (13, 'Sample City', 'Sample Province', 'Sample Commune', 'Sample Street');
INSERT INTO `addresses` VALUES (14, 'Sample City', 'Sample Province', 'Sample Commune', 'Sample Street');
INSERT INTO `addresses` VALUES (15, 'Sample City', 'Sample Province', 'Sample Commune', 'Sample Street');

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, 'Vải may mặc');
INSERT INTO `categories` VALUES (2, 'Vải nội thất');
INSERT INTO `categories` VALUES (3, 'Nút áo');
INSERT INTO `categories` VALUES (4, 'Dây kéo');

-- ----------------------------
-- Table structure for deliveries
-- ----------------------------
DROP TABLE IF EXISTS `deliveries`;
CREATE TABLE `deliveries`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idOrder` int(11) NOT NULL,
  `idAddress` int(11) NOT NULL,
  `fullName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phoneNumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `area` double NOT NULL,
  `deliveryFee` double NOT NULL,
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `scheduledDateTime` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idAddress`(`idAddress`) USING BTREE,
  INDEX `idOrder`(`idOrder`) USING BTREE,
  CONSTRAINT `deliveries_ibfk_1` FOREIGN KEY (`idAddress`) REFERENCES `addresses` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `deliveries_ibfk_2` FOREIGN KEY (`idOrder`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of deliveries
-- ----------------------------
INSERT INTO `deliveries` VALUES (13, 1, 2, 'Nguyen Van A', '0901234567', 20.5, 50, 'Giao nhanh', 'Delivered', '2024-12-18 09:00:00');
INSERT INTO `deliveries` VALUES (14, 2, 3, 'Tran Thi B', '0902345678', 15, 40, 'Giao qua app', 'Pending', '2024-12-18 10:30:00');
INSERT INTO `deliveries` VALUES (15, 3, 4, 'Le Minh C', '0903456789', 25, 60, 'Khuyến mãi', 'Cancelled', '2024-12-18 12:00:00');
INSERT INTO `deliveries` VALUES (16, 4, 5, 'Pham Thi D', '0904567890', 18, 45, 'Giao tận nơi', 'In transit', '2024-12-18 14:00:00');
INSERT INTO `deliveries` VALUES (17, 5, 6, 'Hoang Minh E', '0905678901', 22.5, 55, 'Giao vào buổi tối', 'Delivered', '2024-12-18 17:30:00');
INSERT INTO `deliveries` VALUES (18, 6, 2, 'Nguyen Van A', '0901234567', 20.5, 50, 'Giao nhanh', 'Delivered', '2024-12-18 09:00:00');
INSERT INTO `deliveries` VALUES (19, 7, 3, 'Tran Thi B', '0902345678', 15, 40, 'Giao qua app', 'Pending', '2024-12-18 10:30:00');
INSERT INTO `deliveries` VALUES (20, 8, 4, 'Le Minh C', '0903456789', 25, 60, 'Khuyến mãi', 'Cancelled', '2024-12-18 12:00:00');
INSERT INTO `deliveries` VALUES (21, 9, 5, 'Pham Thi D', '0904567890', 18, 45, 'Giao tận nơi', 'In transit', '2024-12-18 14:00:00');
INSERT INTO `deliveries` VALUES (22, 10, 6, 'Hoang Minh E', '0905678901', 22.5, 55, 'Giao vào buổi tối', 'Delivered', '2024-12-18 17:30:00');
INSERT INTO `deliveries` VALUES (32, 30, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-30 22:43:30');
INSERT INTO `deliveries` VALUES (33, 30, 1, 'Test User', '1234567890', 15.5, 5, 'Test delivery note', 'Pending', '2025-05-31 17:43:15');
INSERT INTO `deliveries` VALUES (34, 30, 1, 'Test User', '1234567890', 15.5, 5, 'Test delivery note', 'Pending', '2025-05-31 17:56:57');
INSERT INTO `deliveries` VALUES (35, 35, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 17:58:09');
INSERT INTO `deliveries` VALUES (36, 36, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 17:59:15');
INSERT INTO `deliveries` VALUES (37, 37, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 20:13:16');
INSERT INTO `deliveries` VALUES (38, 38, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 20:17:48');
INSERT INTO `deliveries` VALUES (39, 39, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 21:09:06');
INSERT INTO `deliveries` VALUES (40, 40, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 21:14:01');
INSERT INTO `deliveries` VALUES (41, 41, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 21:16:15');
INSERT INTO `deliveries` VALUES (42, 42, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 21:17:49');
INSERT INTO `deliveries` VALUES (43, 43, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 21:19:20');
INSERT INTO `deliveries` VALUES (44, 44, 15, 'Test Recipient', '0987654321', 10.5, 5, 'Deliver to front door', 'Processing', '2025-05-30 21:23:07');
INSERT INTO `deliveries` VALUES (45, 45, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 21:24:11');
INSERT INTO `deliveries` VALUES (46, 46, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 21:31:44');
INSERT INTO `deliveries` VALUES (47, 47, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 21:35:10');
INSERT INTO `deliveries` VALUES (48, 48, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 21:38:11');
INSERT INTO `deliveries` VALUES (49, 49, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 21:41:44');
INSERT INTO `deliveries` VALUES (50, 50, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 21:55:36');
INSERT INTO `deliveries` VALUES (51, 51, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 22:00:07');
INSERT INTO `deliveries` VALUES (52, 52, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 22:07:52');
INSERT INTO `deliveries` VALUES (53, 53, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 22:13:32');
INSERT INTO `deliveries` VALUES (54, 54, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 22:18:45');
INSERT INTO `deliveries` VALUES (55, 55, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 22:29:26');
INSERT INTO `deliveries` VALUES (56, 56, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 22:43:16');
INSERT INTO `deliveries` VALUES (57, 57, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 22:46:16');
INSERT INTO `deliveries` VALUES (58, 58, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 22:52:15');
INSERT INTO `deliveries` VALUES (59, 59, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-05-31 23:11:44');
INSERT INTO `deliveries` VALUES (60, 60, 1, 'PHAN VĂN HOÀNG', '0335059497', 0, 30000, '', 'Đang giao hàng', '2025-06-03 13:19:30');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` int(11) NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idUser`(`idUser`) USING BTREE,
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idOrder` int(11) NOT NULL,
  `idStyle` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `totalPrice` double NOT NULL,
  `weight` double NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idStyle`(`idStyle`) USING BTREE,
  INDEX `idOrder`(`idOrder`) USING BTREE,
  CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`idStyle`) REFERENCES `styles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`idOrder`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 153 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_details
-- ----------------------------
INSERT INTO `order_details` VALUES (1, 1, 23, 2, 300000, 1.5);
INSERT INTO `order_details` VALUES (2, 1, 45, 1, 150000, 0.7);
INSERT INTO `order_details` VALUES (3, 2, 67, 3, 450000, 2);
INSERT INTO `order_details` VALUES (4, 2, 89, 4, 600000, 3.2);
INSERT INTO `order_details` VALUES (5, 3, 12, 1, 120000, 0.5);
INSERT INTO `order_details` VALUES (6, 3, 34, 2, 240000, 1);
INSERT INTO `order_details` VALUES (7, 4, 56, 5, 750000, 4);
INSERT INTO `order_details` VALUES (8, 4, 78, 1, 150000, 0.8);
INSERT INTO `order_details` VALUES (9, 5, 90, 2, 300000, 1.4);
INSERT INTO `order_details` VALUES (10, 5, 123, 3, 450000, 2.1);
INSERT INTO `order_details` VALUES (11, 6, 234, 1, 150000, 0.6);
INSERT INTO `order_details` VALUES (12, 6, 345, 2, 300000, 1.2);
INSERT INTO `order_details` VALUES (13, 7, 156, 4, 600000, 2.5);
INSERT INTO `order_details` VALUES (14, 7, 267, 1, 120000, 0.4);
INSERT INTO `order_details` VALUES (15, 8, 378, 3, 450000, 1.9);
INSERT INTO `order_details` VALUES (16, 8, 189, 2, 300000, 1.3);
INSERT INTO `order_details` VALUES (17, 9, 11, 1, 150000, 0.7);
INSERT INTO `order_details` VALUES (18, 9, 22, 5, 750000, 3.8);
INSERT INTO `order_details` VALUES (19, 10, 33, 2, 300000, 1.4);
INSERT INTO `order_details` VALUES (20, 10, 44, 3, 450000, 2);
INSERT INTO `order_details` VALUES (41, 1, 23, 2, 300000, 1.5);
INSERT INTO `order_details` VALUES (42, 1, 45, 1, 150000, 0.7);
INSERT INTO `order_details` VALUES (43, 2, 67, 3, 450000, 2);
INSERT INTO `order_details` VALUES (44, 2, 89, 4, 600000, 3.2);
INSERT INTO `order_details` VALUES (45, 3, 12, 1, 120000, 0.5);
INSERT INTO `order_details` VALUES (46, 3, 34, 2, 240000, 1);
INSERT INTO `order_details` VALUES (47, 4, 56, 5, 750000, 4);
INSERT INTO `order_details` VALUES (48, 4, 78, 1, 150000, 0.8);
INSERT INTO `order_details` VALUES (49, 5, 90, 2, 300000, 1.4);
INSERT INTO `order_details` VALUES (50, 5, 123, 3, 450000, 2.1);
INSERT INTO `order_details` VALUES (51, 6, 234, 1, 150000, 0.6);
INSERT INTO `order_details` VALUES (52, 6, 345, 2, 300000, 1.2);
INSERT INTO `order_details` VALUES (53, 7, 156, 4, 600000, 2.5);
INSERT INTO `order_details` VALUES (54, 7, 267, 1, 120000, 0.4);
INSERT INTO `order_details` VALUES (55, 8, 378, 3, 450000, 1.9);
INSERT INTO `order_details` VALUES (56, 8, 189, 2, 300000, 1.3);
INSERT INTO `order_details` VALUES (57, 9, 11, 1, 150000, 0.7);
INSERT INTO `order_details` VALUES (58, 9, 22, 5, 750000, 3.8);
INSERT INTO `order_details` VALUES (59, 10, 33, 2, 300000, 1.4);
INSERT INTO `order_details` VALUES (60, 10, 44, 3, 450000, 2);
INSERT INTO `order_details` VALUES (105, 11, 310, 1, 180000, 0.5);
INSERT INTO `order_details` VALUES (106, 12, 352, 1, 105000, 0.5);
INSERT INTO `order_details` VALUES (107, 13, 344, 1, 42000, 0.5);
INSERT INTO `order_details` VALUES (108, 14, 5, 1, 1900, 0.5);
INSERT INTO `order_details` VALUES (109, 15, 266, 1, 56000, 0.5);
INSERT INTO `order_details` VALUES (110, 16, 352, 1, 105000, 0.5);
INSERT INTO `order_details` VALUES (111, 16, 1, 1, 4500, 0.5);
INSERT INTO `order_details` VALUES (112, 17, 344, 1, 42000, 0.5);
INSERT INTO `order_details` VALUES (113, 18, 266, 2, 112000, 1);
INSERT INTO `order_details` VALUES (114, 19, 324, 1, 112500, 0.5);
INSERT INTO `order_details` VALUES (115, 20, 266, 1, 56000, 0.5);
INSERT INTO `order_details` VALUES (116, 21, 266, 1, 56000, 0.5);
INSERT INTO `order_details` VALUES (117, 22, 352, 1, 105000, 0.5);
INSERT INTO `order_details` VALUES (118, 23, 352, 1, 105000, 0.5);
INSERT INTO `order_details` VALUES (119, 24, 266, 1, 56000, 0.5);
INSERT INTO `order_details` VALUES (120, 25, 266, 2, 112000, 1);
INSERT INTO `order_details` VALUES (121, 26, 344, 1, 42000, 0.5);
INSERT INTO `order_details` VALUES (122, 27, 352, 1, 105000, 0.5);
INSERT INTO `order_details` VALUES (123, 28, 344, 1, 42000, 0.5);
INSERT INTO `order_details` VALUES (124, 29, 344, 1, 42000, 0.5);
INSERT INTO `order_details` VALUES (125, 30, 344, 1, 42000, 0.5);
INSERT INTO `order_details` VALUES (126, 33, 352, 1, 105000, 0.5);
INSERT INTO `order_details` VALUES (127, 34, 344, 1, 42000, 0.5);
INSERT INTO `order_details` VALUES (128, 35, 266, 1, 56000, 0.5);
INSERT INTO `order_details` VALUES (129, 36, 266, 1, 56000, 0.5);
INSERT INTO `order_details` VALUES (130, 37, 344, 1, 42000, 0.5);
INSERT INTO `order_details` VALUES (131, 38, 266, 1, 56000, 0.5);
INSERT INTO `order_details` VALUES (132, 39, 266, 1, 56000, 0.5);
INSERT INTO `order_details` VALUES (133, 40, 344, 1, 42000, 0.5);
INSERT INTO `order_details` VALUES (134, 41, 266, 1, 56000, 0.5);
INSERT INTO `order_details` VALUES (135, 42, 352, 1, 105000, 0.5);
INSERT INTO `order_details` VALUES (136, 43, 352, 1, 105000, 0.5);
INSERT INTO `order_details` VALUES (137, 45, 352, 1, 105000, 0.5);
INSERT INTO `order_details` VALUES (138, 46, 344, 1, 42000, 0.5);
INSERT INTO `order_details` VALUES (139, 47, 344, 1, 42000, 0.5);
INSERT INTO `order_details` VALUES (140, 48, 352, 1, 105000, 0.5);
INSERT INTO `order_details` VALUES (141, 49, 266, 1, 56000, 0.5);
INSERT INTO `order_details` VALUES (142, 50, 266, 1, 56000, 0.5);
INSERT INTO `order_details` VALUES (143, 51, 344, 1, 42000, 0.5);
INSERT INTO `order_details` VALUES (144, 52, 344, 2, 84000, 1);
INSERT INTO `order_details` VALUES (145, 53, 266, 1, 56000, 0.5);
INSERT INTO `order_details` VALUES (146, 54, 353, 1, 105000, 0.5);
INSERT INTO `order_details` VALUES (147, 55, 266, 1, 56000, 0.5);
INSERT INTO `order_details` VALUES (148, 56, 344, 1, 42000, 0.5);
INSERT INTO `order_details` VALUES (149, 57, 266, 1, 56000, 0.5);
INSERT INTO `order_details` VALUES (150, 58, 352, 1, 105000, 0.5);
INSERT INTO `order_details` VALUES (151, 59, 324, 1, 112500, 0.5);
INSERT INTO `order_details` VALUES (152, 60, 344, 1, 42000, 0.5);

-- ----------------------------
-- Table structure for order_signatures
-- ----------------------------
DROP TABLE IF EXISTS `order_signatures`;
CREATE TABLE `order_signatures`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `key_id` int(11) NOT NULL,
  `delivery_id` int(11) NOT NULL,
  `digital_signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `verified` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `create_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE,
  INDEX `key_id`(`key_id`) USING BTREE,
  INDEX `delivery_id`(`delivery_id`) USING BTREE,
  CONSTRAINT `order_signatures_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_signatures_ibfk_2` FOREIGN KEY (`key_id`) REFERENCES `user_keys` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_signatures_ibfk_3` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_signatures
-- ----------------------------
INSERT INTO `order_signatures` VALUES (5, 8, 1, 32, 'OE2anznvxFEGM52+pZ8rnQyn6j/m4IpN4Bcy6b7cUcg3+OqrEr4EMS8O1nklOCX7MUfIEqN4yyXIy4D0CrPSLWkC20PrKSyxqE0BkbkIOOTaxFvOnK8HGHVT7r5xqTCBi/cVtNIrMMewSas4xqpUaaNxG4tMZpvn/mUZdPQQ7jzZwgL9QU50xleyDGIZBQQmcHDyp4TE7/nVp9npqmSL6wD+dJBXjZK6URLhptS0OqDhRYtm+MtNabL/bvbdLkM', 'verified', '2025-05-29 11:58:56');
INSERT INTO `order_signatures` VALUES (7, 44, 8, 44, 'dummy_signature_for_testing', 'verified', NULL);
INSERT INTO `order_signatures` VALUES (9, 58, 9, 58, 'Hello', 'verified', NULL);
INSERT INTO `order_signatures` VALUES (10, 59, 9, 59, 'digitalSignatureTest', 'verified', NULL);
INSERT INTO `order_signatures` VALUES (11, 60, 9, 60, '', 'verified', NULL);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timeOrder` datetime NOT NULL,
  `idUser` int(11) NOT NULL,
  `idVoucher` int(11) NULL DEFAULT NULL,
  `statusOrder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `totalPrice` double NOT NULL,
  `lastPrice` double NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idUser`(`idUser`) USING BTREE,
  INDEX `idVoucher`(`idVoucher`) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`idVoucher`) REFERENCES `vouchers` (`idVoucher`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, '2024-12-01 10:30:00', 1, 1, 'Đang giao', 150000, 135000);
INSERT INTO `orders` VALUES (2, '2024-12-01 11:15:00', 2, NULL, 'Đã thanh toán', 200000, 200000);
INSERT INTO `orders` VALUES (3, '2024-12-02 14:00:00', 3, 1, 'Đang thêm', 250000, 225000);
INSERT INTO `orders` VALUES (4, '2024-12-03 09:45:00', 4, NULL, 'Đang thêm', 100000, 100000);
INSERT INTO `orders` VALUES (5, '2024-12-03 12:00:00', 5, 3, 'Đã thanh toán', 300000, 270000);
INSERT INTO `orders` VALUES (6, '2024-12-04 16:30:00', 6, NULL, 'Đã thanh toán', 50000, 50000);
INSERT INTO `orders` VALUES (7, '2024-12-05 08:20:00', 7, 1, 'Đang thêm', 120000, 108000);
INSERT INTO `orders` VALUES (8, '2024-12-05 19:00:00', 8, NULL, 'Đã thanh toán', 450000, 450000);
INSERT INTO `orders` VALUES (9, '2024-12-06 11:50:00', 9, 2, 'Đang giao', 600000, 540000);
INSERT INTO `orders` VALUES (10, '2024-12-07 15:10:00', 10, NULL, 'Đang thêm', 700000, 700000);
INSERT INTO `orders` VALUES (11, '2025-05-26 12:10:16', 11, NULL, 'Đang giao hàng', 180000, 210000);
INSERT INTO `orders` VALUES (12, '2025-05-26 12:20:36', 11, NULL, 'Đang giao hàng', 105000, 135000);
INSERT INTO `orders` VALUES (13, '2025-05-26 16:44:53', 11, NULL, 'Đang giao hàng', 42000, 72000);
INSERT INTO `orders` VALUES (14, '2025-05-26 16:50:19', 11, NULL, 'Đang giao hàng', 1900, 31900);
INSERT INTO `orders` VALUES (15, '2025-05-26 17:18:59', 11, NULL, 'Đang giao hàng', 56000, 86000);
INSERT INTO `orders` VALUES (16, '2025-05-26 17:55:29', 11, NULL, 'Đang giao hàng', 109500, 139500);
INSERT INTO `orders` VALUES (17, '2025-05-28 17:52:34', 11, NULL, 'Đang giao hàng', 42000, 72000);
INSERT INTO `orders` VALUES (18, '2025-05-28 18:32:59', 11, NULL, 'Đang giao hàng', 112000, 142000);
INSERT INTO `orders` VALUES (19, '2025-05-28 20:49:59', 11, NULL, 'Đang giao hàng', 112500, 142500);
INSERT INTO `orders` VALUES (20, '2025-05-28 20:56:11', 11, NULL, 'Đang giao hàng', 56000, 86000);
INSERT INTO `orders` VALUES (21, '2025-05-28 20:57:13', 11, NULL, 'Đang giao hàng', 56000, 86000);
INSERT INTO `orders` VALUES (22, '2025-05-28 20:59:04', 11, NULL, 'Đang giao hàng', 105000, 135000);
INSERT INTO `orders` VALUES (23, '2025-05-28 21:46:52', 11, NULL, 'Đang giao hàng', 105000, 135000);
INSERT INTO `orders` VALUES (24, '2025-05-28 21:55:58', 11, NULL, 'Đang giao hàng', 56000, 86000);
INSERT INTO `orders` VALUES (25, '2025-05-28 22:02:58', 11, NULL, 'Đang giao hàng', 112000, 142000);
INSERT INTO `orders` VALUES (26, '2025-05-28 22:18:19', 11, NULL, 'Đang giao hàng', 42000, 72000);
INSERT INTO `orders` VALUES (27, '2025-05-28 22:29:31', 11, NULL, 'Đang giao hàng', 105000, 135000);
INSERT INTO `orders` VALUES (28, '2025-05-28 22:35:50', 11, NULL, 'Đang giao hàng', 42000, 72000);
INSERT INTO `orders` VALUES (29, '2025-05-28 22:40:49', 11, NULL, 'Đang giao hàng', 42000, 72000);
INSERT INTO `orders` VALUES (30, '2025-05-28 22:43:30', 11, NULL, 'Đang giao hàng', 42000, 72000);
INSERT INTO `orders` VALUES (31, '2025-05-29 12:28:25', 14, NULL, 'Pending', 100, 90);
INSERT INTO `orders` VALUES (32, '2025-05-29 12:32:16', 15, NULL, 'Pending', 100, 90);
INSERT INTO `orders` VALUES (33, '2025-05-29 17:24:20', 11, NULL, 'Đang giao hàng', 105000, 135000);
INSERT INTO `orders` VALUES (34, '2025-05-29 17:25:53', 11, NULL, 'Đang giao hàng', 42000, 72000);
INSERT INTO `orders` VALUES (35, '2025-05-29 17:58:09', 11, NULL, 'Đang giao hàng', 56000, 86000);
INSERT INTO `orders` VALUES (36, '2025-05-29 17:59:15', 11, NULL, 'Đang giao hàng', 56000, 86000);
INSERT INTO `orders` VALUES (37, '2025-05-29 20:13:16', 11, NULL, 'Đang giao hàng', 42000, 72000);
INSERT INTO `orders` VALUES (38, '2025-05-29 20:17:48', 11, NULL, 'Đang giao hàng', 56000, 86000);
INSERT INTO `orders` VALUES (39, '2025-05-29 21:09:06', 11, NULL, 'Đang giao hàng', 56000, 86000);
INSERT INTO `orders` VALUES (40, '2025-05-29 21:14:01', 11, NULL, 'Đang giao hàng', 42000, 72000);
INSERT INTO `orders` VALUES (41, '2025-05-29 21:16:15', 11, NULL, 'Đang giao hàng', 56000, 86000);
INSERT INTO `orders` VALUES (42, '2025-05-29 21:17:49', 11, NULL, 'Đang giao hàng', 105000, 135000);
INSERT INTO `orders` VALUES (43, '2025-05-29 21:19:20', 11, NULL, 'Đang giao hàng', 105000, 135000);
INSERT INTO `orders` VALUES (44, '2025-05-29 21:23:07', 16, NULL, 'Pending', 100, 90);
INSERT INTO `orders` VALUES (45, '2025-05-29 21:24:11', 11, NULL, 'Đang giao hàng', 105000, 135000);
INSERT INTO `orders` VALUES (46, '2025-05-29 21:31:44', 11, NULL, 'Đang giao hàng', 42000, 72000);
INSERT INTO `orders` VALUES (47, '2025-05-29 21:35:10', 11, NULL, 'Đang giao hàng', 42000, 72000);
INSERT INTO `orders` VALUES (48, '2025-05-29 21:38:11', 11, NULL, 'Đang giao hàng', 105000, 135000);
INSERT INTO `orders` VALUES (49, '2025-05-29 21:41:44', 11, NULL, 'Đang giao hàng', 56000, 86000);
INSERT INTO `orders` VALUES (50, '2025-05-29 21:55:36', 11, NULL, 'Đang giao hàng', 56000, 86000);
INSERT INTO `orders` VALUES (51, '2025-05-29 22:00:07', 11, NULL, 'Đang giao hàng', 42000, 72000);
INSERT INTO `orders` VALUES (52, '2025-05-29 22:07:52', 11, NULL, 'Đang giao hàng', 84000, 114000);
INSERT INTO `orders` VALUES (53, '2025-05-29 22:13:32', 11, NULL, 'Đang giao hàng', 56000, 86000);
INSERT INTO `orders` VALUES (54, '2025-05-29 22:18:45', 11, NULL, 'Đang giao hàng', 105000, 135000);
INSERT INTO `orders` VALUES (55, '2025-05-29 22:29:26', 11, NULL, 'Đang giao hàng', 56000, 86000);
INSERT INTO `orders` VALUES (56, '2025-05-29 22:43:15', 11, NULL, 'Đang giao hàng', 42000, 72000);
INSERT INTO `orders` VALUES (57, '2025-05-29 22:46:16', 11, NULL, 'Đang giao hàng', 56000, 86000);
INSERT INTO `orders` VALUES (58, '2025-05-29 22:52:15', 11, NULL, 'Đang giao hàng', 105000, 135000);
INSERT INTO `orders` VALUES (59, '2025-05-29 23:11:44', 11, NULL, 'Đang giao hàng', 112500, 142500);
INSERT INTO `orders` VALUES (60, '2025-06-01 13:19:30', 11, NULL, 'Đang giao hàng', 42000, 72000);

-- ----------------------------
-- Table structure for payments
-- ----------------------------
DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idOrder` int(11) NOT NULL,
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  `price` double NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idOrder`(`idOrder`) USING BTREE,
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`idOrder`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payments
-- ----------------------------
INSERT INTO `payments` VALUES (1, 60, 'Transfer', 'Pending', '2025-06-01 23:02:37', 1);
INSERT INTO `payments` VALUES (5, 2, 'Cash', 'Completed', '2024-12-17 10:00:00', 150);
INSERT INTO `payments` VALUES (6, 3, 'Transfer', 'Pending', '2024-12-17 11:00:00', 200);
INSERT INTO `payments` VALUES (7, 4, 'Transfer', 'Completed', '2024-12-17 12:00:00', 120);
INSERT INTO `payments` VALUES (8, 5, 'Cash', 'Completed', '2024-12-17 14:00:00', 250);
INSERT INTO `payments` VALUES (9, 60, 'Cash', 'Pending', '2025-06-01 23:21:10', 1);

-- ----------------------------
-- Table structure for prices
-- ----------------------------
DROP TABLE IF EXISTS `prices`;
CREATE TABLE `prices`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` double NOT NULL,
  `discountPercent` double NOT NULL,
  `lastPrice` double GENERATED ALWAYS AS (`price` * (1 - `discountPercent` / 100)) PERSISTENT,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 182 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of prices
-- ----------------------------
INSERT INTO `prices` VALUES (1, 5000, 10, DEFAULT);
INSERT INTO `prices` VALUES (2, 2000, 5, DEFAULT);
INSERT INTO `prices` VALUES (3, 30000, 15, DEFAULT);
INSERT INTO `prices` VALUES (4, 50000, 20, DEFAULT);
INSERT INTO `prices` VALUES (5, 15000, 5, DEFAULT);
INSERT INTO `prices` VALUES (6, 25000, 10, DEFAULT);
INSERT INTO `prices` VALUES (7, 50000, 25, DEFAULT);
INSERT INTO `prices` VALUES (8, 35000, 10, DEFAULT);
INSERT INTO `prices` VALUES (9, 10000, 5, DEFAULT);
INSERT INTO `prices` VALUES (10, 45000, 15, DEFAULT);
INSERT INTO `prices` VALUES (11, 50000, 30, DEFAULT);
INSERT INTO `prices` VALUES (12, 12000, 0, DEFAULT);
INSERT INTO `prices` VALUES (13, 18000, 10, DEFAULT);
INSERT INTO `prices` VALUES (14, 45000, 20, DEFAULT);
INSERT INTO `prices` VALUES (15, 40000, 10, DEFAULT);
INSERT INTO `prices` VALUES (16, 50000, 25, DEFAULT);
INSERT INTO `prices` VALUES (17, 30000, 5, DEFAULT);
INSERT INTO `prices` VALUES (18, 45000, 15, DEFAULT);
INSERT INTO `prices` VALUES (19, 50000, 20, DEFAULT);
INSERT INTO `prices` VALUES (20, 50000, 30, DEFAULT);
INSERT INTO `prices` VALUES (21, 40000, 10, DEFAULT);
INSERT INTO `prices` VALUES (22, 50000, 5, DEFAULT);
INSERT INTO `prices` VALUES (23, 30000, 0, DEFAULT);
INSERT INTO `prices` VALUES (24, 50000, 15, DEFAULT);
INSERT INTO `prices` VALUES (25, 50000, 20, DEFAULT);
INSERT INTO `prices` VALUES (26, 50000, 10, DEFAULT);
INSERT INTO `prices` VALUES (27, 45000, 0, DEFAULT);
INSERT INTO `prices` VALUES (28, 50000, 25, DEFAULT);
INSERT INTO `prices` VALUES (29, 45000, 5, DEFAULT);
INSERT INTO `prices` VALUES (30, 30000, 30, DEFAULT);
INSERT INTO `prices` VALUES (31, 45000, 10, DEFAULT);
INSERT INTO `prices` VALUES (32, 50000, 15, DEFAULT);
INSERT INTO `prices` VALUES (33, 30000, 0, DEFAULT);
INSERT INTO `prices` VALUES (34, 50000, 5, DEFAULT);
INSERT INTO `prices` VALUES (35, 50000, 20, DEFAULT);
INSERT INTO `prices` VALUES (36, 45000, 15, DEFAULT);
INSERT INTO `prices` VALUES (37, 50000, 10, DEFAULT);
INSERT INTO `prices` VALUES (38, 45000, 5, DEFAULT);
INSERT INTO `prices` VALUES (39, 45000, 0, DEFAULT);
INSERT INTO `prices` VALUES (40, 30000, 25, DEFAULT);
INSERT INTO `prices` VALUES (41, 50000, 30, DEFAULT);
INSERT INTO `prices` VALUES (42, 40000, 20, DEFAULT);
INSERT INTO `prices` VALUES (43, 40000, 0, DEFAULT);
INSERT INTO `prices` VALUES (44, 30000, 15, DEFAULT);
INSERT INTO `prices` VALUES (45, 50000, 10, DEFAULT);
INSERT INTO `prices` VALUES (46, 45000, 5, DEFAULT);
INSERT INTO `prices` VALUES (47, 50000, 20, DEFAULT);
INSERT INTO `prices` VALUES (48, 50000, 15, DEFAULT);
INSERT INTO `prices` VALUES (49, 50000, 10, DEFAULT);
INSERT INTO `prices` VALUES (50, 40000, 25, DEFAULT);
INSERT INTO `prices` VALUES (51, 30000, 14, DEFAULT);
INSERT INTO `prices` VALUES (52, 20000, 12, DEFAULT);
INSERT INTO `prices` VALUES (53, 10000, 0, DEFAULT);
INSERT INTO `prices` VALUES (54, 20000, 10, DEFAULT);
INSERT INTO `prices` VALUES (55, 23000, 20, DEFAULT);
INSERT INTO `prices` VALUES (56, 12000, 10, DEFAULT);
INSERT INTO `prices` VALUES (57, 22000, 9.9, DEFAULT);
INSERT INTO `prices` VALUES (58, 12000, 8, DEFAULT);
INSERT INTO `prices` VALUES (59, 20000, 5, DEFAULT);
INSERT INTO `prices` VALUES (60, 40000, 30, DEFAULT);
INSERT INTO `prices` VALUES (61, 60000, 10, DEFAULT);
INSERT INTO `prices` VALUES (62, 35000, 5, DEFAULT);
INSERT INTO `prices` VALUES (63, 70000, 15, DEFAULT);
INSERT INTO `prices` VALUES (64, 45000, 0, DEFAULT);
INSERT INTO `prices` VALUES (65, 55000, 20, DEFAULT);
INSERT INTO `prices` VALUES (66, 30000, 10, DEFAULT);
INSERT INTO `prices` VALUES (67, 80000, 25, DEFAULT);
INSERT INTO `prices` VALUES (68, 25000, 0, DEFAULT);
INSERT INTO `prices` VALUES (69, 65000, 10, DEFAULT);
INSERT INTO `prices` VALUES (70, 45000, 5, DEFAULT);
INSERT INTO `prices` VALUES (71, 65000, 10, DEFAULT);
INSERT INTO `prices` VALUES (72, 40000, 5, DEFAULT);
INSERT INTO `prices` VALUES (73, 75000, 15, DEFAULT);
INSERT INTO `prices` VALUES (74, 50000, 0, DEFAULT);
INSERT INTO `prices` VALUES (75, 40000, 20, DEFAULT);
INSERT INTO `prices` VALUES (76, 85000, 25, DEFAULT);
INSERT INTO `prices` VALUES (77, 70000, 10, DEFAULT);
INSERT INTO `prices` VALUES (78, 45000, 0, DEFAULT);
INSERT INTO `prices` VALUES (79, 35000, 10, DEFAULT);
INSERT INTO `prices` VALUES (80, 50000, 5, DEFAULT);
INSERT INTO `prices` VALUES (81, 20000, 5, DEFAULT);
INSERT INTO `prices` VALUES (82, 30000, 10, DEFAULT);
INSERT INTO `prices` VALUES (83, 50000, 15, DEFAULT);
INSERT INTO `prices` VALUES (84, 25000, 5, DEFAULT);
INSERT INTO `prices` VALUES (85, 45000, 10, DEFAULT);
INSERT INTO `prices` VALUES (86, 22000, 0, DEFAULT);
INSERT INTO `prices` VALUES (87, 70000, 20, DEFAULT);
INSERT INTO `prices` VALUES (88, 80000, 25, DEFAULT);
INSERT INTO `prices` VALUES (89, 35000, 10, DEFAULT);
INSERT INTO `prices` VALUES (90, 15000, 5, DEFAULT);
INSERT INTO `prices` VALUES (91, 27000, 15, DEFAULT);
INSERT INTO `prices` VALUES (92, 40000, 10, DEFAULT);
INSERT INTO `prices` VALUES (93, 32000, 5, DEFAULT);
INSERT INTO `prices` VALUES (94, 37000, 10, DEFAULT);
INSERT INTO `prices` VALUES (95, 30000, 0, DEFAULT);
INSERT INTO `prices` VALUES (96, 90000, 20, DEFAULT);
INSERT INTO `prices` VALUES (97, 55000, 15, DEFAULT);
INSERT INTO `prices` VALUES (98, 28000, 5, DEFAULT);
INSERT INTO `prices` VALUES (99, 18000, 5, DEFAULT);
INSERT INTO `prices` VALUES (100, 22000, 10, DEFAULT);
INSERT INTO `prices` VALUES (101, 100000, 15, DEFAULT);
INSERT INTO `prices` VALUES (102, 120000, 20, DEFAULT);
INSERT INTO `prices` VALUES (103, 50000, 10, DEFAULT);
INSERT INTO `prices` VALUES (104, 200000, 25, DEFAULT);
INSERT INTO `prices` VALUES (105, 300000, 10, DEFAULT);
INSERT INTO `prices` VALUES (106, 150000, 20, DEFAULT);
INSERT INTO `prices` VALUES (107, 80000, 30, DEFAULT);
INSERT INTO `prices` VALUES (108, 90000, 5, DEFAULT);
INSERT INTO `prices` VALUES (109, 60000, 15, DEFAULT);
INSERT INTO `prices` VALUES (110, 110000, 10, DEFAULT);
INSERT INTO `prices` VALUES (111, 130000, 25, DEFAULT);
INSERT INTO `prices` VALUES (112, 140000, 10, DEFAULT);
INSERT INTO `prices` VALUES (113, 150000, 30, DEFAULT);
INSERT INTO `prices` VALUES (114, 160000, 20, DEFAULT);
INSERT INTO `prices` VALUES (115, 100000, 10, DEFAULT);
INSERT INTO `prices` VALUES (116, 50000, 20, DEFAULT);
INSERT INTO `prices` VALUES (117, 70000, 5, DEFAULT);
INSERT INTO `prices` VALUES (118, 40000, 15, DEFAULT);
INSERT INTO `prices` VALUES (119, 30000, 10, DEFAULT);
INSERT INTO `prices` VALUES (120, 200000, 30, DEFAULT);
INSERT INTO `prices` VALUES (121, 90000, 5, DEFAULT);
INSERT INTO `prices` VALUES (122, 110000, 10, DEFAULT);
INSERT INTO `prices` VALUES (123, 120000, 20, DEFAULT);
INSERT INTO `prices` VALUES (124, 80000, 30, DEFAULT);
INSERT INTO `prices` VALUES (125, 130000, 15, DEFAULT);
INSERT INTO `prices` VALUES (126, 130000, 25, DEFAULT);
INSERT INTO `prices` VALUES (127, 150000, 10, DEFAULT);
INSERT INTO `prices` VALUES (128, 180000, 15, DEFAULT);
INSERT INTO `prices` VALUES (129, 200000, 10, DEFAULT);
INSERT INTO `prices` VALUES (130, 180000, 20, DEFAULT);
INSERT INTO `prices` VALUES (131, 150000, 10, DEFAULT);
INSERT INTO `prices` VALUES (132, 120000, 15, DEFAULT);
INSERT INTO `prices` VALUES (133, 100000, 20, DEFAULT);
INSERT INTO `prices` VALUES (134, 120000, 15, DEFAULT);
INSERT INTO `prices` VALUES (135, 80000, 20, DEFAULT);
INSERT INTO `prices` VALUES (136, 150000, 25, DEFAULT);
INSERT INTO `prices` VALUES (137, 100000, 30, DEFAULT);
INSERT INTO `prices` VALUES (138, 200000, 15, DEFAULT);
INSERT INTO `prices` VALUES (139, 90000, 10, DEFAULT);
INSERT INTO `prices` VALUES (140, 110000, 25, DEFAULT);
INSERT INTO `prices` VALUES (141, 80000, 5, DEFAULT);
INSERT INTO `prices` VALUES (142, 140000, 15, DEFAULT);
INSERT INTO `prices` VALUES (143, 120000, 25, DEFAULT);
INSERT INTO `prices` VALUES (144, 50000, 20, DEFAULT);
INSERT INTO `prices` VALUES (145, 150000, 10, DEFAULT);
INSERT INTO `prices` VALUES (146, 60000, 30, DEFAULT);
INSERT INTO `prices` VALUES (147, 90000, 25, DEFAULT);
INSERT INTO `prices` VALUES (148, 150000, 10, DEFAULT);
INSERT INTO `prices` VALUES (149, 160000, 15, DEFAULT);
INSERT INTO `prices` VALUES (150, 150000, 30, DEFAULT);
INSERT INTO `prices` VALUES (151, 500000, 10, DEFAULT);
INSERT INTO `prices` VALUES (152, 300000, 5, DEFAULT);
INSERT INTO `prices` VALUES (153, 350000, 15, DEFAULT);
INSERT INTO `prices` VALUES (154, 250000, 20, DEFAULT);
INSERT INTO `prices` VALUES (155, 600000, 12, DEFAULT);
INSERT INTO `prices` VALUES (156, 700000, 10, DEFAULT);
INSERT INTO `prices` VALUES (157, 800000, 5, DEFAULT);
INSERT INTO `prices` VALUES (158, 450000, 18, DEFAULT);
INSERT INTO `prices` VALUES (159, 380000, 10, DEFAULT);
INSERT INTO `prices` VALUES (160, 550000, 15, DEFAULT);
INSERT INTO `prices` VALUES (161, 300000, 5, DEFAULT);
INSERT INTO `prices` VALUES (162, 400000, 8, DEFAULT);
INSERT INTO `prices` VALUES (163, 350000, 20, DEFAULT);
INSERT INTO `prices` VALUES (164, 600000, 10, DEFAULT);
INSERT INTO `prices` VALUES (165, 250000, 12, DEFAULT);
INSERT INTO `prices` VALUES (166, 700000, 15, DEFAULT);
INSERT INTO `prices` VALUES (167, 800000, 10, DEFAULT);
INSERT INTO `prices` VALUES (168, 350000, 5, DEFAULT);
INSERT INTO `prices` VALUES (169, 450000, 18, DEFAULT);
INSERT INTO `prices` VALUES (170, 300000, 8, DEFAULT);
INSERT INTO `prices` VALUES (171, 250000, 10, DEFAULT);
INSERT INTO `prices` VALUES (172, 180000, 12, DEFAULT);
INSERT INTO `prices` VALUES (173, 220000, 15, DEFAULT);
INSERT INTO `prices` VALUES (174, 350000, 20, DEFAULT);
INSERT INTO `prices` VALUES (175, 280000, 8, DEFAULT);
INSERT INTO `prices` VALUES (176, 300000, 5, DEFAULT);
INSERT INTO `prices` VALUES (177, 500000, 18, DEFAULT);
INSERT INTO `prices` VALUES (178, 350000, 10, DEFAULT);
INSERT INTO `prices` VALUES (179, 180000, 5, DEFAULT);
INSERT INTO `prices` VALUES (180, 200000, 12, DEFAULT);
INSERT INTO `prices` VALUES (181, 1000000, 0, DEFAULT);

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `addedDate` date NOT NULL,
  `idCategory` int(11) NOT NULL,
  `area` double NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `selling` tinyint(4) NOT NULL,
  `idTechnical` int(11) NOT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `idPrice` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idCategory`(`idCategory`) USING BTREE,
  INDEX `idTechnical`(`idTechnical`) USING BTREE,
  INDEX `idPrice`(`idPrice`) USING BTREE,
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`idCategory`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`idTechnical`) REFERENCES `technical_information` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `products_ibfk_3` FOREIGN KEY (`idPrice`) REFERENCES `prices` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 182 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 'Nút áo gỗ tròn', 119, '2024-12-01', 3, 0, 'Nút áo gỗ tròn cổ điển, phù hợp cho áo sơ mi và áo vest', 1, 1, 'https://down-vn.img.susercontent.com/file/vn-11134207-7ras8-m1o928ak9utvf2', 1);
INSERT INTO `products` VALUES (2, 'Nút áo nhựa bền', 199, '2024-12-02', 3, 0, 'Nút áo làm từ nhựa siêu bền, chống vỡ, phù hợp cho quần jeans', 1, 2, 'https://lh6.googleusercontent.com/proxy/FnLpCYGkgLKCs7lXU8hagkU-6oO-PBWB_KKLXqvkAINPUYz2uIzZSv_cGCG39YZYybvQjQf3yXD3wjziopgbVB9jv5aiU5g', 2);
INSERT INTO `products` VALUES (3, 'Nút áo kim loại nhỏ', 180, '2024-12-03', 3, 0, 'Nút áo kim loại kích thước nhỏ, phong cách tối giản', 1, 3, 'https://cbu01.alicdn.com/img/ibank/O1CN01Hm5X0I2MIkEi8f0aq_!!2212515449805-0-cib.jpg', 3);
INSERT INTO `products` VALUES (4, 'Nút áo gỗ chạm khắc', 90, '2024-12-04', 3, 0, 'Nút áo gỗ với họa tiết chạm khắc thủ công, thiết kế độc đáo', 1, 4, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvF7t3x6k_DKgoII3366wGldIaJVOQrddWwQ&s', 4);
INSERT INTO `products` VALUES (5, 'Nút áo nhựa mịn', 300, '2024-12-05', 3, 0, 'Nút áo nhựa với bề mặt mịn, lý tưởng cho áo thun và váy', 1, 5, 'https://phulieunganhmay.com.vn/wp-content/uploads/2021/03/cuc-nhua.jpg', 5);
INSERT INTO `products` VALUES (6, 'Nút áo vải', 250, '2024-12-06', 3, 0, 'Nút áo làm từ vải mềm, nhẹ, phù hợp cho trang phục mùa hè', 1, 6, 'https://down-vn.img.susercontent.com/file/f4b407d53ba674f329dcd13c8327e0e0', 6);
INSERT INTO `products` VALUES (7, 'Nút áo kim loại to', 140, '2024-12-07', 3, 0, 'Nút áo kim loại kích thước lớn, thích hợp cho áo khoác', 1, 7, 'https://down-vn.img.susercontent.com/file/d264e6958ae2a3f582d2e8d7839bfd08', 7);
INSERT INTO `products` VALUES (8, 'Nút áo gỗ tự nhiên', 170, '2024-12-08', 3, 0, 'Nút áo gỗ tự nhiên không xử lý hóa chất, thân thiện môi trường', 1, 8, 'https://s.alicdn.com/@sc04/kf/H8aaa4ed30ace42c6ac12e9904847b890Z.jpg_720x720q50.jpg', 8);
INSERT INTO `products` VALUES (9, 'Nút áo nhựa trong suốt', 130, '2024-12-09', 3, 0, 'Nút áo nhựa trong suốt, mang lại vẻ ngoài tinh tế', 1, 9, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQElXrO12JmAUwAlU1CtgOWWw-chW2Ur9PDQ&s', 9);
INSERT INTO `products` VALUES (10, 'Nút áo kim loại họa tiết', 100, '2024-12-10', 3, 0, 'Nút áo kim loại có họa tiết tinh xảo, phong cách vintage', 1, 10, 'https://down-vn.img.susercontent.com/file/5bd01cb45f0972bcaa08d8b3ef41664b', 10);
INSERT INTO `products` VALUES (11, 'Nút áo nam châm', 75, '2024-12-11', 3, 0, 'Nút áo sử dụng nam châm thay cho khuy cài truyền thống', 1, 11, 'https://namchamgiare.com/wp-content/uploads/2021/07/qwq.jpg', 11);
INSERT INTO `products` VALUES (12, 'Nút áo gỗ ép', 220, '2024-12-12', 3, 0, 'Nút áo làm từ gỗ ép, giá thành phải chăng, bền', 1, 12, 'https://down-vn.img.susercontent.com/file/vn-11134207-7ras8-m3c7u0gbd4n020', 12);
INSERT INTO `products` VALUES (13, 'Nút áo nhựa siêu nhẹ', 270, '2024-12-13', 3, 0, 'Nút áo nhựa siêu nhẹ, không gây nặng áo khi sử dụng', 1, 13, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQd3FwIpDWcEyg2aCLg14mIWzdWekOcxQDZsA&s', 13);
INSERT INTO `products` VALUES (14, 'Nút áo vải thêu tay', 80, '2024-12-14', 3, 0, 'Nút áo vải với họa tiết thêu tay tinh tế, độc nhất vô nhị', 1, 14, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lxng525pc8gp50', 14);
INSERT INTO `products` VALUES (15, 'Nút áo gỗ ghép họa tiết', 110, '2024-12-15', 3, 0, 'Nút áo gỗ ghép nhiều lớp, tạo họa tiết đặc biệt', 1, 15, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-m0czy63l5mrz88', 15);
INSERT INTO `products` VALUES (16, 'Nút áo kim loại chống gỉ', 200, '2024-12-16', 3, 0, 'Nút áo kim loại với lớp phủ chống gỉ, độ bền cao', 1, 16, 'https://phulieumayhtb.com/wp-content/uploads/2018/01/cuc-ao-kim-loai.jpg', 16);
INSERT INTO `products` VALUES (17, 'Nút áo nhựa tái chế', 250, '2024-12-17', 3, 0, 'Nút áo làm từ nhựa tái chế, bảo vệ môi trường', 1, 17, 'https://vannang-banok.com/datafiles/thumb_1708578732_DSC_0947.jpg', 17);
INSERT INTO `products` VALUES (18, 'Nút áo gỗ sơn bóng', 180, '2024-12-18', 3, 0, 'Nút áo gỗ được sơn bóng, mang lại vẻ ngoài cao cấp', 1, 18, 'https://product.hstatic.net/1000193091/product/tay_nam_gu_go_vnh__2__9860466b999e4ac4a8a0223014f382bf.jpg', 18);
INSERT INTO `products` VALUES (19, 'Nút áo kim loại đính đá', 60, '2024-12-19', 3, 0, 'Nút áo kim loại đính đá lấp lánh, dành cho trang phục sang trọng', 1, 19, 'https://down-vn.img.susercontent.com/file/b6de9a177c165f9ed6b2af6126072d6d', 19);
INSERT INTO `products` VALUES (20, 'Nút áo từ sừng tự nhiên', 40, '2024-12-20', 3, 0, 'Nút áo làm từ sừng tự nhiên, phong cách độc đáo và quý phái', 1, 20, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIE8FMhqTzYc0Fl_Lof7GorAOoVpfbutDQnA&s', 20);
INSERT INTO `products` VALUES (21, 'Nút áo nhựa chịu lực', 120, '2024-12-15', 3, 0, 'Chất liệu nhựa siêu bền, chịu lực tốt, phù hợp cho áo khoác', 1, 21, 'https://phulieumayhtb.com/wp-content/uploads/2017/09/cuc-somi1.jpg', 21);
INSERT INTO `products` VALUES (22, 'Nút áo sừng tự nhiên', 80, '2024-12-16', 3, 0, 'Nút áo được làm từ sừng tự nhiên, thiết kế tinh xảo', 1, 22, 'https://image.made-in-china.com/202f0j00nPdcbCWmQkqG/Quality-Customized-4-Holes-Natural-Horn-Buttons-for-Shirt-Men-Suit-Coat-Overcoat-Resin-Button.webp', 22);
INSERT INTO `products` VALUES (23, 'Nút áo bằng tre ép', 200, '2024-12-17', 3, 0, 'Nút áo làm từ tre ép, thân thiện môi trường', 1, 23, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXNqYCmuw5_WNFIYg0MJebLW7H7jKORYglXg&s', 23);
INSERT INTO `products` VALUES (24, 'Nút áo vải dệt cao cấp', 150, '2024-12-18', 3, 0, 'Nút áo vải dệt, họa tiết thêu độc đáo', 1, 24, 'https://image.made-in-china.com/202f0j00RZkUzuJnnTby/Fancy-Ladies-Resin-Shirt-Buttons-for-Cloth-Sewing-Customize-Engraved-Logo.webp', 24);
INSERT INTO `products` VALUES (25, 'Nút áo hợp kim chống gỉ', 90, '2024-12-19', 3, 0, 'Hợp kim chống gỉ, lý tưởng cho thời trang cao cấp', 1, 25, 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lfib7zradbb83b', 25);
INSERT INTO `products` VALUES (26, 'Nút áo gỗ sồi tự nhiên', 75, '2024-12-20', 3, 0, 'Nút áo làm từ gỗ sồi, kiểu dáng thanh lịch', 1, 26, 'https://down-vn.img.susercontent.com/file/6d9b2cd5fb5a46fa5404c53782081225', 26);
INSERT INTO `products` VALUES (27, 'Nút áo nhựa trong suốt', 140, '2024-12-21', 3, 0, 'Chất liệu nhựa trong suốt, phù hợp với nhiều loại vải', 1, 27, 'https://www.mh-chine.com/media/djcatalog2/images/item/141/18l-4holes-clear-resin-button-6620-0014.1_l.webp', 27);
INSERT INTO `products` VALUES (28, 'Nút áo kim loại phủ sơn', 180, '2024-12-22', 3, 0, 'Kim loại phủ sơn chống gỉ, màu sắc bền đẹp', 1, 28, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRa0jmvvJdU8I94YvTXRH2O21o8fb9r5_q38w&s', 28);
INSERT INTO `products` VALUES (29, 'Nút áo vải tái chế', 130, '2024-12-23', 3, 0, 'Nút áo từ vải tái chế, bảo vệ môi trường', 1, 29, 'https://image.made-in-china.com/202f0j00LHKkoBmlAgqT/Plastic-Resin-Shirt-Button-Buttons-for-Shirt-Recycled-Shell-Plastic-Natural-Wholesale-Custom-4-Holes-4-Holes-Button-Dyed.webp', 29);
INSERT INTO `products` VALUES (30, 'Nút áo bọc da cao cấp', 60, '2024-12-24', 3, 0, 'Nút áo được bọc da, sang trọng và bền bỉ', 1, 30, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9ZHp9vzxfDOVV-bBAXY7SWpudwQUeO77jfw&s', 30);
INSERT INTO `products` VALUES (31, 'Nút áo dập nổi họa tiết', 100, '2024-12-25', 3, 0, 'Chất liệu kim loại, họa tiết dập nổi tinh xảo', 1, 31, 'https://down-vn.img.susercontent.com/file/9faafdb75e10d876c46d2f7be90b5768', 31);
INSERT INTO `products` VALUES (32, 'Nút áo gỗ ghép thủ công', 85, '2024-12-26', 3, 0, 'Gỗ ghép thủ công, tạo họa tiết tự nhiên', 1, 32, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-m0czy63l5mrz88', 32);
INSERT INTO `products` VALUES (33, 'Nút áo composite bền đẹp', 120, '2024-12-27', 3, 0, 'Chất liệu composite, bền đẹp với thời gian', 1, 33, 'https://down-vn.img.susercontent.com/file/f20e6611efb03e7ea13d3b71b3fb3637', 33);
INSERT INTO `products` VALUES (34, 'Nút áo hợp kim nhôm nhẹ', 70, '2024-12-28', 3, 0, 'Hợp kim nhôm nhẹ, kiểu dáng hiện đại', 1, 34, 'https://down-vn.img.susercontent.com/file/sg-11134201-22110-tmyhh1iqgrjvcd', 34);
INSERT INTO `products` VALUES (35, 'Nút áo sứ tráng men', 45, '2024-12-29', 3, 0, 'Nút áo sứ, lớp men bền đẹp, sang trọng', 1, 35, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lpd5ysf6acm34c', 35);
INSERT INTO `products` VALUES (36, 'Nút áo thép không gỉ', 110, '2024-12-30', 3, 0, 'Thép không gỉ, chịu được mọi điều kiện thời tiết', 1, 36, 'https://down-vn.img.susercontent.com/file/sg-11134201-23020-5t9u0g3cg1mva1', 36);
INSERT INTO `products` VALUES (37, 'Nút áo đồng cổ điển', 95, '2025-01-01', 3, 0, 'Đồng cổ điển, thiết kế vintage', 1, 37, 'https://down-vn.img.susercontent.com/file/1f6636bc9a22434535492bf170e4693f', 37);
INSERT INTO `products` VALUES (38, 'Nút áo nhôm anod hóa', 130, '2025-01-02', 3, 0, 'Nhôm anod hóa, bề mặt mịn và sáng bóng', 1, 38, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSI5Yqr9kRj4lRdlKzxCrdWMEfToxMdi1iO4g&s', 38);
INSERT INTO `products` VALUES (39, 'Nút áo từ bã caffee', 125, '2025-01-03', 3, 0, 'Sản phẩm thân thiện với môi trường từ bã mía', 1, 39, 'https://vannang-banok.com/datafiles/1659606651_z3617537977379_24365e0b4be595363c8535bc1059d6a6.jpg', 39);
INSERT INTO `products` VALUES (40, 'Nút áo carbon siêu nhẹ', 50, '2025-01-04', 3, 0, 'Carbon siêu nhẹ, độ bền vượt trội', 1, 40, 'https://s.alicdn.com/@sc04/kf/HTB1YXgDbwaH3KVjSZFpq6zhKpXaI.jpg_720x720q50.jpg', 40);
INSERT INTO `products` VALUES (41, 'Nút áo phủ silicon chống trơn', 150, '2025-01-05', 3, 0, 'Chất liệu phủ silicon, chống trơn trượt', 1, 41, 'https://down-vn.img.susercontent.com/file/bf0da3d830de8ffa964c7a2f575fb953', 41);
INSERT INTO `products` VALUES (42, 'Nút áo thép mạ vàng', 35, '2025-01-06', 3, 0, 'Thép mạ vàng, sang trọng, bền bỉ', 1, 42, 'https://down-vn.img.susercontent.com/file/sg-11134201-23030-x3uhby17lcov17', 42);
INSERT INTO `products` VALUES (43, 'Nút áo gỗ dừa', 60, '2025-01-07', 3, 0, 'Gỗ dừa tự nhiên, thiết kế độc đáo', 1, 43, 'https://down-vn.img.susercontent.com/file/9487b8261ff895eb0c72d198349a0630', 43);
INSERT INTO `products` VALUES (44, 'Nút áo khuy ngọc trai', 200, '2025-01-08', 3, 0, 'Chất liệu da nhân tạo, phù hợp cho áo khoác', 1, 44, 'https://down-vn.img.susercontent.com/file/3f813ba483002d623df1792b23ab09db', 44);
INSERT INTO `products` VALUES (45, 'Nút áo thêu tay', 80, '2025-01-09', 3, 0, 'Vải thêu tay thủ công, mang phong cách nghệ thuật', 1, 45, 'https://handmade.sgf.org.vn/uploads/shops/cuc-ao-2/cuc-ao-theu-tay-sgf-ca-031-2.jpg', 45);
INSERT INTO `products` VALUES (46, 'Nút áo gỗ mun tự nhiên', 70, '2025-01-10', 3, 0, 'Gỗ mun, độ bền cao, màu sắc đẹp tự nhiên', 1, 46, 'https://phulieumayhtb.com/wp-content/uploads/2018/01/nut-go-7.jpg', 46);
INSERT INTO `products` VALUES (47, 'Nút áo composite phủ mờ', 100, '2025-01-11', 3, 0, 'Composite phủ mờ, kiểu dáng hiện đại', 1, 47, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzt7gex72gGv-LIEBXppXhZ3ZIbpi2UBuiOg&s', 47);
INSERT INTO `products` VALUES (48, 'Nút áo vải đính cườm', 90, '2025-01-12', 3, 0, 'Vải đính cườm, phù hợp thời trang cao cấp', 1, 48, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lnl38eflr4vu26', 48);
INSERT INTO `products` VALUES (49, 'Nút áo hợp kim titan', 40, '2025-01-13', 3, 0, 'Hợp kim titan, độ bền cao và siêu nhẹ', 1, 49, 'https://inoxcongsang.com/wp-content/uploads/2018/09/TB025c-bong-tai-titan-nut-ao.jpg', 49);
INSERT INTO `products` VALUES (50, 'Nút áo sứ họa tiết thủ công', 55, '2025-01-14', 3, 0, 'Sứ họa tiết thủ công, mang đậm phong cách truyền thống', 1, 50, 'https://down-vn.img.susercontent.com/file/9203e1601391b58be766beaad6d91c99', 50);
INSERT INTO `products` VALUES (51, 'Dây kéo kim loại vàng', 120, '2024-12-15', 4, 0, 'Dây kéo kim loại màu vàng, bền và sang trọng', 1, 51, 'https://gacuoi.com/upload/product/day-keo-kim-loai-vang-mo23003.jpg', 51);
INSERT INTO `products` VALUES (52, 'Dây kéo nhựa trong', 150, '2024-12-16', 4, 0, 'Dây kéo nhựa trong suốt, nhẹ và bền', 1, 52, 'https://sinocomfort.com/wp-content/uploads/2022/02/pl15924154-comfortworld_cn.jpg', 52);
INSERT INTO `products` VALUES (53, 'Dây kéo thép không gỉ', 100, '2024-12-17', 4, 0, 'Dây kéo thép không gỉ, chống rỉ sét và bền lâu', 1, 53, 'https://down-vn.img.susercontent.com/file/sg-11134201-7rd3y-lx20twmuje16ad', 53);
INSERT INTO `products` VALUES (54, 'Dây kéo cao su', 130, '2024-12-18', 4, 0, 'Dây kéo cao su, dẻo dai và dễ sử dụng', 1, 54, 'https://s.alicdn.com/@sc04/kf/HTB1lcOFdYAaBuNjt_igq6z5ApXaC.jpg_720x720q50.jpg', 54);
INSERT INTO `products` VALUES (55, 'Dây kéo nhôm bạc', 140, '2024-12-19', 4, 0, 'Dây kéo nhôm màu bạc, thiết kế chắc chắn', 1, 55, 'https://product.hstatic.net/1000058346/product/rf005_b_26ce17d650db4644ab811de7eb85d199_1024x1024.jpg', 55);
INSERT INTO `products` VALUES (56, 'Dây kéo nylon đen', 110, '2024-12-20', 4, 0, 'Dây kéo nylon màu đen, bền và linh hoạt', 1, 56, 'https://gacuoi.com/upload/product/day-keo-nylon-co-keo-dan32133.jpg', 56);
INSERT INTO `products` VALUES (57, 'Dây kéo da thật', 90, '2024-12-21', 4, 0, 'Dây kéo bằng da thật, cao cấp và bền', 1, 57, 'https://datam.vn/wp-content/uploads/2020/10/day-Khoa-keo-YKK-nhap-khau-1.jpg', 57);
INSERT INTO `products` VALUES (58, 'Dây kéo vải cotton', 160, '2024-12-22', 4, 0, 'Dây kéo vải cotton, mềm mại và chắc chắn', 1, 58, 'https://image.made-in-china.com/202f0j00SKNVdGpFlTgC/Deep-Purple-Color-Canvas-Ribbon-Belt-Bag-Sewing-Accessories-Webbings-Polyester-Cotton-Canvas-Webbing.webp', 58);
INSERT INTO `products` VALUES (59, 'Dây kéo nhựa PVC', 100, '2024-12-23', 4, 0, 'Dây kéo nhựa PVC, độ bền cao và dễ sử dụng', 1, 59, 'https://down-vn.img.susercontent.com/file/791eeb749190aa243c37dd1a168d6976', 59);
INSERT INTO `products` VALUES (60, 'Dây kéo polyester', 120, '2024-12-24', 4, 0, 'Dây kéo polyester, nhẹ và linh hoạt', 1, 60, 'https://product.hstatic.net/1000058346/product/rf002_4140ea351d8a4fc2993bd025813553d5_1024x1024.jpg', 60);
INSERT INTO `products` VALUES (61, 'Dây kéo kim loại đen', 100, '2024-12-25', 4, 0, 'Dây kéo kim loại màu đen, chất lượng cao, bền bỉ', 1, 61, 'https://product.hstatic.net/200000849833/product/z5475389802866_6d38e8f79f5c5472eff1b9f3f340a926_911402a4ef844d6b91b9a7c478dec034_large.jpg', 61);
INSERT INTO `products` VALUES (62, 'Dây kéo nhựa trong suốt', 120, '2024-12-26', 4, 0, 'Dây kéo nhựa trong suốt, nhẹ và dễ sử dụng', 1, 62, 'https://image.made-in-china.com/202f0j00wgPqzQLCnMcj/Candy-Color-Length-3-Invisible-Transparent-Close-End-Zipper-DIY-Sewing-Mesh-Dress-Skirt-Quilt-Accessories-Zipper.webp', 62);
INSERT INTO `products` VALUES (63, 'Dây kéo thép màu xám', 150, '2024-12-27', 4, 0, 'Dây kéo thép màu xám, chống rỉ sét', 1, 63, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6bYFsub5nT-Qv9lZD2GzKntcTcef4FUoh2A&s', 63);
INSERT INTO `products` VALUES (64, 'Dây kéo nhựa PVC', 130, '2024-12-28', 4, 0, 'Dây kéo nhựa PVC, chịu lực tốt, bền bỉ', 1, 64, 'https://mayhopphat.com/wp-content/uploads/2020/11/day-keo-nhua-1-min.jpg', 64);
INSERT INTO `products` VALUES (65, 'Dây kéo da thật', 110, '2024-12-29', 4, 0, 'Dây kéo da thật, mềm mại và sang trọng', 1, 65, 'https://thucphambosung.net/wp-content/uploads/2018/03/day-keo-lung-harbinger-leather-da-that.png', 65);
INSERT INTO `products` VALUES (66, 'Dây kéo vải cotton', 140, '2024-12-30', 4, 0, 'Dây kéo vải cotton, dễ sử dụng và bền', 1, 66, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSH5pzTGU7rzurQ0gnD4eG0gZNLFBiBkOCqtw&s', 66);
INSERT INTO `products` VALUES (67, 'Dây kéo nylon cứng', 120, '2024-12-31', 4, 0, 'Dây kéo nylon cứng, dẻo dai và chắc chắn', 1, 67, 'https://www.mh-chine.com/media/djcatalog2/images/item/0/5-closed-end-auto-lock-nylon-zipper-0222-1103.3_l.jpg', 67);
INSERT INTO `products` VALUES (68, 'Dây kéo nhôm', 100, '2024-12-01', 4, 0, 'Dây kéo nhôm bền, chắc chắn, không bị gỉ', 1, 68, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzqIBT8tFk_ZJEx_KzGzPrSslA7m2EEoPaeA&s', 68);
INSERT INTO `products` VALUES (69, 'Dây kéo thép không gỉ', 150, '2024-12-02', 4, 0, 'Dây kéo thép không gỉ, bền và chống ăn mòn', 1, 69, 'https://down-vn.img.susercontent.com/file/sg-11134201-22110-v0i9um98jsjv1e', 69);
INSERT INTO `products` VALUES (70, 'Dây kéo polyester', 110, '2024-12-03', 4, 0, 'Dây kéo polyester, chắc chắn và linh hoạt', 1, 70, 'https://product.hstatic.net/1000058346/product/rf002_4140ea351d8a4fc2993bd025813553d5_1024x1024.jpg', 70);
INSERT INTO `products` VALUES (71, 'Dây kéo kim loại vàng', 150, '2024-12-10', 4, 0, 'Dây kéo kim loại màu vàng, chắc chắn và bền bỉ', 1, 71, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeel84jFzedvlO4vOOaDy77kmgbWX7IJEKpw&s', 71);
INSERT INTO `products` VALUES (72, 'Dây kéo nhựa màu xanh', 130, '2024-12-11', 4, 0, 'Dây kéo nhựa màu xanh, nhẹ và dễ sử dụng', 1, 72, 'https://down-vn.img.susercontent.com/file/sg-11134201-7rcc7-lstkevoajj2t0c', 72);
INSERT INTO `products` VALUES (73, 'Dây kéo thép màu trắng', 100, '2024-12-12', 4, 0, 'Dây kéo thép màu trắng, chống rỉ sét và bền', 1, 73, 'https://down-vn.img.susercontent.com/file/48e76277aca38729c772a5eef4e2cadc', 73);
INSERT INTO `products` VALUES (74, 'Dây kéo vải dù', 140, '2024-12-13', 4, 0, 'Dây kéo vải dù, chắc chắn và bền với thời gian', 1, 74, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_L7SMYhBodgb1jxuab8afnlgrTAaEOO1Arg&s', 74);
INSERT INTO `products` VALUES (75, 'Dây kéo polyester', 120, '2024-12-14', 4, 0, 'Dây kéo polyester, dễ sử dụng và bền bỉ', 1, 75, 'https://img.lazcdn.com/g/p/0d6429c8e660f3fe438b8a60b466e3fc.jpg_720x720q80.jpg', 75);
INSERT INTO `products` VALUES (76, 'Dây kéo nhôm anodized', 110, '2024-12-15', 4, 0, 'Dây kéo nhôm anodized, không bị ăn mòn', 1, 76, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJbK1oyMP_vHboshgMYinuLkSxzZbwZo461Q&s', 76);
INSERT INTO `products` VALUES (77, 'Dây kéo thép cứng', 150, '2024-12-16', 4, 0, 'Dây kéo thép cứng, chất lượng cao và chắc chắn', 1, 77, 'https://noidia.b-cdn.net/thumbnails/764905911624.jpg', 77);
INSERT INTO `products` VALUES (78, 'Dây kéo nhựa PVC bền', 130, '2024-12-17', 4, 0, 'Dây kéo nhựa PVC bền, dễ sử dụng và chắc chắn', 1, 78, 'https://congtyvesinh24h.net/wp-content/uploads/2023/05/cach-sua-day-keo-cuc-ky-don-gian-3.jpg', 78);
INSERT INTO `products` VALUES (79, 'Dây kéo vải canvas', 100, '2024-12-18', 4, 0, 'Dây kéo vải canvas, mềm mại và bền', 1, 79, 'https://anvubag.vn/wp-content/uploads/2021/05/tui-vai-co-day-keo.jpeg', 79);
INSERT INTO `products` VALUES (80, 'Dây kéo nhựa silicone', 140, '2024-12-19', 4, 0, 'Dây kéo nhựa silicone, linh hoạt và bền bỉ', 1, 80, 'https://s.alicdn.com/@sc04/kf/Hd261563f76d147e7ba31c0b88edfc4e0Q.jpg_720x720q50.jpg', 80);
INSERT INTO `products` VALUES (81, 'Dây kéo nylon chất lượng cao', 150, '2024-12-15', 4, 0, 'Dây kéo nylon, bền bỉ, dễ sử dụng', 1, 81, 'https://kimphatlabel.com/Files/images/product/ban-khoa-keo-zipper-kimphatlabel-1.jpg', 81);
INSERT INTO `products` VALUES (82, 'Dây kéo không thấm nước', 100, '2024-12-15', 4, 0, 'Dây kéo thiết kế chống thấm nước hiệu quả', 1, 82, 'https://down-vn.img.susercontent.com/file/34b06993424358c18c814f6d67cb8b8c', 82);
INSERT INTO `products` VALUES (83, 'Dây kéo kim loại mạ bạc', 120, '2024-12-15', 4, 0, 'Dây kéo kim loại, mạ bạc, sang trọng', 1, 83, 'https://down-vn.img.susercontent.com/file/dd50ac0b5a108bc982b54e06651ca4d5', 83);
INSERT INTO `products` VALUES (84, 'Dây kéo ẩn', 80, '2024-12-15', 4, 0, 'Dây kéo ẩn, phù hợp cho thiết kế tối giản', 1, 84, 'https://www.khoakeo.com/wp-content/uploads/2019/04/Kh%C3%B3a-gi%E1%BB%8Dt-l%E1%BB%87.jpg', 84);
INSERT INTO `products` VALUES (85, 'Dây kéo hai chiều', 140, '2024-12-15', 4, 0, 'Dây kéo hai chiều tiện lợi và linh hoạt', 1, 85, 'https://down-vn.img.susercontent.com/file/sg-11134201-22100-gtbnrx8nnkivf1', 85);
INSERT INTO `products` VALUES (86, 'Dây kéo thể thao', 200, '2024-12-15', 4, 0, 'Dây kéo thiết kế cho đồ thể thao', 1, 86, 'https://cbu01.alicdn.com/img/ibank/O1CN01xOJCKo29GpkCsxLkF_!!2217696878041-0-cib.jpg', 86);
INSERT INTO `products` VALUES (87, 'Dây kéo dạ quang', 70, '2024-12-15', 4, 0, 'Dây kéo phát sáng trong bóng tối', 1, 87, 'https://down-vn.img.susercontent.com/file/sg-11134201-7rbk4-lqle1gdjixs4c3', 87);
INSERT INTO `products` VALUES (88, 'Dây kéo chống cháy', 60, '2024-12-15', 4, 0, 'Dây kéo chống cháy, an toàn sử dụng', 1, 88, 'https://s.alicdn.com/@sc04/kf/Hd8905148ff3043c7a9049370b206bbcfp.jpg_720x720q50.jpg', 88);
INSERT INTO `products` VALUES (89, 'Dây kéo siêu mỏng', 90, '2024-12-15', 4, 0, 'Dây kéo siêu mỏng, thiết kế nhẹ nhàng', 1, 89, 'https://s.alicdn.com/@sc04/kf/Hc06cb2a8293247c987b4ea49301561b1L.jpg_720x720q50.jpg', 89);
INSERT INTO `products` VALUES (90, 'Dây kéo cổ điển', 110, '2024-12-15', 4, 0, 'Dây kéo thiết kế cổ điển, dễ phối hợp', 1, 90, 'https://media.loveitopcdn.com/6535/thumb/369700854-698700278962953-3946737896695593481-n-2.jpg', 90);
INSERT INTO `products` VALUES (91, 'Dây kéo nhựa đa năng', 130, '2024-12-15', 4, 0, 'Dây kéo nhựa đa năng, phù hợp cho nhiều ứng dụng', 1, 91, 'https://down-vn.img.susercontent.com/file/sg-11134201-7rd64-lulpaljre455d3', 91);
INSERT INTO `products` VALUES (92, 'Dây kéo tự động khóa', 75, '2024-12-15', 4, 0, 'Dây kéo có cơ chế tự động khóa chắc chắn', 1, 92, 'https://down-vn.img.susercontent.com/file/6e46ec20136540a83b54921bf62ce930', 92);
INSERT INTO `products` VALUES (93, 'Dây kéo nhẹ và bền', 85, '2024-12-15', 4, 0, 'Dây kéo siêu nhẹ và bền chắc', 1, 93, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4oYyd4LIMQyFx0oTYx7mz0exxnSerTBjVeQ&s', 93);
INSERT INTO `products` VALUES (94, 'Dây kéo cho vali', 150, '2024-12-15', 4, 0, 'Dây kéo thiết kế chuyên dụng cho vali', 1, 94, 'https://topbag.vn/media/images/full/san-pham/sua-vali-keo/phu-kien-vali-khac/dau-khoa-so-8-vali-khoa-chim/dau-keo-khoa-so-8-cho-vali-khoa-chim-3.jpg', 94);
INSERT INTO `products` VALUES (95, 'Dây kéo dành cho túi xách', 120, '2024-12-15', 4, 0, 'Dây kéo nhẹ, bền dành riêng cho túi xách', 1, 95, 'https://bazaarvietnam.vn/wp-content/uploads/2021/01/lich-su-day-khoa-keo-louis-vuitton.jpg', 95);
INSERT INTO `products` VALUES (96, 'Dây kéo cao cấp', 50, '2024-12-15', 4, 0, 'Dây kéo với chất lượng vượt trội', 1, 96, 'https://phukienlamdoda.com/wp-content/uploads/2019/09/636937420835974258c5342-510x505-1-1.jpg', 96);
INSERT INTO `products` VALUES (97, 'Dây kéo không rỉ sét', 110, '2024-12-15', 4, 0, 'Dây kéo chống rỉ sét bền lâu', 1, 97, 'https://down-vn.img.susercontent.com/file/sg-11134201-22110-v0i9um98jsjv1e', 97);
INSERT INTO `products` VALUES (98, 'Dây kéo chống bụi', 130, '2024-12-15', 4, 0, 'Dây kéo với thiết kế chống bụi hiệu quả', 1, 98, 'https://haihongplastic.com/img_data/images/4.5-cm-(45)191939880982.png', 98);
INSERT INTO `products` VALUES (99, 'Dây kéo chuyên dụng cho giày', 70, '2024-12-15', 4, 0, 'Dây kéo chuyên dụng, dễ sử dụng cho giày', 1, 99, 'https://chuyendophuot.com/wp-content/uploads/2024/02/Do-Day-Keo-Zip-Giay-Da-Boots-ChuyenDoPhuot.com_-scaled.jpg', 99);
INSERT INTO `products` VALUES (100, 'Dây kéo thời trang', 90, '2024-12-15', 4, 0, 'Dây kéo với kiểu dáng thời trang hiện đại', 1, 100, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lmmr45l5flcv00', 100);
INSERT INTO `products` VALUES (101, 'Vải bông', 100, '2024-01-01', 1, 1, 'Vải bông mềm mại, dễ thấm hút mồ hôi', 1, 101, 'https://down-vn.img.susercontent.com/file/114dcf2c854535babee300408fad2377.webp', 101);
INSERT INTO `products` VALUES (102, 'Vải lanh', 120, '2024-01-02', 1, 1, 'Vải lanh thoáng mát, nhẹ nhàng', 1, 102, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lvbsc8nsqwzx42.webp', 102);
INSERT INTO `products` VALUES (103, 'Lụa', 50, '2024-01-03', 1, 1, 'Vải lụa mềm mại, bóng đẹp', 1, 103, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lykohc95o0pta8.webp', 103);
INSERT INTO `products` VALUES (104, 'Len', 200, '2024-01-04', 1, 1, 'Vải len dày, ấm áp', 1, 104, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lo7tmuvh1ipjd5.webp', 104);
INSERT INTO `products` VALUES (105, 'Polyester', 300, '2024-01-05', 1, 1, 'Vải polyester bền, không bị nhăn', 1, 105, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3SqNSPU0WFNCCMCOJUEiuY-GI9hka1L4TUg&s', 105);
INSERT INTO `products` VALUES (106, 'Nilon', 150, '2024-01-06', 1, 1, 'Vải nilon nhẹ, chống thấm nước', 1, 106, 'https://everon.com/upload/upload-images/vai-nilon-1.jpg', 106);
INSERT INTO `products` VALUES (107, 'Vải bò (Denim)', 62, '2024-01-07', 1, 1, 'Vải bò chắc chắn, thời trang', 1, 107, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2clZyyyzwUD0BL2XV75gQTj-xklzd-1QSow&s', 107);
INSERT INTO `products` VALUES (108, 'Vải satin', 90, '2024-01-08', 1, 1, 'Vải satin mềm mại, bóng mượt', 1, 108, 'https://cdn.shopify.com/s/files/1/0428/4219/4071/files/vai-satin.jpg?v=1699784134', 108);
INSERT INTO `products` VALUES (109, 'Vải nhung', 60, '2024-01-09', 1, 1, 'Vải nhung êm ái, sang trọng', 1, 109, 'https://thanhtungtextile.vn/upload/trang-san-pham/vai-nhung-tuyet/gia-vai-nhung-tuyet1-inkjpeg.jpeg', 109);
INSERT INTO `products` VALUES (110, 'Vải chiffon', 110, '2024-01-10', 1, 1, 'Vải chiffon mỏng manh, nhẹ nhàng', 1, 110, 'https://file.hstatic.net/1000058447/article/vai_chiffon_182d2caaadf64696b63c7c207f6747bc.jpg', 110);
INSERT INTO `products` VALUES (111, 'Vải taffeta', 130, '2024-01-11', 1, 1, 'Vải taffeta bóng, cứng cáp', 1, 111, 'https://vaiphelieu.com/wp-content/uploads/2023/06/thanh-phan-vai.png', 111);
INSERT INTO `products` VALUES (112, 'Vải voan', 140, '2024-01-12', 1, 1, 'Vải voan mỏng, nhẹ nhàng', 1, 112, 'https://ru9.vn/cdn/shop/articles/vai-voan-lua.jpg?v=1699787986', 112);
INSERT INTO `products` VALUES (113, 'Vải nỉ (Fleece)', 150, '2024-01-13', 1, 1, 'Vải nỉ ấm áp, thích hợp mùa đông', 1, 113, 'https://vaini.com.vn/upload/product/903808708294.jpg', 113);
INSERT INTO `products` VALUES (114, 'Vải flannel', 160, '2024-01-14', 1, 1, 'Vải flannel dày, mềm', 1, 114, 'https://5sfashion.vn/storage/upload/images/ckeditor/7OumYTOMj7NAgvY6hYwMoE5LksWO48cikfe6JyZo.jpg', 114);
INSERT INTO `products` VALUES (115, 'Vải nhung kẻ (Corduroy)', 100, '2024-01-15', 1, 1, 'Vải nhung kẻ, sang trọng', 1, 115, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSD4f3UsAeS1quM4k4a5OmQcucV7m_Y1neQg&s', 115);
INSERT INTO `products` VALUES (116, 'Da lộn (Suede)', 50, '2024-01-16', 1, 1, 'Vải da lộn mềm mịn, cao cấp', 1, 116, 'https://file.hstatic.net/200000536779/file/da_lon_c5b2245301d9458ea96e5a81f0f404fe_1024x1024.jpg', 116);
INSERT INTO `products` VALUES (117, 'Da (Leather)', 70, '2024-01-17', 1, 1, 'Vải da bền, chắc chắn', 1, 117, 'https://cdn.shopify.com/s/files/1/0583/3690/3348/files/cac-loai-da-leather-duoc-ua-chuong.jpg?v=1720623940', 117);
INSERT INTO `products` VALUES (118, 'Vải cashmere', 40, '2024-01-18', 1, 1, 'Vải cashmere ấm áp, mềm mại', 1, 118, 'https://thanhtungtextile.vn/upload/trang-san-pham/vai-au/vai-cashmere-cao-cap-may-quan-tay-may-vest/vai-cashmere-cao-cap-may-quan-tay-may-vest-3-inkjpeg.jpeg', 118);
INSERT INTO `products` VALUES (119, 'Vải brocade', 30, '2024-01-19', 1, 1, 'Vải brocade thêu hoa văn sang trọng', 1, 119, 'https://city89.com/wp-content/uploads/2023/03/vai-brocade-la-gi-1.jpg', 119);
INSERT INTO `products` VALUES (120, 'Vải jersey', 200, '2024-01-20', 1, 1, 'Vải jersey co giãn, thoải mái', 1, 120, 'https://mialala.vn/media/lib/07-07-2023/mialala-vijersey1.jpg', 120);
INSERT INTO `products` VALUES (121, 'Vải tweed', 90, '2024-01-21', 1, 1, 'Vải tweed dày, bền', 1, 121, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSR637f-fHZeLt4Xr2J2lGHkaeZ7A3LH5udpg&s', 121);
INSERT INTO `products` VALUES (122, 'Vải gabardine', 110, '2024-01-22', 1, 1, 'Vải gabardine bền, chống nhăn', 1, 122, 'https://5sfashion.vn/storage/upload/images/ckeditor/VAcYsZWvgTQk7jen44OxzNet08IY5umMCLq2o30P.jpg', 122);
INSERT INTO `products` VALUES (123, 'Vải organza', 80, '2024-01-23', 1, 1, 'Vải organza mỏng, trong suốt', 1, 123, 'https://5sfashion.vn/storage/upload/images/ckeditor/bwwfXZXN9pzGmcpU2PCIye45RZ30EuzpbBvwO932.jpg', 123);
INSERT INTO `products` VALUES (124, 'Vải houndstooth', 90, '2024-01-24', 1, 1, 'Vải houndstooth họa tiết kẻ sọc', 1, 124, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjonpot-P1meQnIiZdRncYxrIR5fXgjsPfYg&s', 124);
INSERT INTO `products` VALUES (125, 'Vải georgette', 150, '2024-01-25', 1, 1, 'Vải georgette mềm mại', 1, 125, 'https://pubcdn.ivymoda.com/files/news/2024/05/13/521f46e65515d503e34420e9ee05c554.jpg', 125);
INSERT INTO `products` VALUES (126, 'Vải peachskin', 130, '2024-01-26', 1, 1, 'Vải peachskin mịn màng, nhẹ', 1, 126, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsfr7OhkJE05zCM3UHfbP9zHmvglG7D0-aMA&s', 126);
INSERT INTO `products` VALUES (127, 'Vải spandex', 160, '2024-01-27', 1, 1, 'Vải spandex co giãn, ôm sát', 1, 127, 'https://file.hstatic.net/200000775589/article/cotton-spandex__2__3c5f9e1f611940249168b38f4508565d_grande.jpg', 127);
INSERT INTO `products` VALUES (128, 'Vải lycra', 200, '2024-01-28', 1, 1, 'Vải lycra co giãn, thoải mái', 1, 128, 'https://gianphoihoaphat.vn/uploads/images/6466ee8aad2db625237485a5/vai-lycra-5.webp', 128);
INSERT INTO `products` VALUES (129, 'Vải rayon', 179, '2024-01-29', 1, 1, 'Vải rayon nhẹ, thoáng mát', 1, 129, 'https://pubcdn.ivymoda.com/files/news/2024/04/15/0f79bfb1d0df4a7988aacfc2149cf351.jpg', 129);
INSERT INTO `products` VALUES (130, 'Vải viscose', 120, '2024-01-30', 1, 1, 'Vải viscose mềm, dễ mặc', 1, 130, 'https://onoff.vn/blog/wp-content/uploads/2022/12/vai-viscose-la-gi-7.jpg', 130);
INSERT INTO `products` VALUES (131, 'Vải canvas', 90, '2024-01-31', 1, 1, 'Vải canvas dày, chắc chắn', 1, 131, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSm9JtkC3ZKHFQyXVN8gP9VzWfJ6HCBLTzPQA&s', 131);
INSERT INTO `products` VALUES (132, 'Vải muslin', 50, '2024-02-01', 1, 1, 'Vải muslin mỏng, nhẹ', 1, 132, 'https://file.hstatic.net/1000165376/file/1_6f9e933e2a66418ebc00614132fc1578_grande.jpeg', 132);
INSERT INTO `products` VALUES (133, 'Vải thô (Burlap)', 60, '2024-02-02', 1, 1, 'Vải thô cứng, bền', 1, 133, 'https://tuivaibohcm.com/wp-content/uploads/2018/08/su-dung-vai-bo-tho-300x200.jpg', 133);
INSERT INTO `products` VALUES (134, 'Vải chambray', 80, '2024-02-03', 1, 1, 'Vải chambray mềm mại', 1, 134, 'https://pubcdn.ivymoda.com/files/news/2024/05/10/37faf5a3c2704a6783f4ec514284352f.jpg', 134);
INSERT INTO `products` VALUES (135, 'Vải shantung', 50, '2024-02-04', 1, 1, 'Vải shantung cứng, bóng', 1, 135, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq-VmBWGB5K7vY-vrE5V821Q2loEBQMzPJHg&s', 135);
INSERT INTO `products` VALUES (136, 'Vải moleskin', 38, '2024-02-05', 1, 1, 'Vải moleskin mềm mịn', 1, 136, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOrXvQxuXodqjRgd3alHHYRIXpc823YJ8cMQ&s', 136);
INSERT INTO `products` VALUES (137, 'Vải seersucker', 120, '2024-02-06', 1, 1, 'Vải seersucker nhẹ, co giãn', 1, 137, 'https://phulieuthanhphong.vn/upload/news/vai-seersuck-76703-1322.jpg', 137);
INSERT INTO `products` VALUES (138, 'Vải in sáp (Wax Print)', 80, '2024-02-07', 1, 1, 'Vải in sáp họa tiết sắc nét', 1, 138, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSH8vs8Tj-ie958tSSjuPOCbNdAO8wTLivH6Q&s', 138);
INSERT INTO `products` VALUES (139, 'Denim co giãn (Stretch Denim)', 150, '2024-02-08', 1, 1, 'Denim co giãn, dễ mặc', 1, 139, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRy9ldiENmsEXvqsD5WBhVbqgplj9zB2FhjJw&s', 139);
INSERT INTO `products` VALUES (140, 'Vải tulle', 130, '2024-02-09', 1, 1, 'Vải tulle mỏng, nhẹ', 1, 140, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAZqNQmnLFWvdX1FbckyXDA161hd9v5EAGLg&s', 140);
INSERT INTO `products` VALUES (141, 'Vải taffeta bóng', 110, '2024-02-10', 1, 1, 'Vải taffeta bóng, chắc chắn', 1, 141, 'https://down-vn.img.susercontent.com/file/9d4d1775a805c1bf545f5114437ad54f', 141);
INSERT INTO `products` VALUES (142, 'Vải boucle', 90, '2024-02-11', 1, 1, 'Vải boucle mềm, bền', 1, 142, 'https://homeoffice.com.vn/images/companies/1/baiviet/2023/vai-boucle-la-gi/cac-loai-vai-boucle-dep-mat.jpg?1701162607373', 142);
INSERT INTO `products` VALUES (143, 'Vải herringbone', 80, '2024-02-12', 1, 1, 'Vải herringbone với họa tiết xương cá', 1, 143, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGL7AAPyeuBcjioDiwI3OIOdyY0ppP--xQ8g&s', 143);
INSERT INTO `products` VALUES (144, 'Vải kaki', 120, '2024-02-13', 1, 1, 'Vải khaki bền, chắc chắn', 1, 144, 'https://xuongmayaodongphuc.vn/wp-content/uploads/2023/09/vai-kaki-la-gi.jpg', 144);
INSERT INTO `products` VALUES (145, 'Vải oxford', 100, '2024-02-14', 1, 1, 'Vải oxford dày, thoáng khí', 1, 145, 'https://canifa.com/blog/wp-content/uploads/2024/08/vai-oxford-1.webp', 145);
INSERT INTO `products` VALUES (146, 'Vải pique', 134, '2024-02-15', 1, 1, 'Vải pique bền, có cấu trúc', 1, 146, 'https://cdn.shopify.com/s/files/1/0681/2821/1221/files/kham-pha-nhung-dac-tinh-vuot-troi-cua-vai-pique_480x480.jpg?v=1698295661', 146);
INSERT INTO `products` VALUES (147, 'Vải gabardine co giãn', 180, '2024-02-16', 1, 1, 'Vải gabardine co giãn, dễ di chuyển', 1, 147, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTthzEXN5-jNVWDJDYXnqZuZepWhT4bmjlEdQ&s', 147);
INSERT INTO `products` VALUES (148, 'Vải spandex satin', 130, '2024-02-17', 1, 1, 'Vải spandex satin có độ bóng', 1, 148, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSewoakbNc6KC4UWMcnkNzz2iZiBPQEfhUKtA&s', 148);
INSERT INTO `products` VALUES (149, 'Vải linen', 140, '2024-02-18', 1, 1, 'Vải linen mát mẻ, thoáng khí', 1, 149, 'https://cdn.shopify.com/s/files/1/0681/2821/1221/files/vai-linen-la-gi_480x480.png?v=1698205716', 149);
INSERT INTO `products` VALUES (150, 'Vải nylon', 88, '2024-09-17', 1, 1, 'Vải nylon mát mẻ cho mùa hè của bạn', 1, 150, 'https://bizweb.dktcdn.net/thumb/grande/100/168/179/files/huong-dan-phan-biet-vali-vai-polyester-va-vai-nylon-3-jpg.jpg?v=1525017213403', 150);
INSERT INTO `products` VALUES (151, 'Vải gấm cao cấp', 50, '2024-07-01', 3, 1, 'Vải gấm cao cấp, thích hợp cho rèm cửa và trang trí nội thất.', 1, 151, 'https://product.hstatic.net/1000209173/product/357477227_664815889020749_5326874058597378898_n_f7d72b53f6c4490bb113bf014f982e45_master.jpg', 151);
INSERT INTO `products` VALUES (152, 'Vải linen tự nhiên', 35, '2024-07-02', 3, 1, 'Vải linen tự nhiên, thoáng mát, lý tưởng cho ghế sofa và gối.', 1, 152, 'https://file.hstatic.net/200000887901/file/vai-linen-la-gi-6.jpg', 152);
INSERT INTO `products` VALUES (153, 'Vải thun cotton', 60, '2024-07-03', 3, 1, 'Vải cotton mềm mại, dễ chịu, sử dụng cho thảm và các vật dụng trang trí.', 1, 153, 'https://vaithunthethaosaigon.com/uploadwb/hinhsp/vai_thun_gan_12638202074810_b_.jpg', 153);
INSERT INTO `products` VALUES (154, 'Vải bố', 45, '2024-07-04', 3, 1, 'Vải bố dày, lý tưởng cho thảm trải sàn và ghế sofa.', 1, 154, 'https://cdn.shopify.com/s/files/1/0681/2821/1221/files/71_3bc7a8a9-4f27-4832-8823-d8d57f845410_480x480.jpg?v=1698328246', 154);
INSERT INTO `products` VALUES (155, 'Vải gấm', 30, '2024-07-05', 3, 1, 'Vải gấm sang trọng, dùng cho rèm cửa và gối ném.', 1, 155, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJrQciHNldxljKM3iaRI4YCo-VovbZVY552g&s', 155);
INSERT INTO `products` VALUES (156, 'Vải nhung', 50, '2024-07-06', 3, 1, 'Vải nhung mềm mại, sang trọng, sử dụng cho ghế bành và gối ném.', 1, 156, 'https://thanhtungtextile.vn/upload/trang-san-pham/vai-nhung-tuyet/gia-vai-nhung-tuyet1-inkjpeg.jpeg', 156);
INSERT INTO `products` VALUES (157, 'Vải lụa', 40, '2024-07-07', 3, 1, 'Vải lụa mịn màng, lý tưởng cho rèm cửa và các đồ trang trí cao cấp.', 1, 157, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS03zzcmjbPsGoLJ6uFnH4RJXY6pm5i2w1fTg&s', 157);
INSERT INTO `products` VALUES (158, 'Vải bông', 50, '2024-07-08', 3, 1, 'Vải bông dễ dàng vệ sinh, dùng cho ghế sofa và thảm.', 1, 158, 'https://pubcdn.ivymoda.com/files/news/2024/04/09/582365205dcd1ecd020eaf1c253c3e68.jpg', 158);
INSERT INTO `products` VALUES (159, 'Vải thun', 35, '2024-07-09', 3, 1, 'Vải thun co giãn, lý tưởng cho các đồ trang trí nội thất.', 1, 159, 'https://detkimkienhoa.com/wp-content/uploads/2023/09/vai-thun-la-gi.jpg', 159);
INSERT INTO `products` VALUES (160, 'Vải gấm', 40, '2024-07-10', 3, 1, 'Vải gấm sang trọng, thích hợp cho rèm cửa và trang trí sang trọng.', 1, 160, 'https://winart.vn/wp-content/uploads/2023/10/vai-gam-la-gi-1.jpg', 160);
INSERT INTO `products` VALUES (161, 'Vải thun', 60, '2024-07-11', 3, 1, 'Vải thun dễ chịu, mềm mại, lý tưởng cho các món đồ trang trí phòng ngủ.', 1, 161, 'https://demxanh.com/media/news/0510_vai-thun-secxay.jpg', 161);
INSERT INTO `products` VALUES (162, 'Vải lanh', 30, '2024-07-12', 3, 1, 'Vải lanh mát mẻ, sử dụng cho thảm trải sàn và rèm cửa.', 1, 162, 'https://handyuni.vn/wp-content/uploads/2024/04/vai-lanh.jpg', 162);
INSERT INTO `products` VALUES (163, 'Vải bố', 55, '2024-07-13', 3, 1, 'Vải bố bền chắc, thích hợp cho ghế sofa và các sản phẩm trang trí.', 1, 163, 'https://cdn.shopify.com/s/files/1/0681/2821/1221/files/71_3bc7a8a9-4f27-4832-8823-d8d57f845410_480x480.jpg?v=1698328246', 163);
INSERT INTO `products` VALUES (164, 'Vải len', 45, '2024-07-14', 3, 1, 'Vải len mềm mại, lý tưởng cho chăn và gối.', 1, 164, 'https://everon.com/upload/upload-images/vai-len-3.jpg', 164);
INSERT INTO `products` VALUES (165, 'Vải cotton', 60, '2024-07-15', 3, 1, 'Vải cotton thấm hút tốt, sử dụng cho các vật dụng trang trí trong nhà.', 1, 165, 'https://invaihoaanhdao.com/wp-content/uploads/2021/08/Vai-cotton-1.jpg', 165);
INSERT INTO `products` VALUES (166, 'Vải taffeta', 50, '2024-07-16', 3, 1, 'Vải taffeta bóng, phù hợp với các sản phẩm trang trí cao cấp.', 1, 166, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoQuHOcXV2-6nus_XzPhP7lQOR2GAOpDuj0A&s', 166);
INSERT INTO `products` VALUES (167, 'Vải spandex', 40, '2024-07-17', 3, 1, 'Vải spandex co giãn, lý tưởng cho các món đồ trang trí hiện đại.', 1, 167, 'https://file.hstatic.net/200000775589/article/cotton-spandex__2__3c5f9e1f611940249168b38f4508565d_grande.jpg', 167);
INSERT INTO `products` VALUES (168, 'Vải dạ', 35, '2024-07-18', 3, 1, 'Vải dạ ấm áp, dùng cho các sản phẩm như gối và chăn.', 1, 168, 'https://bizweb.dktcdn.net/100/276/730/files/vai-2.jpg?v=1545036785238', 168);
INSERT INTO `products` VALUES (169, 'Vải satin', 30, '2024-07-19', 3, 1, 'Vải satin bóng mượt, lý tưởng cho rèm cửa và các đồ trang trí sang trọng.', 1, 169, 'https://demxanh.com/media/news/2002_nguon-goc-vai-satin.jpg', 169);
INSERT INTO `products` VALUES (170, 'Vải thô', 40, '2024-07-20', 3, 1, 'Vải thô dày dặn, phù hợp cho các vật dụng trang trí nội thất.', 1, 170, 'https://bizweb.dktcdn.net/100/320/888/files/vai-tho-1.jpg?v=1678075834809', 170);
INSERT INTO `products` VALUES (171, 'Vải Tulle', 50, '2024-12-10', 3, 1, 'Vải tulle mềm mại, thích hợp cho rèm cửa và gối trang trí.', 1, 171, 'https://oneyard.shop/uploads/product/3/9/39088/fairytale-velvet-polka-dotted-tulle-fabric-by-the-yard.webp', 171);
INSERT INTO `products` VALUES (172, 'Vải Sợi Tổng Hợp', 60, '2024-12-12', 3, 1, 'Vải sợi tổng hợp bền đẹp, thường dùng trong các chi tiết trang trí nhẹ.', 1, 172, 'https://5sfashion.vn/storage/upload/images/posts/SCn9e1YHUXDfpqO07eI6DVqItBTmwuE8wDHZ5Wk3.jpg', 172);
INSERT INTO `products` VALUES (173, 'Vải Chéo', 40, '2024-11-28', 3, 1, 'Vải chéo bền chắc, dùng cho ghế sofa và rèm cửa.', 1, 173, 'https://leika.vn/wp-content/uploads/2023/04/vai-cheo-la-vai-gi-1-510x340.jpg', 173);
INSERT INTO `products` VALUES (174, 'Vải Bọc Đệm', 30, '2024-11-30', 3, 1, 'Vải bọc đệm chất lượng cao, chuyên dùng cho ghế và sofa.', 1, 174, 'https://bocghesofahanoi.com/wp-content/uploads/2020/04/mau-vai-tho-tm-02-boc-sofa-dem-ghe-1-e1586860890490.jpg', 174);
INSERT INTO `products` VALUES (175, 'Vải Sợi Bông', 55, '2024-12-05', 3, 1, 'Vải sợi bông tự nhiên, thích hợp cho thảm và gối trang trí.', 1, 175, 'https://pubcdn.ivymoda.com/files/news/2024/04/09/582365205dcd1ecd020eaf1c253c3e68.jpg', 175);
INSERT INTO `products` VALUES (176, 'Vải Lót Chăn', 45, '2024-12-03', 3, 1, 'Vải lót chăn mềm mại, dùng cho các loại chăn, đệm trang trí.', 1, 176, 'https://hethongnem.com/wp-content/uploads/2022/08/vai-lot-la-gi-1.jpg', 176);
INSERT INTO `products` VALUES (177, 'Vải Thảm Da', 20, '2024-11-25', 3, 1, 'Vải thảm da sang trọng, dùng cho các thảm trang trí nội thất cao cấp.', 1, 177, 'https://product.hstatic.net/200000057508/product/d45031cb6e52960ccf43_74ab42274e0841ef91373aed098ecd3b.jpg', 177);
INSERT INTO `products` VALUES (178, 'Vải Thảm Len', 50, '2024-12-01', 3, 1, 'Vải thảm len bền đẹp, dùng cho thảm trang trí nội thất.', 1, 178, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaGKDYEUCwMYssTa6rKTlYrvejESBxRMJeHA&s', 178);
INSERT INTO `products` VALUES (179, 'Vải Sợi Bông Dệt Thô', 35, '2024-11-18', 3, 1, 'Vải sợi bông dệt thô, thích hợp cho các chi tiết trang trí nhẹ nhàng.', 1, 179, 'https://detkimkienhoa.com/wp-content/uploads/2023/10/vai-soi-bong.jpg', 179);
INSERT INTO `products` VALUES (180, 'Vải Cotton Pha Polyester', 60, '2024-12-07', 3, 1, 'Vải cotton pha polyester, thường dùng cho gối và rèm cửa.', 1, 180, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlFKSjPPT9BI3ILhYcv2bAdlCMh9Xfb03gLw&s', 180);
INSERT INTO `products` VALUES (181, 'Vaixx', 1000, '2025-05-26', 2, 1, 'Vải lụa mịn màng, lý tưởng cho rèm cửa và các đồ trang trí cao cấp.', 1, 181, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS03zzcmjbPsGoLJ6uFnH4RJXY6pm5i2w1fTg&s', 181);

-- ----------------------------
-- Table structure for styles
-- ----------------------------
DROP TABLE IF EXISTS `styles`;
CREATE TABLE `styles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idProduct` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idProduct`(`idProduct`) USING BTREE,
  CONSTRAINT `styles_ibfk_1` FOREIGN KEY (`idProduct`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 444 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of styles
-- ----------------------------
INSERT INTO `styles` VALUES (1, 1, 'Đỏ', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 19);
INSERT INTO `styles` VALUES (2, 1, 'Xanh lá', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 30);
INSERT INTO `styles` VALUES (3, 1, 'Xanh dương', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-button-color-png-image_6659249.png', 25);
INSERT INTO `styles` VALUES (4, 1, 'Vàng', 'https://imagescdn.gettyimagesbank.com/500/18/576/189/0/915398046.jpg', 25);
INSERT INTO `styles` VALUES (5, 2, 'Đen', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-button-black-png-image_9051705.png', 39);
INSERT INTO `styles` VALUES (6, 2, 'Trắng', 'https://vn-test-11.slatic.net/p/fcdf322e0ab350add3236ad58cd88bb1.jpg', 35);
INSERT INTO `styles` VALUES (7, 2, 'Nâu', 'https://img.lazcdn.com/g/p/0085e2e62aa7aa80160794a3bd2b0838.jpg_720x720q80.jpg', 30);
INSERT INTO `styles` VALUES (8, 2, 'Xám', 'https://pic.trangvangvietnam.com/395715081/1482139430_11.jpg', 25);
INSERT INTO `styles` VALUES (9, 3, 'Cam', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-button-color-orange-yellow-png-image_6659251.png', 20);
INSERT INTO `styles` VALUES (10, 3, 'Tím', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-purple-png-image_6659253.png', 25);
INSERT INTO `styles` VALUES (11, 3, 'Hồng', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-pink-png-image_6659252.png', 20);
INSERT INTO `styles` VALUES (12, 3, 'Xanh biển', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 35);
INSERT INTO `styles` VALUES (13, 4, 'Vàng nhạt', 'https://imagescdn.gettyimagesbank.com/500/18/576/189/0/915398046.jpg', 30);
INSERT INTO `styles` VALUES (14, 4, 'Đỏ đô', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 25);
INSERT INTO `styles` VALUES (15, 4, 'Xanh đậm', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 20);
INSERT INTO `styles` VALUES (16, 4, 'Trắng sữa', 'https://vn-test-11.slatic.net/p/fcdf322e0ab350add3236ad58cd88bb1.jpg', 25);
INSERT INTO `styles` VALUES (17, 5, 'Nâu đất', 'https://img.lazcdn.com/g/p/0085e2e62aa7aa80160794a3bd2b0838.jpg_720x720q80.jpg', 20);
INSERT INTO `styles` VALUES (18, 5, 'Xanh ngọc', 'https://image.made-in-china.com/2f0j00UBItLwqcbAYP/Best-Quality-Best-Price-Garment-Shirt-Button-14L-40L.webp', 25);
INSERT INTO `styles` VALUES (19, 5, 'Đỏ gạch', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 30);
INSERT INTO `styles` VALUES (20, 5, 'Xanh pastel', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 35);
INSERT INTO `styles` VALUES (21, 6, 'Hồng nhạt', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-pink-png-image_6659252.png', 20);
INSERT INTO `styles` VALUES (22, 6, 'Xanh olive', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 25);
INSERT INTO `styles` VALUES (23, 6, 'Xám đậm', 'https://pic.trangvangvietnam.com/395715081/1482139430_11.jpg', 25);
INSERT INTO `styles` VALUES (24, 6, 'Vàng đồng', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 30);
INSERT INTO `styles` VALUES (25, 7, 'Xanh trời', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 20);
INSERT INTO `styles` VALUES (26, 7, 'Đen tuyền', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-button-black-png-image_9051705.png', 35);
INSERT INTO `styles` VALUES (27, 7, 'Xanh rêu', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 30);
INSERT INTO `styles` VALUES (28, 7, 'Hồng đào', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-pink-png-image_6659252.png', 25);
INSERT INTO `styles` VALUES (29, 8, 'Nâu sáng', 'https://img.lazcdn.com/g/p/0085e2e62aa7aa80160794a3bd2b0838.jpg_720x720q80.jpg', 40);
INSERT INTO `styles` VALUES (30, 8, 'Trắng kem', 'https://vn-test-11.slatic.net/p/fcdf322e0ab350add3236ad58cd88bb1.jpg', 35);
INSERT INTO `styles` VALUES (31, 8, 'Xanh lá mạ', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 30);
INSERT INTO `styles` VALUES (32, 8, 'Đỏ cherry', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 25);
INSERT INTO `styles` VALUES (33, 9, 'Cam sáng', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-button-color-orange-yellow-png-image_6659251.png', 20);
INSERT INTO `styles` VALUES (34, 9, 'Xám khói', 'https://pic.trangvangvietnam.com/395715081/1482139430_11.jpg', 25);
INSERT INTO `styles` VALUES (35, 9, 'Xanh cổ vịt', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 30);
INSERT INTO `styles` VALUES (36, 9, 'Tím nhạt', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-purple-png-image_6659253.png', 25);
INSERT INTO `styles` VALUES (37, 10, 'Đỏ ánh kim', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 20);
INSERT INTO `styles` VALUES (38, 10, 'Xanh sapphire', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 30);
INSERT INTO `styles` VALUES (39, 10, 'Nâu đồng', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 35);
INSERT INTO `styles` VALUES (40, 10, 'Trắng bạch kim', 'https://down-vn.img.susercontent.com/file/c5ac1e24bd8e1fa7476491dea2f0f06a', 25);
INSERT INTO `styles` VALUES (41, 11, 'Xanh cốm', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 30);
INSERT INTO `styles` VALUES (42, 11, 'Đỏ ruby', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 20);
INSERT INTO `styles` VALUES (43, 11, 'Hồng phấn', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-pink-png-image_6659252.png', 25);
INSERT INTO `styles` VALUES (44, 11, 'Trắng tuyết', 'https://vn-test-11.slatic.net/p/fcdf322e0ab350add3236ad58cd88bb1.jpg', 20);
INSERT INTO `styles` VALUES (45, 12, 'Vàng nắng', 'https://imagescdn.gettyimagesbank.com/500/18/576/189/0/915398046.jpg', 35);
INSERT INTO `styles` VALUES (46, 12, 'Xanh lá cây', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 25);
INSERT INTO `styles` VALUES (47, 12, 'Tím hoa cà', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-purple-png-image_6659253.png', 20);
INSERT INTO `styles` VALUES (48, 12, 'Nâu cà phê', 'https://img.lazcdn.com/g/p/0085e2e62aa7aa80160794a3bd2b0838.jpg_720x720q80.jpg', 30);
INSERT INTO `styles` VALUES (49, 13, 'Xám bạc', 'https://down-vn.img.susercontent.com/file/c5ac1e24bd8e1fa7476491dea2f0f06a', 25);
INSERT INTO `styles` VALUES (50, 13, 'Đen ánh than', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-button-black-png-image_9051705.png', 20);
INSERT INTO `styles` VALUES (51, 13, 'Vàng đất', 'https://imagescdn.gettyimagesbank.com/500/18/576/189/0/915398046.jpg', 35);
INSERT INTO `styles` VALUES (52, 13, 'Xanh ngọc lục bảo', 'https://image.made-in-china.com/2f0j00UBItLwqcbAYP/Best-Quality-Best-Price-Garment-Shirt-Button-14L-40L.webp', 25);
INSERT INTO `styles` VALUES (53, 14, 'Cam cháy', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-button-color-orange-yellow-png-image_6659251.png', 20);
INSERT INTO `styles` VALUES (54, 14, 'Tím than', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-purple-png-image_6659253.png', 25);
INSERT INTO `styles` VALUES (55, 14, 'Xanh lam', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 30);
INSERT INTO `styles` VALUES (56, 14, 'Đỏ thẫm', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 35);
INSERT INTO `styles` VALUES (57, 15, 'Hồng san hô', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-pink-png-image_6659252.png', 20);
INSERT INTO `styles` VALUES (58, 15, 'Xanh lá mạ', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 30);
INSERT INTO `styles` VALUES (59, 15, 'Nâu đỏ', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 25);
INSERT INTO `styles` VALUES (60, 15, 'Xám nhạt', 'https://pic.trangvangvietnam.com/395715081/1482139430_11.jpg', 35);
INSERT INTO `styles` VALUES (61, 16, 'Vàng nghệ', 'https://imagescdn.gettyimagesbank.com/500/18/576/189/0/915398046.jpg', 20);
INSERT INTO `styles` VALUES (62, 16, 'Tím pastel', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-purple-png-image_6659253.png', 25);
INSERT INTO `styles` VALUES (63, 16, 'Xanh xám', 'https://pic.trangvangvietnam.com/395715081/1482139430_11.jpg', 30);
INSERT INTO `styles` VALUES (64, 16, 'Hồng đào nhạt', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-pink-png-image_6659252.png', 25);
INSERT INTO `styles` VALUES (65, 17, 'Xanh biển đậm', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 20);
INSERT INTO `styles` VALUES (66, 17, 'Đen nhung', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-button-black-png-image_9051705.png', 25);
INSERT INTO `styles` VALUES (67, 17, 'Vàng cam', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-button-color-orange-yellow-png-image_6659251.png', 30);
INSERT INTO `styles` VALUES (68, 17, 'Nâu vàng', 'https://img.lazcdn.com/g/p/0085e2e62aa7aa80160794a3bd2b0838.jpg_720x720q80.jpg', 25);
INSERT INTO `styles` VALUES (69, 18, 'Xanh bạc hà', 'https://down-vn.img.susercontent.com/file/c5ac1e24bd8e1fa7476491dea2f0f06a', 20);
INSERT INTO `styles` VALUES (70, 18, 'Hồng tím', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-purple-png-image_6659253.png', 25);
INSERT INTO `styles` VALUES (71, 18, 'Xám lông chuột', 'https://pic.trangvangvietnam.com/395715081/1482139430_11.jpg', 30);
INSERT INTO `styles` VALUES (72, 18, 'Đỏ mận', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 25);
INSERT INTO `styles` VALUES (73, 19, 'Tím đỏ', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 20);
INSERT INTO `styles` VALUES (74, 19, 'Xanh lá rêu', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 25);
INSERT INTO `styles` VALUES (75, 19, 'Vàng ánh kim', 'https://imagescdn.gettyimagesbank.com/500/18/576/189/0/915398046.jpg', 30);
INSERT INTO `styles` VALUES (76, 19, 'Trắng ngọc trai', 'https://vn-test-11.slatic.net/p/fcdf322e0ab350add3236ad58cd88bb1.jpg', 35);
INSERT INTO `styles` VALUES (77, 20, 'Xanh trời sáng', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 25);
INSERT INTO `styles` VALUES (78, 20, 'Hồng thạch anh', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-pink-png-image_6659252.png', 20);
INSERT INTO `styles` VALUES (79, 20, 'Cam sữa', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-button-color-orange-yellow-png-image_6659251.png', 30);
INSERT INTO `styles` VALUES (80, 20, 'Xám tro', 'https://pic.trangvangvietnam.com/395715081/1482139430_11.jpg', 35);
INSERT INTO `styles` VALUES (81, 21, 'Đỏ ánh cam', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 20);
INSERT INTO `styles` VALUES (82, 21, 'Xanh dương nhạt', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-button-color-png-image_6659249.png', 25);
INSERT INTO `styles` VALUES (83, 22, 'Tím đỏ', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 30);
INSERT INTO `styles` VALUES (84, 22, 'Vàng kim loại', 'https://imagescdn.gettyimagesbank.com/500/18/576/189/0/915398046.jpg', 20);
INSERT INTO `styles` VALUES (85, 23, 'Xanh lam đậm', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 25);
INSERT INTO `styles` VALUES (86, 23, 'Hồng nhạt', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-pink-png-image_6659252.png', 30);
INSERT INTO `styles` VALUES (87, 24, 'Đen mờ', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-button-black-png-image_9051705.png', 35);
INSERT INTO `styles` VALUES (88, 24, 'Trắng kem', 'https://vn-test-11.slatic.net/p/fcdf322e0ab350add3236ad58cd88bb1.jpg', 20);
INSERT INTO `styles` VALUES (89, 25, 'Nâu gỗ', 'https://img.lazcdn.com/g/p/0085e2e62aa7aa80160794a3bd2b0838.jpg_720x720q80.jpg', 25);
INSERT INTO `styles` VALUES (90, 25, 'Xanh lá non', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 30);
INSERT INTO `styles` VALUES (91, 26, 'Cam đất', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-button-color-orange-yellow-png-image_6659251.png', 20);
INSERT INTO `styles` VALUES (92, 26, 'Tím hồng', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-purple-png-image_6659253.png', 25);
INSERT INTO `styles` VALUES (93, 27, 'Xám ánh kim', 'https://pic.trangvangvietnam.com/395715081/1482139430_11.jpg', 30);
INSERT INTO `styles` VALUES (94, 27, 'Vàng nâu', 'https://img.lazcdn.com/g/p/0085e2e62aa7aa80160794a3bd2b0838.jpg_720x720q80.jpg', 20);
INSERT INTO `styles` VALUES (95, 28, 'Xanh cổ vịt', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 25);
INSERT INTO `styles` VALUES (96, 28, 'Hồng phấn', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-pink-png-image_6659252.png', 30);
INSERT INTO `styles` VALUES (97, 29, 'Đỏ tươi', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 20);
INSERT INTO `styles` VALUES (98, 29, 'Xanh pastel', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 25);
INSERT INTO `styles` VALUES (99, 30, 'Xám đậm', 'https://pic.trangvangvietnam.com/395715081/1482139430_11.jpg', 30);
INSERT INTO `styles` VALUES (100, 30, 'Trắng tuyết', 'https://vn-test-11.slatic.net/p/fcdf322e0ab350add3236ad58cd88bb1.jpg', 25);
INSERT INTO `styles` VALUES (101, 31, 'Đỏ tươi', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 25);
INSERT INTO `styles` VALUES (102, 31, 'Xanh biển', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 30);
INSERT INTO `styles` VALUES (103, 31, 'Vàng chanh', 'https://imagescdn.gettyimagesbank.com/500/18/576/189/0/915398046.jpg', 20);
INSERT INTO `styles` VALUES (104, 32, 'Xanh dương', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-button-color-png-image_6659249.png', 30);
INSERT INTO `styles` VALUES (105, 32, 'Tím đậm', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-purple-png-image_6659253.png', 25);
INSERT INTO `styles` VALUES (106, 32, 'Cam sáng', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-button-color-orange-yellow-png-image_6659251.png', 20);
INSERT INTO `styles` VALUES (107, 33, 'Xanh rêu', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 25);
INSERT INTO `styles` VALUES (108, 33, 'Nâu vàng', 'https://img.lazcdn.com/g/p/0085e2e62aa7aa80160794a3bd2b0838.jpg_720x720q80.jpg', 30);
INSERT INTO `styles` VALUES (109, 33, 'Vàng nhạt', 'https://imagescdn.gettyimagesbank.com/500/18/576/189/0/915398046.jpg', 20);
INSERT INTO `styles` VALUES (110, 34, 'Đen', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-button-black-png-image_9051705.png', 35);
INSERT INTO `styles` VALUES (111, 34, 'Xám xanh', 'https://pic.trangvangvietnam.com/395715081/1482139430_11.jpg', 25);
INSERT INTO `styles` VALUES (112, 34, 'Trắng', 'https://vn-test-11.slatic.net/p/fcdf322e0ab350add3236ad58cd88bb1.jpg', 20);
INSERT INTO `styles` VALUES (113, 35, 'Đỏ nâu', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 30);
INSERT INTO `styles` VALUES (114, 35, 'Vàng nghệ', 'https://imagescdn.gettyimagesbank.com/500/18/576/189/0/915398046.jpg', 25);
INSERT INTO `styles` VALUES (115, 35, 'Hồng đậm', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-pink-png-image_6659252.png', 20);
INSERT INTO `styles` VALUES (116, 36, 'Tím hoa oải hương', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-purple-png-image_6659253.png', 25);
INSERT INTO `styles` VALUES (117, 36, 'Xanh lá cây', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 30);
INSERT INTO `styles` VALUES (118, 36, 'Vàng sẫm', 'https://imagescdn.gettyimagesbank.com/500/18/576/189/0/915398046.jpg', 20);
INSERT INTO `styles` VALUES (119, 37, 'Cam đất', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-button-color-orange-yellow-png-image_6659251.png', 20);
INSERT INTO `styles` VALUES (120, 37, 'Xanh cổ vịt', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 30);
INSERT INTO `styles` VALUES (121, 37, 'Hồng nhạt', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-pink-png-image_6659252.png', 25);
INSERT INTO `styles` VALUES (122, 38, 'Xanh bạc hà', 'https://down-vn.img.susercontent.com/file/c5ac1e24bd8e1fa7476491dea2f0f06a', 25);
INSERT INTO `styles` VALUES (123, 38, 'Vàng nhạt', 'https://imagescdn.gettyimagesbank.com/500/18/576/189/0/915398046.jpg', 30);
INSERT INTO `styles` VALUES (124, 38, 'Đen ánh kim', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-button-black-png-image_9051705.png', 20);
INSERT INTO `styles` VALUES (125, 39, 'Nâu đất', 'https://img.lazcdn.com/g/p/0085e2e62aa7aa80160794a3bd2b0838.jpg_720x720q80.jpg', 30);
INSERT INTO `styles` VALUES (126, 39, 'Xanh đen', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-button-black-png-image_9051705.png', 25);
INSERT INTO `styles` VALUES (127, 39, 'Trắng bạc', 'https://down-vn.img.susercontent.com/file/c5ac1e24bd8e1fa7476491dea2f0f06a', 20);
INSERT INTO `styles` VALUES (128, 40, 'Xanh dương nhạt', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-button-color-png-image_6659249.png', 25);
INSERT INTO `styles` VALUES (129, 40, 'Hồng pastel', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-pink-png-image_6659252.png', 30);
INSERT INTO `styles` VALUES (130, 40, 'Đỏ tươi', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 20);
INSERT INTO `styles` VALUES (131, 41, 'Xanh rêu', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 20);
INSERT INTO `styles` VALUES (132, 42, 'Đỏ rực', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 25);
INSERT INTO `styles` VALUES (133, 42, 'Vàng kim', 'https://imagescdn.gettyimagesbank.com/500/18/576/189/0/915398046.jpg', 30);
INSERT INTO `styles` VALUES (134, 43, 'Hồng ngọc', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-pink-png-image_6659252.png', 20);
INSERT INTO `styles` VALUES (135, 43, 'Xám khói', 'https://pic.trangvangvietnam.com/395715081/1482139430_11.jpg', 25);
INSERT INTO `styles` VALUES (136, 44, 'Nâu đồng', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 30);
INSERT INTO `styles` VALUES (137, 44, 'Xanh bích', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 25);
INSERT INTO `styles` VALUES (138, 44, 'Vàng nhạt', 'https://imagescdn.gettyimagesbank.com/500/18/576/189/0/915398046.jpg', 20);
INSERT INTO `styles` VALUES (139, 45, 'Xanh lá mạ', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 35);
INSERT INTO `styles` VALUES (140, 46, 'Trắng tuyết', 'https://vn-test-11.slatic.net/p/fcdf322e0ab350add3236ad58cd88bb1.jpg', 20);
INSERT INTO `styles` VALUES (141, 46, 'Xanh ngọc', 'https://image.made-in-china.com/2f0j00UBItLwqcbAYP/Best-Quality-Best-Price-Garment-Shirt-Button-14L-40L.webp', 30);
INSERT INTO `styles` VALUES (142, 46, 'Đỏ ánh kim', 'https://imgcdn.thitruongsi.com/tts/rs:fill:600:0:1:1/g:sm/plain/file://product/2020/06/10/23f7d330-ab0d-11ea-af80-911f84594d60.jpg', 25);
INSERT INTO `styles` VALUES (143, 47, 'Tím lavender', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-purple-png-image_6659253.png', 25);
INSERT INTO `styles` VALUES (144, 47, 'Xanh dương đậm', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-button-color-png-image_6659249.png', 20);
INSERT INTO `styles` VALUES (145, 48, 'Cam sẫm', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-button-color-orange-yellow-png-image_6659251.png', 20);
INSERT INTO `styles` VALUES (146, 48, 'Vàng chanh', 'https://imagescdn.gettyimagesbank.com/500/18/576/189/0/915398046.jpg', 25);
INSERT INTO `styles` VALUES (147, 48, 'Xanh dương nhạt', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-button-color-png-image_6659249.png', 30);
INSERT INTO `styles` VALUES (148, 49, 'Xanh đậm', 'https://png.pngtree.com/png-clipart/20230413/original/pngtree-shirt-buttons-colored-green-png-image_9051694.png', 40);
INSERT INTO `styles` VALUES (149, 50, 'Nâu sữa', 'https://img.lazcdn.com/g/p/0085e2e62aa7aa80160794a3bd2b0838.jpg_720x720q80.jpg', 25);
INSERT INTO `styles` VALUES (150, 50, 'Hồng pastel', 'https://png.pngtree.com/png-vector/20230323/ourmid/pngtree-shirt-buttons-colored-pink-png-image_6659252.png', 30);
INSERT INTO `styles` VALUES (151, 51, 'Vàng đồng', 'https://bsg-i.nbxc.com/product/43/db/28/002a81c9360d8876feaff0117f.jpg?x-oss-process=image/resize,w_500,h_500/watermark,color_FFFFFF,type_ZHJvaWRzYW5zZmFsbGJhY2s=,size_18,g_se,t_80,text_ZGdkZW5nd2VpLnN0b3JlLmJvc3Nnb28uY29t', 40);
INSERT INTO `styles` VALUES (152, 51, 'Vàng kim', 'https://product.hstatic.net/1000058346/product/rf009day_17945603cf194c7bb43882326ea5ff60_1024x1024.jpg', 50);
INSERT INTO `styles` VALUES (153, 51, 'Vàng sáng', 'https://down-vn.img.susercontent.com/file/f7d19a2a9baab56913b38c05f8c91acb', 30);
INSERT INTO `styles` VALUES (154, 52, 'Trong suốt', 'https://image.made-in-china.com/202f0j00VlCUPmukbocY/-5-PVC-Transparent-Long-Chain-3-5cm-Tape-Zipper.webp', 60);
INSERT INTO `styles` VALUES (155, 52, 'Màu xanh dương', 'https://down-vn.img.susercontent.com/file/bb6a0155761e0a6b97947740e07e4968', 50);
INSERT INTO `styles` VALUES (156, 53, 'Bạc mờ', 'https://product.hstatic.net/1000058346/product/rf005_b_26ce17d650db4644ab811de7eb85d199_1024x1024.jpg', 40);
INSERT INTO `styles` VALUES (157, 53, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlG44Y63GjWfQRhFw_XT1F2WI5RcX_4bu-GA&s', 60);
INSERT INTO `styles` VALUES (158, 54, 'Đen', 'https://filebroker-cdn.lazada.vn/kf/S50c63bdb780144599500c4bde2b989d51.jpg', 40);
INSERT INTO `styles` VALUES (159, 54, 'Nâu', 'https://image.made-in-china.com/202f0j00tMvleqswGAgK/Brown-Color-10-80cm-5-Colorful-Open-End-Zippers-Auto-Lock-Copper-Metal-Zipper.webp', 50);
INSERT INTO `styles` VALUES (160, 54, 'Vàng', 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lh8hxaa18k4z4d', 40);
INSERT INTO `styles` VALUES (161, 55, 'Bạc sáng', 'https://product.hstatic.net/1000058346/product/rf005_b_26ce17d650db4644ab811de7eb85d199_1024x1024.jpg', 50);
INSERT INTO `styles` VALUES (162, 55, 'Đen', 'https://phukientd.vn/wp-content/uploads/O1CN01E5BM2q1Ye3uxIE3ve_2215439243083-0-cib.jpg', 40);
INSERT INTO `styles` VALUES (163, 56, 'Đen', 'https://down-vn.img.susercontent.com/file/3d029db6ecc9b62ea8aa03bfd22b3feb', 40);
INSERT INTO `styles` VALUES (164, 56, 'Xanh dương', 'https://phukiencandycraft.com/wp-content/uploads/2023/12/kiotviet_7faff0828fdbc31d61a9b56c465aa362.jpg', 60);
INSERT INTO `styles` VALUES (165, 57, 'Nâu', 'https://m.media-amazon.com/images/I/61NFuXuPUJL._AC_SL1000_.jpg', 50);
INSERT INTO `styles` VALUES (166, 57, 'Vàng nhạt', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKRSxs1dj1oTfb3zZNHnXU6Wob09vDZg3_LA&s', 40);
INSERT INTO `styles` VALUES (167, 58, 'Trắng', 'https://www.ubuy.vn/productimg/?image=aHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0kvMzFCcmhDV0FCVEwuX1NTNDAwXy5qcGc.jpg', 70);
INSERT INTO `styles` VALUES (168, 58, 'Vàng', 'https://lh5.googleusercontent.com/proxy/Yb1fZbjAx6a99hOpo2OWvLA2NTAz35AmFK-Y4iTPAPqWbiXC70NHSlXBkGjj2WoqMVR7rj4U4P7rqjPskD4iMLxvTlHwlQrrEGkZhsmG2yjJeCxK', 60);
INSERT INTO `styles` VALUES (169, 59, 'Trắng', 'https://down-vn.img.susercontent.com/file/sg-11134201-7rbke-lnds00mktz9j57', 50);
INSERT INTO `styles` VALUES (170, 59, 'Đen', 'https://lensoiquynhlam.com/wp-content/uploads/2023/04/z3489004552028_17de4b1c2610dd2fb2f6c5565702b347-2.jpg', 40);
INSERT INTO `styles` VALUES (171, 60, 'Xám', 'https://png.pngtree.com/png-clipart/20210301/ourmid/pngtree-gray-zipper-clip-art-png-image_2977807.png', 50);
INSERT INTO `styles` VALUES (172, 60, 'Đen', 'https://down-vn.img.susercontent.com/file/3e9455e63de3c0170254d07f4fc03033', 50);
INSERT INTO `styles` VALUES (173, 61, 'Màu đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWGkRSmGXGtqOJZeTO97jNNgIiYzKuyp3dvQ&s', 50);
INSERT INTO `styles` VALUES (174, 61, 'Màu xám', 'https://www.khoakeo.com/wp-content/uploads/2019/04/D%C3%A2y-kh%C3%B3a-k%C3%A9o-phao-3-O.jpg', 40);
INSERT INTO `styles` VALUES (175, 62, 'Màu xanh dương', 'https://png.pngtree.com/png-vector/20240125/ourlarge/pngtree-blue-zipper-isolated-with-clipping-path-png-image_11549508.png', 60);
INSERT INTO `styles` VALUES (176, 62, 'Màu trắng', 'https://media.loveitopcdn.com/6535/thumb/369700854-698700278962953-3946737896695593481-n-2.jpg', 50);
INSERT INTO `styles` VALUES (177, 63, 'Màu bạc', 'https://vn.labelsmfg.com/uploads/202315685/small/own-brand-name-logo-metal-zipper-puller90f7ac31-bf5a-40e3-9f02-d36f371819b0.jpg', 50);
INSERT INTO `styles` VALUES (178, 63, 'Màu đen', 'https://www.mh-chine.com/media/djcatalog2/images/item/6/3-black-rhinestone-teeth-zipper-0287-30_m.webp', 60);
INSERT INTO `styles` VALUES (179, 64, 'Màu đỏ', 'https://down-vn.img.susercontent.com/file/c393e3362e86907e9ba7969150c674b6', 50);
INSERT INTO `styles` VALUES (180, 64, 'Màu vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBR6CdBzhveinCCTD38ykrNkXwQ5PidSqZdg&s', 70);
INSERT INTO `styles` VALUES (181, 65, 'Màu vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBR6CdBzhveinCCTD38ykrNkXwQ5PidSqZdg&s', 60);
INSERT INTO `styles` VALUES (182, 65, 'Màu cam', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtjKBgog7TrQ2yIpOBzDOGMYvkhv5W2og8nQ&s', 40);
INSERT INTO `styles` VALUES (183, 65, 'Màu nâu', 'https://pic.trangvangvietnam.com/395679069/day%20keo%20an%20nu(%20Knit%20Tape).jpg', 50);
INSERT INTO `styles` VALUES (184, 66, 'Màu xanh lá', 'https://thucongvietnam.com/data/news/10077/9.jpg', 60);
INSERT INTO `styles` VALUES (185, 66, 'Màu xám', 'https://www.khoakeo.com/wp-content/uploads/2019/04/D%C3%A2y-kh%C3%B3a-k%C3%A9o-phao-3-O.jpg', 40);
INSERT INTO `styles` VALUES (186, 67, 'Màu xám', 'https://www.khoakeo.com/wp-content/uploads/2019/04/D%C3%A2y-kh%C3%B3a-k%C3%A9o-phao-3-O.jpg', 80);
INSERT INTO `styles` VALUES (187, 67, 'Màu đen', 'https://cbu01.alicdn.com/img/ibank/O1CN01AkxqKg1Ye43yMP5XE_!!2215439243083-0-cib.jpg', 60);
INSERT INTO `styles` VALUES (188, 68, 'Màu nâu', 'https://pic.trangvangvietnam.com/395679069/day%20keo%20an%20nu(%20Knit%20Tape).jpg', 70);
INSERT INTO `styles` VALUES (189, 68, 'Màu đỏ', 'https://png.pngtree.com/thumb_back/fw800/background/20220803/pngtree-red-zipper-opening-zippered-close-zipper-photo-image_1189897.jpg', 50);
INSERT INTO `styles` VALUES (190, 69, 'Màu trắng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFtAtTWcUQxzdoH6Qe_p-hPGFLyA_aAw2TEw&s', 90);
INSERT INTO `styles` VALUES (191, 69, 'Màu bạc', 'https://product.hstatic.net/200000849833/product/4a03eb17-5924-4c8d-b222-e763eb70f084_b64272d88c73405fa5d891b2aaa366c0_large.jpg', 40);
INSERT INTO `styles` VALUES (192, 70, 'Màu cam', 'https://down-vn.img.susercontent.com/file/772fbb65a831412859e5ab468470e2cb', 60);
INSERT INTO `styles` VALUES (193, 70, 'Màu tím', 'https://i5.walmartimages.com/seo/22-Zipper-YKK-3-Nylon-Coil-Zippers-Closed-Bottom-218-Purple-1-Zipper-Pack_73123e17-815f-434f-b710-8ec19ea0433c.9a819e1c757c73940d4473d9c29007e4.jpeg', 50);
INSERT INTO `styles` VALUES (194, 71, 'Màu tím', 'https://i5.walmartimages.com/seo/22-Zipper-YKK-3-Nylon-Coil-Zippers-Closed-Bottom-218-Purple-1-Zipper-Pack_73123e17-815f-434f-b710-8ec19ea0433c.9a819e1c757c73940d4473d9c29007e4.jpeg', 60);
INSERT INTO `styles` VALUES (195, 71, 'Màu hồng', 'https://thucongvietnam.com/data/news/10080/15.jpg', 40);
INSERT INTO `styles` VALUES (196, 72, 'Màu hồng', 'https://thucongvietnam.com/data/news/10080/15.jpg', 50);
INSERT INTO `styles` VALUES (197, 72, 'Màu vàng đồng', 'https://phulieumayducphuc.vn/wp-content/uploads/2021/03/day-keo1.jpg', 70);
INSERT INTO `styles` VALUES (198, 73, 'Màu vàng đồng', 'https://lh6.googleusercontent.com/proxy/TW__nu9jCHtYbwN6ywxQOKYJuDUml3ZX_dk0mUT5KEOhVt5arrJlArTO1XxW6cGH1GFJuQZfERZvd7ZhERMRxVcvuXePoV26v-RTesMKlMU', 60);
INSERT INTO `styles` VALUES (199, 73, 'Màu bạc ánh kim', 'https://down-vn.img.susercontent.com/file/cn-11134207-7r98o-ltc52ojag8199b', 50);
INSERT INTO `styles` VALUES (200, 74, 'Màu bạc ánh kim', 'https://down-vn.img.susercontent.com/file/cn-11134207-7r98o-ltc52ojag8199b', 50);
INSERT INTO `styles` VALUES (201, 74, 'Màu đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmprxC1dh3pMpO7rXk1ytFBil5bMsakDumrA&s', 70);
INSERT INTO `styles` VALUES (202, 75, 'Màu đỏ tươi', 'https://cbu01.alicdn.com/img/ibank/O1CN01vOs1on28nWKhbpFeL_!!984447977-0-cib.jpg', 60);
INSERT INTO `styles` VALUES (203, 75, 'Màu xanh dương', 'https://png.pngtree.com/png-vector/20240125/ourlarge/pngtree-blue-zipper-isolated-with-clipping-path-png-image_11549508.png', 40);
INSERT INTO `styles` VALUES (204, 76, 'Màu xanh dương đậm', 'https://png.pngtree.com/png-vector/20240125/ourmid/pngtree-blue-zipper-isolated-with-clipping-path-png-image_11549502.png', 50);
INSERT INTO `styles` VALUES (205, 76, 'Màu nâu sáng', 'https://pic.trangvangvietnam.com/395679069/day%20keo%20an%20nu(%20Knit%20Tape).jpg', 60);
INSERT INTO `styles` VALUES (206, 77, 'Màu nâu sáng', 'https://pic.trangvangvietnam.com/395679069/day%20keo%20an%20nu(%20Knit%20Tape).jpg', 80);
INSERT INTO `styles` VALUES (207, 77, 'Màu xanh lá', 'https://thucongvietnam.com/data/news/10077/9.jpg', 40);
INSERT INTO `styles` VALUES (208, 78, 'Màu xanh ngọc', 'https://down-vn.img.susercontent.com/file/bb6a0155761e0a6b97947740e07e4968', 70);
INSERT INTO `styles` VALUES (209, 78, 'Màu bạc', 'https://product.hstatic.net/200000849833/product/f006dbf9-c243-43f0-b317-e6971edabb0d_b56055ff027c4f72938858ec72c8dd8e_large.jpg', 50);
INSERT INTO `styles` VALUES (210, 79, 'Màu đen nhám', 'https://down-vn.img.susercontent.com/file/sg-11134201-23020-6ha1l16mcanv07', 90);
INSERT INTO `styles` VALUES (211, 79, 'Màu trắng', 'https://www.ubuy.vn/productimg/?image=aHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0kvOTFOa0Y0TEt2c0wuX0FDX1NMMTUwMF8uanBn.jpg', 40);
INSERT INTO `styles` VALUES (212, 80, 'Màu bạc nhám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRm4K1-GxRVq8lakhUmXH-9a5ndbo149rw4NQ&s', 50);
INSERT INTO `styles` VALUES (213, 80, 'Màu xám', 'https://image.made-in-china.com/202f0j00sCHWkgEICNuM/Light-Grey-Color-Long-Invisible-Zippers-Sewing-Clothes-Accessory-Nylon-Coil-Zipper.webp', 60);
INSERT INTO `styles` VALUES (214, 81, 'Màu đen', 'https://down-vn.img.susercontent.com/file/0fd4a878d9316e1dd1126c2e581e6a44', 50);
INSERT INTO `styles` VALUES (215, 81, 'Màu trắng', 'https://media.loveitopcdn.com/6535/thumb/369166256-698700352296279-8859803116084642669-n-2.jpg', 40);
INSERT INTO `styles` VALUES (216, 82, 'Màu xanh dương', 'https://mayhopphat.com/wp-content/uploads/2020/11/day-keo-nhua-4-min.jpg', 60);
INSERT INTO `styles` VALUES (217, 82, 'Màu đỏ', 'https://down-vn.img.susercontent.com/file/sg-11134201-7rcc1-lstkev9l523q15', 50);
INSERT INTO `styles` VALUES (218, 83, 'Màu bạc', 'https://down-vn.img.susercontent.com/file/dce8fc2db0b423857d75350fcbecb0e7', 70);
INSERT INTO `styles` VALUES (219, 83, 'Màu xám', 'https://www.khoakeo.com/wp-content/uploads/2019/04/D%C3%A2y-kh%C3%B3a-k%C3%A9o-phao-3-O.jpg', 50);
INSERT INTO `styles` VALUES (220, 84, 'Màu vàng', 'https://image.made-in-china.com/202f0j00wBClrSZniJpW/Yellow-Color-5-Sewing-Zippers-Brass-Metal-Open-End-Zipper.webp', 40);
INSERT INTO `styles` VALUES (221, 84, 'Màu cam', 'https://down-vn.img.susercontent.com/file/vn-11134201-23020-helaij34ulnv4b', 60);
INSERT INTO `styles` VALUES (222, 85, 'Màu xanh lá', 'https://product.hstatic.net/1000058346/product/rf006xanhcom_bf2225ae3d604ac8bd7140610fb4bd4c.jpg', 50);
INSERT INTO `styles` VALUES (223, 85, 'Màu nâu', 'https://bizweb.dktcdn.net/thumb/1024x1024/100/462/645/products/da86a9eeae83ad152a257d3f087f0a6e-1663644313056.jpg?v=1663940763223', 40);
INSERT INTO `styles` VALUES (224, 86, 'Màu tím', 'https://image.made-in-china.com/202f0j00mBpVDNOAeFrZ/Light-Purple-Color-Long-Invisible-Zippers-Sewing-Clothes-Accessory-Nylon-Coil-Zipper.webp', 70);
INSERT INTO `styles` VALUES (225, 86, 'Màu bạc', 'https://down-vn.img.susercontent.com/file/260825f21a6f55b85f4b2f91851579e0', 60);
INSERT INTO `styles` VALUES (226, 87, 'Màu đen nhám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTx5yxYfmDJv01UCmOl7Fnd7dSxZyjj0LMsVw&s', 40);
INSERT INTO `styles` VALUES (227, 87, 'Màu trắng', 'https://img.lovepik.com/png/20231128/open-zipper-black-and-white-blank-protection-lock_717383_wh1200.png', 70);
INSERT INTO `styles` VALUES (228, 88, 'Màu xanh ngọc', 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lv7522n4juzed0', 60);
INSERT INTO `styles` VALUES (229, 88, 'Màu đỏ tươi', 'https://bsg-i.nbxc.com/product/2e/1f/73/6a6ab4c751d34c880fd217e41f.jpg', 50);
INSERT INTO `styles` VALUES (230, 89, 'Màu vàng đồng', 'https://image.made-in-china.com/202f0j00deTlwOharJgU/Golden-Color-5-High-End-Handbags-Zippers-Brass-Metal-Zipper.webp', 40);
INSERT INTO `styles` VALUES (231, 89, 'Màu tím', 'https://image.made-in-china.com/202f0j00mBpVDNOAeFrZ/Light-Purple-Color-Long-Invisible-Zippers-Sewing-Clothes-Accessory-Nylon-Coil-Zipper.webp', 30);
INSERT INTO `styles` VALUES (232, 90, 'Màu xanh dương đậm', 'https://mayhopphat.com/wp-content/uploads/2020/11/day-keo-nhua-4-min.jpg', 50);
INSERT INTO `styles` VALUES (233, 90, 'Màu bạc ánh kim', 'https://down-vn.img.susercontent.com/file/dce8fc2db0b423857d75350fcbecb0e7', 70);
INSERT INTO `styles` VALUES (234, 91, 'Màu đen', 'https://i5.walmartimages.com/seo/YKK-3-Coil-Zipper-7-inch-length-Black-580-10-Pack_8ccf2b25-29b3-4e01-bb4c-9c3be2c5cb8d_1.d29d04d0b611947386c9d3468f300b41.jpeg', 60);
INSERT INTO `styles` VALUES (235, 91, 'Màu đỏ', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTH5CUibBZ-4hzCSEJBTPHPaO2hBLu5dxZZQ&s', 50);
INSERT INTO `styles` VALUES (236, 92, 'Màu xanh lá', 'https://img.lovepik.com/png/20231115/zipper-clipart-two-green-zippers-with-a-pair-of-holes_595142_wh860.png', 70);
INSERT INTO `styles` VALUES (237, 92, 'Màu trắng', 'https://down-vn.img.susercontent.com/file/abe9addaa3df29e7f197eea69f2eb0e2', 40);
INSERT INTO `styles` VALUES (238, 93, 'Màu vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgxOOg9DEq7uCcf_OSsdogGbL40vOeRrPPfw&s', 50);
INSERT INTO `styles` VALUES (239, 93, 'Màu cam', 'https://down-vn.img.susercontent.com/file/b0ed4a9c12a8c0f43ae26e2607e51207', 60);
INSERT INTO `styles` VALUES (240, 94, 'Màu bạc', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRm4K1-GxRVq8lakhUmXH-9a5ndbo149rw4NQ&s', 70);
INSERT INTO `styles` VALUES (241, 94, 'Màu đen nhám', 'https://down-vn.img.susercontent.com/file/0fd4a878d9316e1dd1126c2e581e6a44', 40);
INSERT INTO `styles` VALUES (242, 95, 'Màu xanh dương', 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lxt683tnt6mz36', 50);
INSERT INTO `styles` VALUES (243, 95, 'Màu tím', 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lwmmmrz71ecb55', 60);
INSERT INTO `styles` VALUES (244, 96, 'Màu vàng đồng', 'https://down-vn.img.susercontent.com/file/5b20d6ccd18435a2973e5e3f0bf6d8c6', 40);
INSERT INTO `styles` VALUES (245, 96, 'Màu xanh ngọc', 'https://vn-test-11.slatic.net/p/ce26689fe881a5893bb8a19dfcd86ead.jpg', 50);
INSERT INTO `styles` VALUES (246, 97, 'Màu nâu', 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lg0gpre3qzufd3', 30);
INSERT INTO `styles` VALUES (247, 97, 'Màu xanh dương đậm', 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-log6w5tofhrr38', 60);
INSERT INTO `styles` VALUES (248, 98, 'Màu đỏ tươi', 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lsb4bdf1h509e6', 70);
INSERT INTO `styles` VALUES (249, 98, 'Màu tím', 'https://image.made-in-china.com/202f0j00HCTVUOGIvyrE/Purple-Color-5-High-Quality-Colorful-Zippers-Open-End-Double-Sliders-Metal-Zipper.webp', 40);
INSERT INTO `styles` VALUES (250, 99, 'Màu bạc ánh kim', 'https://gacuoi.com/upload/product/day-keo-kim-loai-bac-mo11223.jpg', 50);
INSERT INTO `styles` VALUES (251, 99, 'Màu vàng', 'https://image.made-in-china.com/202f0j00wBClrSZniJpW/Yellow-Color-5-Sewing-Zippers-Brass-Metal-Open-End-Zipper.webp', 60);
INSERT INTO `styles` VALUES (252, 100, 'Màu đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYi-Vm9XGhiSdTb2C9epyroQinU0-dSG0rWA&s', 70);
INSERT INTO `styles` VALUES (253, 100, 'Màu cam', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJh2kf3kwAYh-OGZFHwboPYXBfpyWUhKcKXw&s', 50);
INSERT INTO `styles` VALUES (254, 101, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (255, 101, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 30);
INSERT INTO `styles` VALUES (256, 102, 'Xanh dương', 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lw2oc96q5yvvf4.webp', 60);
INSERT INTO `styles` VALUES (257, 102, 'Xanh lá', 'https://down-vn.img.susercontent.com/file/vn-11134207-7ras8-m31ymkr280562f.webp', 40);
INSERT INTO `styles` VALUES (258, 103, 'Be', 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-m075qapv1xbh0e.webp', 50);
INSERT INTO `styles` VALUES (259, 103, 'Hồng', 'https://down-vn.img.susercontent.com/file/e36a7b3600e4bc923552913b0a9e4f89.webp', 30);
INSERT INTO `styles` VALUES (260, 104, 'Đen', 'https://detmaythaihoa.com/wp-content/uploads/2022/07/1634651416294.jpg', 60);
INSERT INTO `styles` VALUES (261, 104, 'Nâu', 'https://demxanh.com/media/news/1210_3363_chan_long_cuu_phap_nicolas_royal_do_chery_6.png', 40);
INSERT INTO `styles` VALUES (262, 105, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (263, 105, 'Đen', 'https://vietthangloi.vn/wp-content/uploads/2023/05/vai-oxford-balo-chong-nuoc.jpg', 30);
INSERT INTO `styles` VALUES (264, 106, 'Vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRb_aeOLyuwZRlovq9w8sHV1pKJnq3vpfN6Q&s', 60);
INSERT INTO `styles` VALUES (265, 106, 'Đỏ', 'https://demxanh.com/media/news/1611_vai_nylon6.jpg', 40);
INSERT INTO `styles` VALUES (266, 107, 'Xanh dương', 'https://mayhopphat.com/wp-content/uploads/2022/02/Vai-jean.jpg', 32);
INSERT INTO `styles` VALUES (267, 107, 'Đen', 'https://png.pngtree.com/thumb_back/fw800/background/20221205/pngtree-black-jeans-denim-texture-pattern-background-image_1479666.jpg', 30);
INSERT INTO `styles` VALUES (268, 108, 'Hồng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8FhKo3ZOwK0bwikjEwtzULFu2uIo0Iqb_DA&s', 60);
INSERT INTO `styles` VALUES (269, 108, 'Vàng', 'https://nhaxasilk.com/wp-content/uploads/2023/06/ST04-0.jpg', 40);
INSERT INTO `styles` VALUES (270, 109, 'Nâu', 'https://www.vestonduynguyen.com/sites/default/files/styles/style_360x507/public/sanpham/nhd81.png?itok=vuCrJkVV', 50);
INSERT INTO `styles` VALUES (271, 109, 'Đỏ', 'https://down-vn.img.susercontent.com/file/4ee0c84a9ea5a0016e0b1d0096464d82', 30);
INSERT INTO `styles` VALUES (272, 110, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 60);
INSERT INTO `styles` VALUES (273, 110, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 40);
INSERT INTO `styles` VALUES (274, 111, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1aizvZFldjsQbBnfyacLe7vpNjRq2EpaFkg&s', 50);
INSERT INTO `styles` VALUES (275, 111, 'Bạc', 'https://s.alicdn.com/@sc04/kf/H19b422c614cd4754a6d0a9367651eda6o.jpg_720x720q50.jpg', 30);
INSERT INTO `styles` VALUES (276, 112, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 60);
INSERT INTO `styles` VALUES (277, 112, 'Đỏ', 'https://down-vn.img.susercontent.com/file/81c8b280d94705a66bce7c76726539a3', 40);
INSERT INTO `styles` VALUES (278, 113, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvumHV0iUMKqYgZ_KaihltpYG9lKJZKA434w&s', 50);
INSERT INTO `styles` VALUES (279, 113, 'Nâu', 'https://vaini.com.vn/upload/product/750560205342.jpg', 30);
INSERT INTO `styles` VALUES (280, 114, 'Xanh lá', 'https://down-vn.img.susercontent.com/file/32ce6e575c7b48a854a1aa3e23a098a0', 60);
INSERT INTO `styles` VALUES (281, 114, 'Vàng', 'https://img.muji.net/img/item/4550584309571_07_400.jpg', 40);
INSERT INTO `styles` VALUES (282, 115, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8lUmWaJK8ov3A41ydEQ-ohwvVJWL83aaodg&s', 50);
INSERT INTO `styles` VALUES (283, 115, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 30);
INSERT INTO `styles` VALUES (284, 116, 'Nâu', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGY-JJ_2ivwpOOw8uxL2rfjnfPURWCT5kSBg&s', 60);
INSERT INTO `styles` VALUES (285, 116, 'Xanh dương', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgUY5PDLVa0ZZmSjJav1HAa2S0zR0jtbNttA&s', 40);
INSERT INTO `styles` VALUES (286, 117, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (287, 117, 'Đen', 'https://down-vn.img.susercontent.com/file/93930d43d7a0df352cfcbead8a1f1819', 30);
INSERT INTO `styles` VALUES (288, 118, 'Đỏ', 'https://down-vn.img.susercontent.com/file/cn-11134207-7ras8-m2ovpphoy02v23', 60);
INSERT INTO `styles` VALUES (289, 118, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 40);
INSERT INTO `styles` VALUES (290, 119, 'Vàng', 'https://image.made-in-china.com/202f0j00dlfzaiHnbsku/Wholesale-High-Quality-Chinese-Shimmer-12mm-Woven-Jacquard-Polyester-Silk-Blend-Brocade-Fabric.webp', 50);
INSERT INTO `styles` VALUES (291, 119, 'Hồng', 'https://product.hstatic.net/1000376073/product/17_1__e09536cd85e24a12bef258a4dae62a9f_master.jpg', 30);
INSERT INTO `styles` VALUES (292, 120, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtOG_plOAFo5ywK_2aD9iqJBQ6RHb3XNnzEw&s', 60);
INSERT INTO `styles` VALUES (293, 120, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 40);
INSERT INTO `styles` VALUES (294, 121, 'Vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlljh8oTgcFVDyIOmkd7uGW8XYCqWbO8vuEA&s', 50);
INSERT INTO `styles` VALUES (295, 121, 'Đen', 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lpoyvct8cibd78', 30);
INSERT INTO `styles` VALUES (296, 122, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 60);
INSERT INTO `styles` VALUES (297, 122, 'Xanh lục', 'https://5sfashion.vn/storage/upload/images/ckeditor/53648RSgSvlvty0cR6VDPu4QGtVnvw8kxx1hSpC4.jpg', 40);
INSERT INTO `styles` VALUES (298, 123, 'Vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTY0Hi_cT6SVKnL4r-fcsRs5MalfEi_9zIJiQ&s', 50);
INSERT INTO `styles` VALUES (299, 123, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 30);
INSERT INTO `styles` VALUES (300, 124, 'Xanh dương', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-vJsV-lAdenNE0FJhPeUuSKfefjVmQaLjJA&s', 60);
INSERT INTO `styles` VALUES (301, 124, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuqnvJ2F88K37eK02mqTa8t6PwHcMHBS_8sw&s', 40);
INSERT INTO `styles` VALUES (302, 125, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (303, 125, 'Đỏ đô', 'https://pubcdn.ivymoda.com/files/news/2024/05/13/d58e611eb505d71838f837da85c8106f.jpg', 30);
INSERT INTO `styles` VALUES (304, 126, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 60);
INSERT INTO `styles` VALUES (305, 126, 'Xanh lá', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKFzvV3D0TMGCOS8mU5ydC7oGLeoBESs8X6g&s', 40);
INSERT INTO `styles` VALUES (306, 127, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgOsDjm6UaBnU_3AUJO2YN3rFeXw8FONZ5vw&s', 50);
INSERT INTO `styles` VALUES (307, 127, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 30);
INSERT INTO `styles` VALUES (308, 128, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 60);
INSERT INTO `styles` VALUES (309, 128, 'Xanh lá', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMEd3VmFAjGLjTXEGBYJgDnl3yIxd-dTN_dw&s', 40);
INSERT INTO `styles` VALUES (310, 129, 'Vàng', 'https://cdn.globalso.com/moyitextile/30s-Twill-Plain-Dyed-Soft-Handfeeling-Rayon-Viscos03.jpg', 49);
INSERT INTO `styles` VALUES (311, 129, 'Đỏ', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyLVldY32Hx6sj2dgy8hAHCKY-rrmPtX8i_g&s', 30);
INSERT INTO `styles` VALUES (312, 130, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 60);
INSERT INTO `styles` VALUES (313, 130, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 40);
INSERT INTO `styles` VALUES (314, 131, 'Xanh dương', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEKQLS0xiT13Tm1BGcd4lg3FkysVay67B7kA&s', 50);
INSERT INTO `styles` VALUES (315, 131, 'Đen', 'https://down-vn.img.susercontent.com/file/78a06de01034102b294f605eb266a03d', 30);
INSERT INTO `styles` VALUES (316, 132, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 60);
INSERT INTO `styles` VALUES (317, 132, 'Vàng', 'https://vaixinh.com.vn/wp-content/uploads/2023/10/NANG.jpg', 40);
INSERT INTO `styles` VALUES (318, 133, 'Đen', 'https://thanhtungtextile.vn/upload/trang-san-pham/vai-linen-1/vai-tho-den-may-quan-gia-tot/vai-tho-den-may-quan-gia-tot-4-inkjpeg.jpeg', 50);
INSERT INTO `styles` VALUES (319, 133, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 30);
INSERT INTO `styles` VALUES (320, 134, 'Xanh', 'https://toplistninhhiep.vn/userfiles/files/chambray-la-vai-gi_1.jpg', 60);
INSERT INTO `styles` VALUES (321, 134, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 40);
INSERT INTO `styles` VALUES (322, 135, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (323, 135, 'Xanh dương', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0gTzk4XwnFSfrEPv_HvJ5zHZ6gsSBSDkjnw&s', 30);
INSERT INTO `styles` VALUES (324, 136, 'Vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdnyB77DCqnm10nopJKuCUxxBHJIY_PGKC6w&s', 58);
INSERT INTO `styles` VALUES (325, 136, 'Xanh', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMyHrM3Gyvdg63vz5E0HzXV0LlCzhRGedQEw&s', 40);
INSERT INTO `styles` VALUES (326, 137, 'Đen', 'https://s.alicdn.com/@sc04/kf/Udf64a312178240888e99d0aa20c51547J.jpg_720x720q50.jpg', 50);
INSERT INTO `styles` VALUES (327, 137, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 30);
INSERT INTO `styles` VALUES (328, 138, 'Vàng', 'https://bsg-i.nbxc.com/product/5c/b9/5b/322e1f7c58c01037a97570afe0.jpg@4e_360w_360h.src%7C95Q.webp', 60);
INSERT INTO `styles` VALUES (329, 138, 'Đỏ', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5URWvnoBJ4fE7XWazcqEsAdwiI5oAF46NbQ&s', 40);
INSERT INTO `styles` VALUES (330, 139, 'Xanh dương', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTetVt1cqe1lfSN-INqDCUmA7RPJSCOfVAg3g56cmnuaMsPnlOD3JafZtsGrDnCOsbChwk&usqp=CAU', 50);
INSERT INTO `styles` VALUES (331, 139, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT35qYd69rGmUvN0ra7CsNEP0jfG1VmIfQ8rg&s', 30);
INSERT INTO `styles` VALUES (332, 140, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 60);
INSERT INTO `styles` VALUES (333, 140, 'Đỏ', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIjrDTUu6C4ssvsDnMXYDsPy5iNtyG2Urq8Q&s', 40);
INSERT INTO `styles` VALUES (334, 141, 'Vàng', 'https://5sfashion.vn/storage/upload/images/ckeditor/brPbDhXGNfpD5s0G9DcnU4HsAuLtgCrkjyNsNCPF.jpg', 50);
INSERT INTO `styles` VALUES (335, 141, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 30);
INSERT INTO `styles` VALUES (336, 142, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 60);
INSERT INTO `styles` VALUES (337, 142, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRydHvNX__rxisbKKoTmS8JdjaMxsMHdLkRrf9V4WQk-zXQVfOJWbfagdlE27Ix_GWkhUI&usqp=CAU', 40);
INSERT INTO `styles` VALUES (338, 143, 'Xanh lá', 'https://vn.xianbangtextile.com/uploads/202236607/herringbone-fabric-blue01210464335.jpg', 50);
INSERT INTO `styles` VALUES (339, 143, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 30);
INSERT INTO `styles` VALUES (340, 144, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 60);
INSERT INTO `styles` VALUES (341, 144, 'Xanh dương', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2ok6IOAkDeQdAO_y2Q-8XrIVXUsBPhydhtw&s', 40);
INSERT INTO `styles` VALUES (342, 145, 'Vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvAJfZZ7stN3Ze2br3YLtwVxuSAtelN46Ybw&s', 50);
INSERT INTO `styles` VALUES (343, 145, 'Đỏ', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKpAcXq07nAucFcuskLti_fAIOUiGUjYLDmw&s', 30);
INSERT INTO `styles` VALUES (344, 146, 'Xanh lá', 'https://vuanem.com/blog/wp-content/uploads/2023/11/vai-pique-la-gi.jpeg', 44);
INSERT INTO `styles` VALUES (345, 146, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 40);
INSERT INTO `styles` VALUES (346, 147, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (347, 147, 'Đen', 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lwzbhpdho4pl1f', 30);
INSERT INTO `styles` VALUES (348, 148, 'Xanh dương', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpwlbo08ikEOFVDT_Z9fmO3Q0_7vrC71_vcg&s', 60);
INSERT INTO `styles` VALUES (349, 148, 'Đỏ', 'https://s.alicdn.com/@sc04/kf/H6d9882253c7042e4aba669cd96b2910bt.jpg_720x720q50.jpg', 40);
INSERT INTO `styles` VALUES (350, 149, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (351, 149, 'Xanh lá', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3NKLUhTbUASgcUIxVQRbCpLrxxoUE_Nv0_g&s', 30);
INSERT INTO `styles` VALUES (352, 150, 'Vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRb_aeOLyuwZRlovq9w8sHV1pKJnq3vpfN6Q&s', 49);
INSERT INTO `styles` VALUES (353, 150, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 39);
INSERT INTO `styles` VALUES (354, 151, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (355, 151, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 60);
INSERT INTO `styles` VALUES (356, 151, 'Be', 'https://detkimkienhoa.com/wp-content/uploads/2021/07/dia-chi-mua-vai-cotton-4-chieu-cvc-60-40.jpg', 40);
INSERT INTO `styles` VALUES (357, 152, 'Xanh dương', 'https://aodaiviet.net/wp-content/uploads/2021/01/vai-lua-satin-xanh-coban-tron-MNV-LHD63.jpg', 30);
INSERT INTO `styles` VALUES (358, 152, 'Vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzlnUw7LE1oWxTCJWFrRpODNSBAK8nvWjsvg&s', 45);
INSERT INTO `styles` VALUES (359, 152, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (360, 153, 'Đỏ', 'https://img.alicdn.com/i1/2189034251/O1CN011hH092HLzeW8zYI_!!2189034251.jpg_400x400.jpg_.webp', 60);
INSERT INTO `styles` VALUES (361, 153, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPIxzWyqygrwF7Q7jx4HdHztSFULlQ3oKHAw&s', 55);
INSERT INTO `styles` VALUES (362, 153, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (363, 154, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 40);
INSERT INTO `styles` VALUES (364, 154, 'Nâu', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpjBRUw6653igV7W9BXPz68zV_UA-0lJR52Q&s', 35);
INSERT INTO `styles` VALUES (365, 154, 'Be', 'https://detkimkienhoa.com/wp-content/uploads/2021/07/dia-chi-mua-vai-cotton-4-chieu-cvc-60-40.jpg', 60);
INSERT INTO `styles` VALUES (366, 155, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 70);
INSERT INTO `styles` VALUES (367, 155, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 45);
INSERT INTO `styles` VALUES (368, 155, 'Xanh lá', 'https://down-vn.img.susercontent.com/file/4cf5f53201f7d499636cfd40dde97008', 50);
INSERT INTO `styles` VALUES (369, 156, 'Vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzlnUw7LE1oWxTCJWFrRpODNSBAK8nvWjsvg&s', 40);
INSERT INTO `styles` VALUES (370, 156, 'Xanh dương', 'https://aodaiviet.net/wp-content/uploads/2021/01/vai-lua-satin-xanh-coban-tron-MNV-LHD63.jpg', 55);
INSERT INTO `styles` VALUES (371, 156, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 60);
INSERT INTO `styles` VALUES (372, 157, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPIxzWyqygrwF7Q7jx4HdHztSFULlQ3oKHAw&s', 70);
INSERT INTO `styles` VALUES (373, 157, 'Nâu', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpjBRUw6653igV7W9BXPz68zV_UA-0lJR52Q&s', 50);
INSERT INTO `styles` VALUES (374, 157, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 40);
INSERT INTO `styles` VALUES (375, 158, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 60);
INSERT INTO `styles` VALUES (376, 158, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 50);
INSERT INTO `styles` VALUES (377, 158, 'Nâu', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpjBRUw6653igV7W9BXPz68zV_UA-0lJR52Q&s', 40);
INSERT INTO `styles` VALUES (378, 159, 'Đỏ', 'https://img.alicdn.com/i1/2189034251/O1CN011hH092HLzeW8zYI_!!2189034251.jpg_400x400.jpg_.webp', 60);
INSERT INTO `styles` VALUES (379, 159, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 55);
INSERT INTO `styles` VALUES (380, 159, 'Xanh dương', 'https://aodaiviet.net/wp-content/uploads/2021/01/vai-lua-satin-xanh-coban-tron-MNV-LHD63.jpg', 45);
INSERT INTO `styles` VALUES (381, 160, 'Be', 'https://detkimkienhoa.com/wp-content/uploads/2021/07/dia-chi-mua-vai-cotton-4-chieu-cvc-60-40.jpg', 70);
INSERT INTO `styles` VALUES (382, 160, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (383, 160, 'Vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzlnUw7LE1oWxTCJWFrRpODNSBAK8nvWjsvg&s', 40);
INSERT INTO `styles` VALUES (384, 161, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (385, 161, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 60);
INSERT INTO `styles` VALUES (386, 161, 'Be', 'https://detkimkienhoa.com/wp-content/uploads/2021/07/dia-chi-mua-vai-cotton-4-chieu-cvc-60-40.jpg', 40);
INSERT INTO `styles` VALUES (387, 162, 'Đỏ', 'https://img.alicdn.com/i1/2189034251/O1CN011hH092HLzeW8zYI_!!2189034251.jpg_400x400.jpg_.webp', 70);
INSERT INTO `styles` VALUES (388, 162, 'Nâu', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpjBRUw6653igV7W9BXPz68zV_UA-0lJR52Q&s', 50);
INSERT INTO `styles` VALUES (389, 162, 'Xanh lá', 'https://down-vn.img.susercontent.com/file/4cf5f53201f7d499636cfd40dde97008', 60);
INSERT INTO `styles` VALUES (390, 163, 'Vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzlnUw7LE1oWxTCJWFrRpODNSBAK8nvWjsvg&s', 45);
INSERT INTO `styles` VALUES (391, 163, 'Xanh dương', 'https://aodaiviet.net/wp-content/uploads/2021/01/vai-lua-satin-xanh-coban-tron-MNV-LHD63.jpg', 55);
INSERT INTO `styles` VALUES (392, 163, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (393, 164, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPIxzWyqygrwF7Q7jx4HdHztSFULlQ3oKHAw&s', 40);
INSERT INTO `styles` VALUES (394, 164, 'Nâu', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpjBRUw6653igV7W9BXPz68zV_UA-0lJR52Q&s', 60);
INSERT INTO `styles` VALUES (395, 164, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 55);
INSERT INTO `styles` VALUES (396, 165, 'Xanh lá', 'https://down-vn.img.susercontent.com/file/4cf5f53201f7d499636cfd40dde97008', 70);
INSERT INTO `styles` VALUES (397, 165, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (398, 165, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 60);
INSERT INTO `styles` VALUES (399, 166, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (400, 166, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 60);
INSERT INTO `styles` VALUES (401, 166, 'Đỏ', 'https://img.alicdn.com/i1/2189034251/O1CN011hH092HLzeW8zYI_!!2189034251.jpg_400x400.jpg_.webp', 45);
INSERT INTO `styles` VALUES (402, 167, 'Xanh dương', 'https://aodaiviet.net/wp-content/uploads/2021/01/vai-lua-satin-xanh-coban-tron-MNV-LHD63.jpg', 40);
INSERT INTO `styles` VALUES (403, 167, 'Vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzlnUw7LE1oWxTCJWFrRpODNSBAK8nvWjsvg&s', 50);
INSERT INTO `styles` VALUES (404, 167, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPIxzWyqygrwF7Q7jx4HdHztSFULlQ3oKHAw&s', 55);
INSERT INTO `styles` VALUES (405, 168, 'Xanh lá', 'https://down-vn.img.susercontent.com/file/4cf5f53201f7d499636cfd40dde97008', 60);
INSERT INTO `styles` VALUES (406, 168, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 70);
INSERT INTO `styles` VALUES (407, 168, 'Nâu', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpjBRUw6653igV7W9BXPz68zV_UA-0lJR52Q&s', 45);
INSERT INTO `styles` VALUES (408, 169, 'Đỏ', 'https://img.alicdn.com/i1/2189034251/O1CN011hH092HLzeW8zYI_!!2189034251.jpg_400x400.jpg_.webp', 50);
INSERT INTO `styles` VALUES (409, 169, 'Xanh dương', 'https://aodaiviet.net/wp-content/uploads/2021/01/vai-lua-satin-xanh-coban-tron-MNV-LHD63.jpg', 40);
INSERT INTO `styles` VALUES (410, 169, 'Nâu', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpjBRUw6653igV7W9BXPz68zV_UA-0lJR52Q&s', 60);
INSERT INTO `styles` VALUES (411, 170, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 55);
INSERT INTO `styles` VALUES (412, 170, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 50);
INSERT INTO `styles` VALUES (413, 170, 'Vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzlnUw7LE1oWxTCJWFrRpODNSBAK8nvWjsvg&s', 40);
INSERT INTO `styles` VALUES (414, 171, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPIxzWyqygrwF7Q7jx4HdHztSFULlQ3oKHAw&s', 60);
INSERT INTO `styles` VALUES (415, 171, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (416, 171, 'Nâu', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpjBRUw6653igV7W9BXPz68zV_UA-0lJR52Q&s', 45);
INSERT INTO `styles` VALUES (417, 172, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 70);
INSERT INTO `styles` VALUES (418, 172, 'Vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzlnUw7LE1oWxTCJWFrRpODNSBAK8nvWjsvg&s', 60);
INSERT INTO `styles` VALUES (419, 172, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 40);
INSERT INTO `styles` VALUES (420, 173, 'Đỏ', 'https://img.alicdn.com/i1/2189034251/O1CN011hH092HLzeW8zYI_!!2189034251.jpg_400x400.jpg_.webp', 50);
INSERT INTO `styles` VALUES (421, 173, 'Xanh lá', 'https://down-vn.img.susercontent.com/file/4cf5f53201f7d499636cfd40dde97008', 55);
INSERT INTO `styles` VALUES (422, 173, 'Xanh dương', 'https://aodaiviet.net/wp-content/uploads/2021/01/vai-lua-satin-xanh-coban-tron-MNV-LHD63.jpg', 60);
INSERT INTO `styles` VALUES (423, 174, 'Nâu', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpjBRUw6653igV7W9BXPz68zV_UA-0lJR52Q&s', 70);
INSERT INTO `styles` VALUES (424, 174, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 45);
INSERT INTO `styles` VALUES (425, 174, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (426, 175, 'Xanh lá', 'https://down-vn.img.susercontent.com/file/4cf5f53201f7d499636cfd40dde97008', 60);
INSERT INTO `styles` VALUES (427, 175, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPIxzWyqygrwF7Q7jx4HdHztSFULlQ3oKHAw&s', 55);
INSERT INTO `styles` VALUES (428, 175, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 40);
INSERT INTO `styles` VALUES (429, 176, 'Xanh dương', 'https://aodaiviet.net/wp-content/uploads/2021/01/vai-lua-satin-xanh-coban-tron-MNV-LHD63.jpg', 50);
INSERT INTO `styles` VALUES (430, 176, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 45);
INSERT INTO `styles` VALUES (431, 176, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 60);
INSERT INTO `styles` VALUES (432, 177, 'Nâu', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpjBRUw6653igV7W9BXPz68zV_UA-0lJR52Q&s', 55);
INSERT INTO `styles` VALUES (433, 177, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 60);
INSERT INTO `styles` VALUES (434, 177, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 40);
INSERT INTO `styles` VALUES (435, 178, 'Vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzlnUw7LE1oWxTCJWFrRpODNSBAK8nvWjsvg&s', 70);
INSERT INTO `styles` VALUES (436, 178, 'Đen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPIxzWyqygrwF7Q7jx4HdHztSFULlQ3oKHAw&s', 60);
INSERT INTO `styles` VALUES (437, 178, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (438, 179, 'Đỏ', 'https://img.alicdn.com/i1/2189034251/O1CN011hH092HLzeW8zYI_!!2189034251.jpg_400x400.jpg_.webp', 60);
INSERT INTO `styles` VALUES (439, 179, 'Xanh lá', 'https://down-vn.img.susercontent.com/file/4cf5f53201f7d499636cfd40dde97008', 55);
INSERT INTO `styles` VALUES (440, 179, 'Trắng', 'https://dongphucbenhvien.com.vn/upload/images/vai-kate-trang-01.jpg', 50);
INSERT INTO `styles` VALUES (441, 180, 'Xanh dương', 'https://aodaiviet.net/wp-content/uploads/2021/01/vai-lua-satin-xanh-coban-tron-MNV-LHD63.jpg', 60);
INSERT INTO `styles` VALUES (442, 180, 'Vàng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzlnUw7LE1oWxTCJWFrRpODNSBAK8nvWjsvg&s', 50);
INSERT INTO `styles` VALUES (443, 180, 'Xám', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0bKrMJoOu6MNHzoxd0pAoue1ah8KfSDGlQ&s', 45);

-- ----------------------------
-- Table structure for technical_information
-- ----------------------------
DROP TABLE IF EXISTS `technical_information`;
CREATE TABLE `technical_information`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `specifications` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `manufactureDate` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 182 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of technical_information
-- ----------------------------
INSERT INTO `technical_information` VALUES (1, 'Chất liệu: Gỗ, Kiểu dáng tròn cổ điển, Phù hợp cho áo sơ mi', '2024-01-01');
INSERT INTO `technical_information` VALUES (2, 'Chất liệu: Nhựa, Độ bền cao, Chống vỡ khi sử dụng', '2024-01-02');
INSERT INTO `technical_information` VALUES (3, 'Chất liệu: Kim loại, Kích thước nhỏ, Phong cách tối giản', '2024-01-03');
INSERT INTO `technical_information` VALUES (4, 'Chất liệu: Gỗ, Chạm khắc thủ công, Thiết kế độc đáo', '2024-01-04');
INSERT INTO `technical_information` VALUES (5, 'Chất liệu: Nhựa, Bề mặt mịn, Lý tưởng cho áo thun', '2024-01-05');
INSERT INTO `technical_information` VALUES (6, 'Chất liệu: Vải, Nhẹ, Phù hợp cho thời trang mùa hè', '2024-01-06');
INSERT INTO `technical_information` VALUES (7, 'Chất liệu: Kim loại, Kích thước lớn, Thích hợp cho áo khoác', '2024-01-07');
INSERT INTO `technical_information` VALUES (8, 'Chất liệu: Gỗ tự nhiên, Không qua xử lý hóa chất, Thân thiện môi trường', '2024-01-08');
INSERT INTO `technical_information` VALUES (9, 'Chất liệu: Nhựa, Thiết kế trong suốt, Mang lại vẻ tinh tế', '2024-01-09');
INSERT INTO `technical_information` VALUES (10, 'Chất liệu: Kim loại, Có họa tiết, Phong cách cổ điển', '2024-01-10');
INSERT INTO `technical_information` VALUES (11, 'Cơ chế: Nam châm, Không cần khuy cài, Tiện lợi', '2024-01-11');
INSERT INTO `technical_information` VALUES (12, 'Chất liệu: Gỗ ép, Giá thành thấp, Bền và chắc chắn', '2024-01-12');
INSERT INTO `technical_information` VALUES (13, 'Chất liệu: Nhựa, Siêu nhẹ, Dễ dàng sử dụng', '2024-01-13');
INSERT INTO `technical_information` VALUES (14, 'Chất liệu: Vải, Họa tiết thêu tay, Tinh xảo và độc nhất', '2024-01-14');
INSERT INTO `technical_information` VALUES (15, 'Chất liệu: Gỗ ghép, Tạo họa tiết đặc biệt, Sáng tạo', '2024-01-15');
INSERT INTO `technical_information` VALUES (16, 'Chất liệu: Kim loại, Lớp phủ chống gỉ, Độ bền cao', '2024-01-16');
INSERT INTO `technical_information` VALUES (17, 'Chất liệu: Nhựa tái chế, Độ bền tốt, Bảo vệ môi trường', '2024-01-17');
INSERT INTO `technical_information` VALUES (18, 'Chất liệu: Gỗ, Bề mặt sơn bóng, Mang lại vẻ cao cấp', '2024-01-18');
INSERT INTO `technical_information` VALUES (19, 'Chất liệu: Kim loại, Đính đá, Sang trọng và nổi bật', '2024-01-19');
INSERT INTO `technical_information` VALUES (20, 'Chất liệu: Sừng tự nhiên, Thủ công, Phong cách quý phái', '2024-01-20');
INSERT INTO `technical_information` VALUES (21, 'Nhựa chịu lực, chịu nhiệt độ cao', '2024-06-01');
INSERT INTO `technical_information` VALUES (22, 'Sừng tự nhiên, được xử lý kháng khuẩn', '2024-06-02');
INSERT INTO `technical_information` VALUES (23, 'Tre ép, chống cong vênh', '2024-06-03');
INSERT INTO `technical_information` VALUES (24, 'Vải dệt, không nhăn', '2024-06-04');
INSERT INTO `technical_information` VALUES (25, 'Hợp kim chống gỉ, độ bền cao', '2024-06-05');
INSERT INTO `technical_information` VALUES (26, 'Gỗ sồi tự nhiên, sơn phủ bóng', '2024-06-06');
INSERT INTO `technical_information` VALUES (27, 'Nhựa trong suốt, không ố màu', '2024-06-07');
INSERT INTO `technical_information` VALUES (28, 'Kim loại phủ sơn tĩnh điện', '2024-06-08');
INSERT INTO `technical_information` VALUES (29, 'Vải tái chế, bền và thân thiện môi trường', '2024-06-09');
INSERT INTO `technical_information` VALUES (30, 'Da cao cấp, chống nứt gãy', '2024-06-10');
INSERT INTO `technical_information` VALUES (31, 'Kim loại dập nổi, chống mài mòn', '2024-06-11');
INSERT INTO `technical_information` VALUES (32, 'Gỗ ghép, xử lý chống mối mọt', '2024-06-12');
INSERT INTO `technical_information` VALUES (33, 'Composite, độ bền vượt trội', '2024-06-13');
INSERT INTO `technical_information` VALUES (34, 'Hợp kim nhôm, siêu nhẹ', '2024-06-14');
INSERT INTO `technical_information` VALUES (35, 'Sứ tráng men, chịu lực tốt', '2024-06-15');
INSERT INTO `technical_information` VALUES (36, 'Thép không gỉ, không từ tính', '2024-06-16');
INSERT INTO `technical_information` VALUES (37, 'Đồng cổ điển, bảo vệ chống oxy hóa', '2024-06-17');
INSERT INTO `technical_information` VALUES (38, 'Nhôm anod hóa, độ bền cao', '2024-06-18');
INSERT INTO `technical_information` VALUES (39, 'Bã mía tái chế, thân thiện môi trường', '2024-06-19');
INSERT INTO `technical_information` VALUES (40, 'Carbon siêu nhẹ, chống trầy xước', '2024-06-20');
INSERT INTO `technical_information` VALUES (41, 'Phủ silicon, chống trơn', '2024-06-21');
INSERT INTO `technical_information` VALUES (42, 'Thép mạ vàng, bền đẹp', '2024-06-22');
INSERT INTO `technical_information` VALUES (43, 'Gỗ dừa tự nhiên, không cong vênh', '2024-06-23');
INSERT INTO `technical_information` VALUES (44, 'Da nhân tạo, giá thành rẻ', '2024-06-24');
INSERT INTO `technical_information` VALUES (45, 'Thêu tay, sản phẩm thủ công độc đáo', '2024-06-25');
INSERT INTO `technical_information` VALUES (46, 'Gỗ mun tự nhiên, độ bền cao', '2024-06-26');
INSERT INTO `technical_information` VALUES (47, 'Composite phủ mờ, bề mặt tinh tế', '2024-06-27');
INSERT INTO `technical_information` VALUES (48, 'Vải đính cườm, nghệ thuật độc đáo', '2024-06-28');
INSERT INTO `technical_information` VALUES (49, 'Titan, trọng lượng nhẹ, chịu lực cao', '2024-06-29');
INSERT INTO `technical_information` VALUES (50, 'Sứ họa tiết, phong cách cổ điển', '2024-06-30');
INSERT INTO `technical_information` VALUES (51, 'Chất liệu: Kim loại, Bền bỉ và dễ sử dụng', '2024-01-01');
INSERT INTO `technical_information` VALUES (52, 'Chất liệu: Nhựa trong, Chắc chắn và nhẹ', '2024-01-01');
INSERT INTO `technical_information` VALUES (53, 'Chất liệu: Thép không gỉ, Bền lâu và chống rỉ', '2024-01-01');
INSERT INTO `technical_information` VALUES (54, 'Chất liệu: Cao su, Dẻo dai và bền', '2024-01-01');
INSERT INTO `technical_information` VALUES (55, 'Chất liệu: Nhôm, Bền và chống ăn mòn', '2024-01-01');
INSERT INTO `technical_information` VALUES (56, 'Chất liệu: Nylon, Mềm mại và bền', '2024-01-01');
INSERT INTO `technical_information` VALUES (57, 'Chất liệu: Da thật, Cao cấp và sang trọng', '2024-01-01');
INSERT INTO `technical_information` VALUES (58, 'Chất liệu: Vải cotton, Mềm mại và dễ chịu', '2024-01-01');
INSERT INTO `technical_information` VALUES (59, 'Chất liệu: PVC, Bền và dễ bảo quản', '2024-01-01');
INSERT INTO `technical_information` VALUES (60, 'Chất liệu: Polyester, Dẻo dai và linh hoạt', '2024-01-01');
INSERT INTO `technical_information` VALUES (61, 'Chất liệu: Kim loại, Bền bỉ và chắc chắn', '2024-01-01');
INSERT INTO `technical_information` VALUES (62, 'Chất liệu: Nhựa, Trong suốt và dễ sử dụng', '2024-01-01');
INSERT INTO `technical_information` VALUES (63, 'Chất liệu: Thép, Chống ăn mòn và bền', '2024-01-01');
INSERT INTO `technical_information` VALUES (64, 'Chất liệu: PVC, Dễ sử dụng và bền', '2024-01-01');
INSERT INTO `technical_information` VALUES (65, 'Chất liệu: Da thật, Cao cấp và bền', '2024-01-01');
INSERT INTO `technical_information` VALUES (66, 'Chất liệu: Vải cotton, Bền và mềm mại', '2024-01-01');
INSERT INTO `technical_information` VALUES (67, 'Chất liệu: Nylon, Dẻo dai và bền', '2024-01-01');
INSERT INTO `technical_information` VALUES (68, 'Chất liệu: Nhôm, Chắc chắn và không bị gỉ', '2024-01-01');
INSERT INTO `technical_information` VALUES (69, 'Chất liệu: Thép không gỉ, Chống ăn mòn và bền', '2024-01-01');
INSERT INTO `technical_information` VALUES (70, 'Chất liệu: Polyester, Chắc chắn và linh hoạt', '2024-01-01');
INSERT INTO `technical_information` VALUES (71, 'Chất liệu: Kim loại, Bền bỉ và chắc chắn', '2024-01-01');
INSERT INTO `technical_information` VALUES (72, 'Chất liệu: Nhựa, Nhẹ và dễ sử dụng', '2024-01-01');
INSERT INTO `technical_information` VALUES (73, 'Chất liệu: Thép, Chống ăn mòn và bền', '2024-01-01');
INSERT INTO `technical_information` VALUES (74, 'Chất liệu: Vải dù, Chắc chắn và bền', '2024-01-01');
INSERT INTO `technical_information` VALUES (75, 'Chất liệu: Polyester, Dễ sử dụng và bền bỉ', '2024-01-01');
INSERT INTO `technical_information` VALUES (76, 'Chất liệu: Nhôm, Không bị ăn mòn và chắc chắn', '2024-01-01');
INSERT INTO `technical_information` VALUES (77, 'Chất liệu: Thép, Chất lượng cao và bền', '2024-01-01');
INSERT INTO `technical_information` VALUES (78, 'Chất liệu: Nhựa PVC, Bền và chắc chắn', '2024-01-01');
INSERT INTO `technical_information` VALUES (79, 'Chất liệu: Vải canvas, Mềm mại và bền', '2024-01-01');
INSERT INTO `technical_information` VALUES (80, 'Chất liệu: Nhựa silicone, Linh hoạt và bền bỉ', '2024-01-01');
INSERT INTO `technical_information` VALUES (81, 'Chất liệu: Nylon, Độ bền cao', '2024-01-01');
INSERT INTO `technical_information` VALUES (82, 'Chất liệu: Nylon, Chống thấm nước', '2024-01-01');
INSERT INTO `technical_information` VALUES (83, 'Chất liệu: Kim loại, Mạ bạc', '2024-01-01');
INSERT INTO `technical_information` VALUES (84, 'Chất liệu: Nylon, Thiết kế ẩn', '2024-01-01');
INSERT INTO `technical_information` VALUES (85, 'Chất liệu: Nylon, Hai chiều', '2024-01-01');
INSERT INTO `technical_information` VALUES (86, 'Chất liệu: Nylon, Dành cho thể thao', '2024-01-01');
INSERT INTO `technical_information` VALUES (87, 'Chất liệu: Dạ quang, Phát sáng', '2024-01-01');
INSERT INTO `technical_information` VALUES (88, 'Chất liệu: Chống cháy, An toàn', '2024-01-01');
INSERT INTO `technical_information` VALUES (89, 'Chất liệu: Nylon, Siêu mỏng', '2024-01-01');
INSERT INTO `technical_information` VALUES (90, 'Chất liệu: Nylon, Phong cách cổ điển', '2024-01-01');
INSERT INTO `technical_information` VALUES (91, 'Chất liệu: Nhựa, Đa năng', '2024-01-01');
INSERT INTO `technical_information` VALUES (92, 'Chất liệu: Kim loại, Tự động khóa', '2024-01-01');
INSERT INTO `technical_information` VALUES (93, 'Chất liệu: Nylon, Siêu nhẹ', '2024-01-01');
INSERT INTO `technical_information` VALUES (94, 'Chất liệu: Nylon, Dành cho vali', '2024-01-01');
INSERT INTO `technical_information` VALUES (95, 'Chất liệu: Nhựa, Dành cho túi xách', '2024-01-01');
INSERT INTO `technical_information` VALUES (96, 'Chất liệu: Kim loại cao cấp', '2024-01-01');
INSERT INTO `technical_information` VALUES (97, 'Chất liệu: Kim loại chống rỉ', '2024-01-01');
INSERT INTO `technical_information` VALUES (98, 'Chất liệu: Nylon, Chống bụi', '2024-01-01');
INSERT INTO `technical_information` VALUES (99, 'Chất liệu: Nhựa, Chuyên dụng cho giày', '2024-01-01');
INSERT INTO `technical_information` VALUES (100, 'Chất liệu: Nylon thời trang', '2024-01-01');
INSERT INTO `technical_information` VALUES (101, 'Vải bông mềm mại, dễ thấm hút mồ hôi', '2024-01-01');
INSERT INTO `technical_information` VALUES (102, 'Vải lanh thoáng mát, nhẹ nhàng', '2024-01-02');
INSERT INTO `technical_information` VALUES (103, 'Vải lụa mềm mại, bóng đẹp', '2024-01-03');
INSERT INTO `technical_information` VALUES (104, 'Vải len dày, ấm áp', '2024-01-04');
INSERT INTO `technical_information` VALUES (105, 'Vải polyester bền, không bị nhăn', '2024-01-05');
INSERT INTO `technical_information` VALUES (106, 'Vải nilon nhẹ, chống thấm nước', '2024-01-06');
INSERT INTO `technical_information` VALUES (107, 'Vải bò chắc chắn, thời trang', '2024-01-07');
INSERT INTO `technical_information` VALUES (108, 'Vải satin mềm mại, bóng mượt', '2024-01-08');
INSERT INTO `technical_information` VALUES (109, 'Vải nhung êm ái, sang trọng', '2024-01-09');
INSERT INTO `technical_information` VALUES (110, 'Vải chiffon mỏng manh, nhẹ nhàng', '2024-01-10');
INSERT INTO `technical_information` VALUES (111, 'Vải taffeta bóng, cứng cáp', '2024-01-11');
INSERT INTO `technical_information` VALUES (112, 'Vải voan mỏng, nhẹ nhàng', '2024-01-12');
INSERT INTO `technical_information` VALUES (113, 'Vải nỉ ấm áp, thích hợp mùa đông', '2024-01-13');
INSERT INTO `technical_information` VALUES (114, 'Vải flannel dày, mềm', '2024-01-14');
INSERT INTO `technical_information` VALUES (115, 'Vải nhung kẻ, sang trọng', '2024-01-15');
INSERT INTO `technical_information` VALUES (116, 'Vải da lộn mềm mịn, cao cấp', '2024-01-16');
INSERT INTO `technical_information` VALUES (117, 'Vải da bền, chắc chắn', '2024-01-17');
INSERT INTO `technical_information` VALUES (118, 'Vải cashmere ấm áp, mềm mại', '2024-01-18');
INSERT INTO `technical_information` VALUES (119, 'Vải brocade thêu hoa văn sang trọng', '2024-01-19');
INSERT INTO `technical_information` VALUES (120, 'Vải jersey co giãn, thoải mái', '2024-01-20');
INSERT INTO `technical_information` VALUES (121, 'Vải tweed dày, bền', '2024-01-21');
INSERT INTO `technical_information` VALUES (122, 'Vải gabardine bền, chống nhăn', '2024-01-22');
INSERT INTO `technical_information` VALUES (123, 'Vải organza mỏng, trong suốt', '2024-01-23');
INSERT INTO `technical_information` VALUES (124, 'Vải houndstooth họa tiết kẻ sọc', '2024-01-24');
INSERT INTO `technical_information` VALUES (125, 'Vải georgette mềm mại', '2024-01-25');
INSERT INTO `technical_information` VALUES (126, 'Vải peachskin mịn màng, nhẹ', '2024-01-26');
INSERT INTO `technical_information` VALUES (127, 'Vải spandex co giãn, ôm sát', '2024-01-27');
INSERT INTO `technical_information` VALUES (128, 'Vải lycra co giãn, thoải mái', '2024-01-28');
INSERT INTO `technical_information` VALUES (129, 'Vải rayon nhẹ, thoáng mát', '2024-01-29');
INSERT INTO `technical_information` VALUES (130, 'Vải viscose mềm, dễ mặc', '2024-01-30');
INSERT INTO `technical_information` VALUES (131, 'Vải canvas dày, chắc chắn', '2024-01-31');
INSERT INTO `technical_information` VALUES (132, 'Vải muslin mỏng, nhẹ', '2024-02-01');
INSERT INTO `technical_information` VALUES (133, 'Vải thô cứng, bền', '2024-02-02');
INSERT INTO `technical_information` VALUES (134, 'Vải chambray mềm mại', '2024-02-03');
INSERT INTO `technical_information` VALUES (135, 'Vải shantung cứng, bóng', '2024-02-04');
INSERT INTO `technical_information` VALUES (136, 'Vải moleskin mềm mịn', '2024-02-05');
INSERT INTO `technical_information` VALUES (137, 'Vải seersucker nhẹ, co giãn', '2024-02-06');
INSERT INTO `technical_information` VALUES (138, 'Vải in sáp họa tiết sắc nét', '2024-02-07');
INSERT INTO `technical_information` VALUES (139, 'Denim co giãn, dễ mặc', '2024-02-08');
INSERT INTO `technical_information` VALUES (140, 'Vải tulle mỏng, nhẹ', '2024-02-09');
INSERT INTO `technical_information` VALUES (141, 'Vải taffeta bóng, chắc chắn', '2024-02-10');
INSERT INTO `technical_information` VALUES (142, 'Vải boucle mềm, bền', '2024-02-11');
INSERT INTO `technical_information` VALUES (143, 'Vải herringbone với họa tiết xương cá', '2024-02-12');
INSERT INTO `technical_information` VALUES (144, 'Vải khaki bền, chắc chắn', '2024-02-13');
INSERT INTO `technical_information` VALUES (145, 'Vải oxford dày, thoáng khí', '2024-02-14');
INSERT INTO `technical_information` VALUES (146, 'Vải pique bền, có cấu trúc', '2024-02-15');
INSERT INTO `technical_information` VALUES (147, 'Vải gabardine co giãn, dễ di chuyển', '2024-02-16');
INSERT INTO `technical_information` VALUES (148, 'Vải spandex satin có độ bóng', '2024-02-17');
INSERT INTO `technical_information` VALUES (149, 'Vải linen mát mẻ, thoáng khí', '2024-02-18');
INSERT INTO `technical_information` VALUES (150, 'Vải voile nhẹ nhàng, mềm mại', '2024-02-19');
INSERT INTO `technical_information` VALUES (151, 'Vải gấm cao cấp, dày dặn, chống nhăn.', '2024-01-01');
INSERT INTO `technical_information` VALUES (152, 'Vải linen tự nhiên, thoáng khí, bền đẹp.', '2024-02-15');
INSERT INTO `technical_information` VALUES (153, 'Vải thun cotton, co giãn, dễ chăm sóc.', '2024-03-10');
INSERT INTO `technical_information` VALUES (154, 'Vải bố dày, chống xước, thích hợp cho thảm.', '2024-04-01');
INSERT INTO `technical_information` VALUES (155, 'Vải gấm, họa tiết sang trọng, dễ dàng vệ sinh.', '2024-05-05');
INSERT INTO `technical_information` VALUES (156, 'Vải nhung, mềm mại, có khả năng cách nhiệt.', '2024-06-12');
INSERT INTO `technical_information` VALUES (157, 'Vải lụa, bóng mượt, dễ giặt khô.', '2024-07-03');
INSERT INTO `technical_information` VALUES (158, 'Vải bông, thấm hút tốt, không bị xù lông.', '2024-08-19');
INSERT INTO `technical_information` VALUES (159, 'Vải thun co giãn, bền đẹp với thời gian.', '2024-09-10');
INSERT INTO `technical_information` VALUES (160, 'Vải gấm cao cấp, chống cháy, dễ làm sạch.', '2024-10-22');
INSERT INTO `technical_information` VALUES (161, 'Vải thun, co giãn tuyệt vời, thân thiện với người sử dụng.', '2024-11-15');
INSERT INTO `technical_information` VALUES (162, 'Vải lanh, mát mẻ, dễ giặt và bảo quản.', '2024-12-01');
INSERT INTO `technical_information` VALUES (163, 'Vải bố, bền chắc, dễ dàng giặt bằng tay.', '2024-12-10');
INSERT INTO `technical_information` VALUES (164, 'Vải len, giữ nhiệt tốt, mềm mại cho mùa đông.', '2024-12-20');
INSERT INTO `technical_information` VALUES (165, 'Vải cotton, thoáng khí, dễ dàng giặt máy.', '2024-01-05');
INSERT INTO `technical_information` VALUES (166, 'Vải taffeta, chất liệu bóng, thích hợp cho trang trí sang trọng.', '2024-02-10');
INSERT INTO `technical_information` VALUES (167, 'Vải spandex, co giãn mạnh, không nhăn khi sử dụng.', '2024-03-25');
INSERT INTO `technical_information` VALUES (168, 'Vải dạ, dày dặn, giữ nhiệt tốt cho mùa lạnh.', '2024-04-15');
INSERT INTO `technical_information` VALUES (169, 'Vải satin, bóng mượt, mang lại vẻ đẹp sang trọng.', '2024-05-18');
INSERT INTO `technical_information` VALUES (170, 'Vải thô, dễ chịu, không bị co rút sau khi giặt.', '2024-06-30');
INSERT INTO `technical_information` VALUES (171, 'Chất liệu mềm mại, dễ dàng tạo các kiểu dáng trang trí.', '2024-11-10');
INSERT INTO `technical_information` VALUES (172, 'Vải sợi tổng hợp bền đẹp, chịu lực tốt, dễ dàng vệ sinh.', '2024-10-15');
INSERT INTO `technical_information` VALUES (173, 'Chất liệu vải chéo bền bỉ, chống nhăn, dễ dàng giặt sạch.', '2024-11-01');
INSERT INTO `technical_information` VALUES (174, 'Vải bọc đệm có độ bền cao, chống xơ và dễ dàng làm sạch.', '2024-09-20');
INSERT INTO `technical_information` VALUES (175, 'Vải sợi bông tự nhiên, thân thiện với môi trường, dễ giặt và bảo quản.', '2024-10-10');
INSERT INTO `technical_information` VALUES (176, 'Chất liệu vải mềm mại, dễ dàng làm sạch và bảo dưỡng.', '2024-11-05');
INSERT INTO `technical_information` VALUES (177, 'Chất liệu da bền bỉ, thích hợp cho các thảm sang trọng trong không gian nội thất.', '2024-10-30');
INSERT INTO `technical_information` VALUES (178, 'Vải thảm len dày dặn, bền đẹp và dễ dàng vệ sinh.', '2024-10-25');
INSERT INTO `technical_information` VALUES (179, 'Vải sợi bông dệt thô, không gây kích ứng da, thích hợp cho trang trí nhẹ nhàng.', '2024-11-12');
INSERT INTO `technical_information` VALUES (180, 'Vải cotton pha polyester, mềm mại, dễ bảo quản và giặt sạch.', '2024-11-18');
INSERT INTO `technical_information` VALUES (181, '157', '2025-05-26');

-- ----------------------------
-- Table structure for user_keys
-- ----------------------------
DROP TABLE IF EXISTS `user_keys`;
CREATE TABLE `user_keys`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `public_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `user_keys_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_keys
-- ----------------------------
INSERT INTO `user_keys` VALUES (1, 8, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjX8NKh2EAsLY5xqlxwTmQ30AWEL2vcBltfLIjqlFbgZ2rsX/Rr30DIZ6pPwQtNc5idqGoAHJxz002EJkOXascPIE8TQ8i1C2t+TrXVpU44YatqsC3caXB0bfKFs22suoZlgNVwyCDb6SiniY+Njnx7NVX0UUltk53EFkGIDPalwxZX267M3b6rpVzP+g5JhjIoJfLXux6eN09a2zktb', NULL);
INSERT INTO `user_keys` VALUES (2, 13, 'sample_public_key_for_testing', '2025-05-29 12:28:06');
INSERT INTO `user_keys` VALUES (3, 14, 'sample_public_key', '2025-05-29 12:28:25');
INSERT INTO `user_keys` VALUES (4, 15, 'sample_public_key', '2025-05-29 12:32:16');
INSERT INTO `user_keys` VALUES (5, 8, 'public key test', NULL);
INSERT INTO `user_keys` VALUES (8, 16, 'sample_public_key', '2025-05-29 21:23:07');
INSERT INTO `user_keys` VALUES (9, 11, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjX8NKh2EAsLY5xqlxwTmQ30AWEL2vcBltfLIjqlFbgZ2rsX/Rr30DIZ6pPwQtNc5idqGoAHJxz002EJkOXascPIE8TQ8i1C2t+TrXVpU44YatqsC3caXB0bfKFs22suoZlgNVwyCDb6SiniY+Njnx7NVX0UUltk53EFkGIDPalwxZX267M3b6rpVzP+g5JhjIoJfLXux6eN09a2zktb', '2025-05-29 21:33:58');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `fullName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phoneNumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `idAddress` int(11) NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idAddress`(`idAddress`) USING BTREE,
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`idAddress`) REFERENCES `addresses` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'nguyenanh@gmail.com', 'Nguyễn Văn Anh', '0912345678', 1, 'https://www.google.com/imgres?q=avatar%20fb&imgurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Fwp-content%2Fuploads%2F2023%2F10%2Favatar-trang-4.jpg&imgrefurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Favatar-trang&docid=l8Ud2gDyur0xUM&tbnid=9ELtMP6ldyeR8M');
INSERT INTO `users` VALUES (2, 'lethihanh@gmail.com', 'Lê Thị Hạnh', '0987654321', 2, 'https://www.google.com/imgres?q=avatar%20fb&imgurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Fwp-content%2Fuploads%2F2023%2F10%2Favatar-trang-4.jpg&imgrefurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Favatar-trang&docid=l8Ud2gDyur0xUM&tbnid=9ELtMP6ldyeR8M');
INSERT INTO `users` VALUES (3, 'tranvanbinh@gmail.com', 'Trần Văn Bình', '0934567890', 3, 'https://www.google.com/imgres?q=avatar%20fb&imgurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Fwp-content%2Fuploads%2F2023%2F10%2Favatar-trang-4.jpg&imgrefurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Favatar-trang&docid=l8Ud2gDyur0xUM&tbnid=9ELtMP6ldyeR8M');
INSERT INTO `users` VALUES (4, 'phamthuy@gmail.com', 'Phạm Thị Thúy', '0978123456', 4, 'https://www.google.com/imgres?q=avatar%20fb&imgurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Fwp-content%2Fuploads%2F2023%2F10%2Favatar-trang-4.jpg&imgrefurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Favatar-trang&docid=l8Ud2gDyur0xUM&tbnid=9ELtMP6ldyeR8M');
INSERT INTO `users` VALUES (5, 'hoangminhtuan@gmail.com', 'Hoàng Minh Tuấn', '0923456789', 5, 'https://www.google.com/imgres?q=avatar%20fb&imgurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Fwp-content%2Fuploads%2F2023%2F10%2Favatar-trang-4.jpg&imgrefurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Favatar-trang&docid=l8Ud2gDyur0xUM&tbnid=9ELtMP6ldyeR8M');
INSERT INTO `users` VALUES (6, 'dinhphuong@gmail.com', 'Đinh Thị Phượng', '0945678901', 6, 'https://www.google.com/imgres?q=avatar%20fb&imgurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Fwp-content%2Fuploads%2F2023%2F10%2Favatar-trang-4.jpg&imgrefurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Favatar-trang&docid=l8Ud2gDyur0xUM&tbnid=9ELtMP6ldyeR8M');
INSERT INTO `users` VALUES (7, 'votienthanh@gmail.com', 'Võ Tiến Thành', '0967890123', 7, 'https://www.google.com/imgres?q=avatar%20fb&imgurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Fwp-content%2Fuploads%2F2023%2F10%2Favatar-trang-4.jpg&imgrefurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Favatar-trang&docid=l8Ud2gDyur0xUM&tbnid=9ELtMP6ldyeR8M');
INSERT INTO `users` VALUES (8, 'ngothithao@gmail.com', 'Ngô Thị Thảo', '0901234567', 8, 'https://www.google.com/imgres?q=avatar%20fb&imgurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Fwp-content%2Fuploads%2F2023%2F10%2Favatar-trang-4.jpg&imgrefurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Favatar-trang&docid=l8Ud2gDyur0xUM&tbnid=9ELtMP6ldyeR8M');
INSERT INTO `users` VALUES (9, 'phamvangiang@gmail.com', 'Phạm Văn Giang', '0919876543', 9, 'https://www.google.com/imgres?q=avatar%20fb&imgurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Fwp-content%2Fuploads%2F2023%2F10%2Favatar-trang-4.jpg&imgrefurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Favatar-trang&docid=l8Ud2gDyur0xUM&tbnid=9ELtMP6ldyeR8M');
INSERT INTO `users` VALUES (10, 'tranthuthuy@gmail.com', 'Trần Thu Thủy', '0921098765', 10, 'https://www.google.com/imgres?q=avatar%20fb&imgurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Fwp-content%2Fuploads%2F2023%2F10%2Favatar-trang-4.jpg&imgrefurl=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Favatar-trang&docid=l8Ud2gDyur0xUM&tbnid=9ELtMP6ldyeR8M');
INSERT INTO `users` VALUES (11, 'phanhoang03505@gmail.com', 'PHAN VĂN HOÀNG', '0335059497', 1, 'default.png');
INSERT INTO `users` VALUES (12, 'testuser@example.com', 'Test User', '1234567890', 11, 'sample_image_url');
INSERT INTO `users` VALUES (13, 'userkeytest@example.com', 'User Key Test', '0987123456', 12, 'sample_userkey_image.png');
INSERT INTO `users` VALUES (14, 'testuser@example.com', 'Test User', '1234567890', 13, 'sample_image_url');
INSERT INTO `users` VALUES (15, 'testuser@example.com', 'Test User', '1234567890', 14, 'sample_image_url');
INSERT INTO `users` VALUES (16, 'testuser@example.com', 'Test User', '1234567890', 15, 'sample_image_url');

-- ----------------------------
-- Table structure for vouchers
-- ----------------------------
DROP TABLE IF EXISTS `vouchers`;
CREATE TABLE `vouchers`  (
  `idVoucher` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double NOT NULL,
  `condition_amount` double NOT NULL,
  PRIMARY KEY (`idVoucher`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vouchers
-- ----------------------------
INSERT INTO `vouchers` VALUES (1, 'VOUCHER01', 100000, 500000);
INSERT INTO `vouchers` VALUES (2, 'VOUCHER02', 20000, 200000);
INSERT INTO `vouchers` VALUES (3, 'VOUCHER03', 150000, 750000);
INSERT INTO `vouchers` VALUES (4, 'VOUCHER04', 300000, 1500000);
INSERT INTO `vouchers` VALUES (5, 'VOUCHER05', 250000, 1000000);

SET FOREIGN_KEY_CHECKS = 1;
