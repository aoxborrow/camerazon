# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.10)
# Database: camerazon
# Generation Time: 2013-07-12 18:41:33 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table products
# ------------------------------------------------------------

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `product_type` varchar(255) DEFAULT NULL,
  `vendor` varchar(255) DEFAULT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `body_html` text,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;

INSERT INTO `products` (`id`, `product_id`, `created_at`, `updated_at`, `product_type`, `vendor`, `handle`, `title`, `body_html`)
VALUES
	(1,147064802,1373595274,1373624394,'Lenses','camazon','canon-normal-lens','Canon Normal Lens','<p><span>Large aperture allows the user to shoot hand held in almost any lighting situation.</span></p>'),
	(2,147065960,1373595758,1373624583,'Lenses','camazon','canon-zoom-lens','Canon Zoom Lens','<p><span>One of the most acclaimed lenses in the Canonline, with superior performance, increased speed and optical quality.</span></p>'),
	(3,147065457,1373595535,1373624456,'Lenses','camazon','canon-telephoto-lens','Canon Telephoto Lens','<p><span>When it comes to indoor sports or low-light, handheld shooting, this is as good as it gets!</span></p>'),
	(4,147064154,1373594833,1373624520,'Lenses','camerazon','canon-wide-angle-lens','Canon Wide Angle Lens','<p><span>Delivering high-quality images with excellent detail.</span></p>'),
	(6,147134386,1373653752,1373653752,'Randoms','Camerazon','amazing-random-product-125','Amazing Random Product #125','Really Great Product #125'),
	(7,147134366,1373653746,1373653746,'Randoms','Camerazon','amazing-random-product-181','Amazing Random Product #181','Really Great Product #181'),
	(8,147134369,1373653747,1373653747,'Randoms','Camerazon','amazing-random-product-223','Amazing Random Product #223','Really Great Product #223'),
	(9,147134569,1373653811,1373653811,'Randoms','Camerazon','amazing-random-product-241','Amazing Random Product #241','Really Great Product #241'),
	(10,147134395,1373653755,1373653755,'Randoms','Camerazon','amazing-random-product-356','Amazing Random Product #356','Really Great Product #356'),
	(11,147134114,1373653663,1373653664,'Randoms','Camerazon','amazing-random-product-436','Amazing Random Product #436','Really Great Product #436'),
	(12,147134373,1373653748,1373653748,'Randoms','Camerazon','amazing-random-product-467','Amazing Random Product #467','Really Great Product #467'),
	(13,147134116,1373653665,1373653665,'Randoms','Camerazon','amazing-random-product-585','Amazing Random Product #585','Really Great Product #585'),
	(14,147134382,1373653751,1373653751,'Randoms','Camerazon','amazing-random-product-611','Amazing Random Product #611','Really Great Product #611'),
	(15,147134571,1373653812,1373653813,'Randoms','Camerazon','amazing-random-product-617','Amazing Random Product #617','Really Great Product #617'),
	(16,147134378,1373653750,1373653750,'Randoms','Camerazon','amazing-random-product-643','Amazing Random Product #643','Really Great Product #643'),
	(17,147134407,1373653758,1373653759,'Randoms','Camerazon','amazing-random-product-707','Amazing Random Product #707','Really Great Product #707'),
	(18,147134398,1373653756,1373653756,'Randoms','Camerazon','amazing-random-product-729','Amazing Random Product #729','Really Great Product #729'),
	(19,147134363,1373653745,1373653745,'Randoms','Camerazon','amazing-random-product-807','Amazing Random Product #807','Really Great Product #807'),
	(20,147134391,1373653754,1373653754,'Randoms','Camerazon','amazing-random-product-946','Amazing Random Product #946','Really Great Product #946'),
	(21,147134404,1373653757,1373653757,'Randoms','Camerazon','amazing-random-product-966','Amazing Random Product #966','Really Great Product #966');

/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table products_images
# ------------------------------------------------------------

DROP TABLE IF EXISTS `products_images`;

CREATE TABLE `products_images` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `image_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `position` int(5) DEFAULT NULL,
  `src` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `image_id` (`image_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table products_variants
# ------------------------------------------------------------

DROP TABLE IF EXISTS `products_variants`;

CREATE TABLE `products_variants` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `position` int(5) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `option1` varchar(255) DEFAULT NULL,
  `option2` varchar(255) DEFAULT NULL,
  `option3` varchar(255) DEFAULT NULL,
  `inventory_quantity` int(11) DEFAULT NULL,
  `price` decimal(11,2) DEFAULT NULL,
  `grams` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `variant_id` (`variant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8;

LOCK TABLES `products_variants` WRITE;
/*!40000 ALTER TABLE `products_variants` DISABLE KEYS */;

INSERT INTO `products_variants` (`id`, `product_id`, `variant_id`, `created_at`, `updated_at`, `position`, `title`, `sku`, `option1`, `option2`, `option3`, `inventory_quantity`, `price`, `grams`)
VALUES
	(39,147064802,335858738,1373595274,1373624350,1,'35mm / Black / EF','canon-normal-1','35mm','Black','EF',23,200.00,227.00),
	(40,147064802,335858739,1373595274,1373624394,2,'40mm / Black / EF-S','canon-normal-2','40mm','Black','EF-S',10,200.00,227.00),
	(41,147064802,335858740,1373595274,1373624350,3,'50mm / Black / EF','canon-normal-3','50mm','Black','EF',10,200.00,227.00),
	(42,147064802,335858741,1373595274,1373624394,4,'55mm / Black / EF-S','canon-normal-4','55mm','Black','EF-S',10,200.00,227.00),
	(43,147065457,335860241,1373595535,1373624441,1,'85mm / Black / EF','canon-telephoto-1','85mm','Black','EF',10,300.00,454.00),
	(44,147065457,335860242,1373595535,1373624456,2,'100mm / Black / EF-S','canon-telephoto-2','100mm','Black','EF-S',10,300.00,454.00),
	(45,147065457,335860243,1373595535,1373624456,3,'120mm / Black / EF-S','canon-telephoto-3','120mm','Black','EF-S',10,300.00,454.00),
	(46,147065457,335860244,1373595535,1373624441,4,'150mm / White / EF','canon-telephoto-4','150mm','White','EF',10,300.00,454.00),
	(47,147065457,335860245,1373595535,1373624441,5,'200mm / White / EF','canon-telephoto-5','200mm','White','EF',10,300.00,454.00),
	(48,147065457,335860246,1373595535,1373624441,6,'300mm / White / EF','canon-telephoto-6','300mm','White','EF',10,300.00,454.00),
	(49,147064154,335856665,1373594833,1373624512,1,'18mm / White / EF','canon-wide-1','18mm','White','EF',10,100.00,227.00),
	(50,147064154,335856666,1373594833,1373624512,2,'20mm / Black / EF','canon-wide-2','20mm','Black','EF',10,100.00,227.00),
	(51,147064154,335856667,1373594833,1373624512,3,'24mm / Black / EF','canon-wide-3','24mm','Black','EF',10,100.00,227.00),
	(52,147064154,335856668,1373594833,1373624512,4,'28mm / Black / EF','canon-wide-4','28mm','Black','EF',10,100.00,227.00),
	(53,147064154,335856669,1373594833,1373624517,5,'32mm / Black / EF-S','canon-wide-5','32mm','Black','EF-S',10,100.00,227.00),
	(54,147065960,335861573,1373595758,1373624571,1,'16-40mm / Black / EF','canon-zoom-1','16-40mm','Black','EF',10,500.00,680.00),
	(55,147065960,335861574,1373595758,1373624583,2,'18-55mm / Black / EF-S','canon-zoom-2','18-55mm','Black','EF-S',10,500.00,680.00),
	(56,147065960,335861575,1373595758,1373624571,3,'24-70mm / Black / EF','canon-zoom-3','24-70mm','Black','EF',10,500.00,680.00),
	(57,147065960,335861576,1373595758,1373624583,4,'70-200mm / Black / EF-S','canon-zoom-4','70-200mm','Black','EF-S',10,500.00,680.00),
	(58,147065960,335861577,1373595758,1373624571,5,'200-400mm / Black / EF','canon-zoom-5','200-400mm','Black','EF',10,500.00,680.00),
	(59,147134386,336032472,1373653752,1373653752,1,'Green / Child','randoms-784','Green','Child',NULL,1,50.00,0.00),
	(60,147134386,336032473,1373653752,1373653752,2,'Blue / Medium','randoms-414','Blue','Medium',NULL,1,93.00,0.00),
	(61,147134386,336032474,1373653752,1373653752,3,'Purple / Small','randoms-395','Purple','Small',NULL,1,65.00,0.00),
	(62,147134386,336032475,1373653752,1373653752,4,'Red / Large','randoms-388','Red','Large',NULL,1,25.00,0.00),
	(63,147134386,336032476,1373653752,1373653752,5,'Black / X-Large','randoms-377','Black','X-Large',NULL,1,89.00,0.00),
	(64,147134366,336032427,1373653746,1373653746,1,'Blue / Small','randoms-484','Blue','Small',NULL,1,36.00,0.00),
	(65,147134366,336032428,1373653746,1373653746,2,'Red / Large','randoms-154','Red','Large',NULL,1,68.00,0.00),
	(66,147134366,336032429,1373653746,1373653746,3,'Green / Child','randoms-660','Green','Child',NULL,1,59.00,0.00),
	(67,147134366,336032431,1373653746,1373653746,4,'Purple / X-Large','randoms-364','Purple','X-Large',NULL,1,40.00,0.00),
	(68,147134366,336032432,1373653746,1373653746,5,'Black / Medium','randoms-604','Black','Medium',NULL,1,29.00,0.00),
	(69,147134369,336032434,1373653747,1373653747,1,'Purple / Small','randoms-444','Purple','Small',NULL,1,79.00,0.00),
	(70,147134369,336032435,1373653747,1373653747,2,'Green / Child','randoms-421','Green','Child',NULL,1,81.00,0.00),
	(71,147134369,336032436,1373653747,1373653747,3,'Blue / Medium','randoms-133','Blue','Medium',NULL,1,48.00,0.00),
	(72,147134369,336032437,1373653747,1373653747,4,'Red / X-Large','randoms-471','Red','X-Large',NULL,1,40.00,0.00),
	(73,147134369,336032438,1373653747,1373653747,5,'Black / Large','randoms-371','Black','Large',NULL,1,86.00,0.00),
	(74,147134569,336032743,1373653811,1373653811,1,'Red / Large','randoms-267','Red','Large',NULL,1,65.00,0.00),
	(75,147134569,336032744,1373653811,1373653811,2,'Black / X-Large','randoms-895','Black','X-Large',NULL,1,32.00,0.00),
	(76,147134569,336032745,1373653811,1373653811,3,'Purple / Small','randoms-697','Purple','Small',NULL,1,66.00,0.00),
	(77,147134569,336032746,1373653811,1373653811,4,'Green / Medium','randoms-188','Green','Medium',NULL,1,31.00,0.00),
	(78,147134569,336032748,1373653811,1373653811,5,'Blue / Child','randoms-699','Blue','Child',NULL,1,72.00,0.00),
	(79,147134395,336032490,1373653755,1373653755,1,'Green / X-Large','randoms-374','Green','X-Large',NULL,1,92.00,0.00),
	(80,147134395,336032491,1373653755,1373653755,2,'Purple / Small','randoms-772','Purple','Small',NULL,1,44.00,0.00),
	(81,147134395,336032492,1373653755,1373653755,3,'Blue / Medium','randoms-319','Blue','Medium',NULL,1,89.00,0.00),
	(82,147134395,336032493,1373653755,1373653755,4,'Black / Large','randoms-467','Black','Large',NULL,1,42.00,0.00),
	(83,147134395,336032494,1373653755,1373653755,5,'Red / Child','randoms-803','Red','Child',NULL,1,95.00,0.00),
	(84,147134114,336032043,1373653664,1373653664,1,'Red / X-Large','randoms-856','Red','X-Large',NULL,1,27.00,0.00),
	(85,147134114,336032044,1373653664,1373653664,2,'Green / Child','randoms-823','Green','Child',NULL,1,46.00,0.00),
	(86,147134114,336032045,1373653664,1373653664,3,'Blue / Small','randoms-495','Blue','Small',NULL,1,64.00,0.00),
	(87,147134114,336032046,1373653664,1373653664,4,'Purple / Medium','randoms-887','Purple','Medium',NULL,1,94.00,0.00),
	(88,147134114,336032047,1373653664,1373653664,5,'Black / Large','randoms-195','Black','Large',NULL,1,72.00,0.00),
	(89,147134373,336032442,1373653748,1373653748,1,'Blue / Small','randoms-764','Blue','Small',NULL,1,23.00,0.00),
	(90,147134373,336032443,1373653748,1373653748,2,'Black / Medium','randoms-444','Black','Medium',NULL,1,34.00,0.00),
	(91,147134373,336032444,1373653748,1373653748,3,'Green / Child','randoms-350','Green','Child',NULL,1,83.00,0.00),
	(92,147134373,336032445,1373653748,1373653748,4,'Purple / Large','randoms-588','Purple','Large',NULL,1,29.00,0.00),
	(93,147134373,336032446,1373653748,1373653748,5,'Red / X-Large','randoms-228','Red','X-Large',NULL,1,35.00,0.00),
	(94,147134116,336032050,1373653665,1373653665,1,'Blue / Small','randoms-767','Blue','Small',NULL,1,94.00,0.00),
	(95,147134116,336032051,1373653665,1373653665,2,'Black / Medium','randoms-319','Black','Medium',NULL,1,77.00,0.00),
	(96,147134116,336032052,1373653665,1373653665,3,'Red / X-Large','randoms-454','Red','X-Large',NULL,1,96.00,0.00),
	(97,147134116,336032053,1373653665,1373653665,4,'Purple / Child','randoms-561','Purple','Child',NULL,1,95.00,0.00),
	(98,147134116,336032054,1373653665,1373653665,5,'Green / Large','randoms-550','Green','Large',NULL,1,66.00,0.00),
	(99,147134382,336032465,1373653751,1373653751,1,'Blue / Large','randoms-944','Blue','Large',NULL,1,31.00,0.00),
	(100,147134382,336032467,1373653751,1373653751,2,'Purple / Small','randoms-462','Purple','Small',NULL,1,89.00,0.00),
	(101,147134382,336032468,1373653751,1373653751,3,'Red / Medium','randoms-192','Red','Medium',NULL,1,75.00,0.00),
	(102,147134382,336032469,1373653751,1373653751,4,'Green / X-Large','randoms-838','Green','X-Large',NULL,1,53.00,0.00),
	(103,147134382,336032470,1373653751,1373653751,5,'Black / Child','randoms-450','Black','Child',NULL,1,23.00,0.00),
	(104,147134571,336032749,1373653812,1373653812,1,'Black / Large','randoms-284','Black','Large',NULL,1,23.00,0.00),
	(105,147134571,336032750,1373653812,1373653812,2,'Red / Small','randoms-646','Red','Small',NULL,1,90.00,0.00),
	(106,147134571,336032751,1373653812,1373653812,3,'Green / X-Large','randoms-104','Green','X-Large',NULL,1,42.00,0.00),
	(107,147134571,336032752,1373653812,1373653812,4,'Blue / Medium','randoms-972','Blue','Medium',NULL,1,62.00,0.00),
	(108,147134571,336032755,1373653812,1373653812,5,'Purple / Child','randoms-831','Purple','Child',NULL,1,100.00,0.00),
	(109,147134378,336032457,1373653750,1373653750,1,'Black / Large','randoms-572','Black','Large',NULL,1,70.00,0.00),
	(110,147134378,336032458,1373653750,1373653750,2,'Blue / Small','randoms-409','Blue','Small',NULL,1,64.00,0.00),
	(111,147134378,336032459,1373653750,1373653750,3,'Red / Child','randoms-184','Red','Child',NULL,1,74.00,0.00),
	(112,147134378,336032460,1373653750,1373653750,4,'Purple / Medium','randoms-276','Purple','Medium',NULL,1,24.00,0.00),
	(113,147134378,336032461,1373653750,1373653750,5,'Green / X-Large','randoms-357','Green','X-Large',NULL,1,28.00,0.00),
	(114,147134407,336032515,1373653758,1373653758,1,'Black / Child','randoms-538','Black','Child',NULL,1,67.00,0.00),
	(115,147134407,336032516,1373653759,1373653759,2,'Purple / X-Large','randoms-416','Purple','X-Large',NULL,1,81.00,0.00),
	(116,147134407,336032517,1373653759,1373653759,3,'Green / Medium','randoms-371','Green','Medium',NULL,1,24.00,0.00),
	(117,147134407,336032518,1373653759,1373653759,4,'Blue / Small','randoms-356','Blue','Small',NULL,1,90.00,0.00),
	(118,147134407,336032519,1373653759,1373653759,5,'Red / Large','randoms-259','Red','Large',NULL,1,26.00,0.00),
	(119,147134398,336032497,1373653756,1373653756,1,'Red / Child','randoms-955','Red','Child',NULL,1,71.00,0.00),
	(120,147134398,336032498,1373653756,1373653756,2,'Blue / X-Large','randoms-572','Blue','X-Large',NULL,1,62.00,0.00),
	(121,147134398,336032499,1373653756,1373653756,3,'Green / Medium','randoms-343','Green','Medium',NULL,1,72.00,0.00),
	(122,147134398,336032500,1373653756,1373653756,4,'Purple / Large','randoms-474','Purple','Large',NULL,1,57.00,0.00),
	(123,147134398,336032501,1373653756,1373653756,5,'Black / Small','randoms-187','Black','Small',NULL,1,50.00,0.00),
	(124,147134363,336032419,1373653745,1373653745,1,'Green / X-Large','randoms-373','Green','X-Large',NULL,1,46.00,0.00),
	(125,147134363,336032420,1373653745,1373653745,2,'Purple / Small','randoms-190','Purple','Small',NULL,1,63.00,0.00),
	(126,147134363,336032421,1373653745,1373653745,3,'Blue / Child','randoms-922','Blue','Child',NULL,1,68.00,0.00),
	(127,147134363,336032422,1373653745,1373653745,4,'Red / Medium','randoms-962','Red','Medium',NULL,1,43.00,0.00),
	(128,147134363,336032424,1373653745,1373653745,5,'Black / Large','randoms-680','Black','Large',NULL,1,21.00,0.00),
	(129,147134391,336032483,1373653754,1373653754,1,'Purple / Large','randoms-968','Purple','Large',NULL,1,64.00,0.00),
	(130,147134391,336032484,1373653754,1373653754,2,'Red / Medium','randoms-403','Red','Medium',NULL,1,70.00,0.00),
	(131,147134391,336032485,1373653754,1373653754,3,'Black / Small','randoms-927','Black','Small',NULL,1,84.00,0.00),
	(132,147134391,336032486,1373653754,1373653754,4,'Green / X-Large','randoms-445','Green','X-Large',NULL,1,97.00,0.00),
	(133,147134391,336032487,1373653754,1373653754,5,'Blue / Child','randoms-516','Blue','Child',NULL,1,35.00,0.00),
	(134,147134404,336032507,1373653757,1373653757,1,'Red / Large','randoms-138','Red','Large',NULL,1,60.00,0.00),
	(135,147134404,336032508,1373653757,1373653757,2,'Purple / X-Large','randoms-182','Purple','X-Large',NULL,1,61.00,0.00),
	(136,147134404,336032509,1373653757,1373653757,3,'Black / Child','randoms-581','Black','Child',NULL,1,57.00,0.00),
	(137,147134404,336032510,1373653757,1373653757,4,'Blue / Small','randoms-917','Blue','Small',NULL,1,50.00,0.00),
	(138,147134404,336032511,1373653757,1373653757,5,'Green / Medium','randoms-302','Green','Medium',NULL,1,41.00,0.00);

/*!40000 ALTER TABLE `products_variants` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
