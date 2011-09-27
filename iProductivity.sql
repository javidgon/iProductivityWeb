-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 06-06-2011 a las 12:31:06
-- Versión del servidor: 5.1.44
-- Versión de PHP: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `iproductivity`
--
CREATE DATABASE `iproductivity` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE `iproductivity`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `blacklist`
--

CREATE TABLE IF NOT EXISTS `blacklist` (
  `ip` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ip`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcar la base de datos para la tabla `blacklist`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `name` varchar(50) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`name`,`creation_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcar la base de datos para la tabla `category`
--

INSERT INTO `category` (`name`, `creation_date`) VALUES
('Accounting', '2011-06-04 12:32:05'),
('Administration', '2011-06-04 12:41:25'),
('Human Resources', '2011-06-04 12:31:32'),
('Support and maintenance', '2011-06-04 13:05:35'),
('Technological Innovation', '2011-06-04 12:32:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `incident`
--

CREATE TABLE IF NOT EXISTS `incident` (
  `user` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `message` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user`,`creation_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcar la base de datos para la tabla `incident`
--

INSERT INTO `incident` (`user`, `message`, `creation_date`) VALUES
('jesgut@collaboratia.com', 'I want perform more tasks!', '2011-06-06 14:26:55'),
('jesgut@collaboratia.com', 'I love u root! You are the best!', '2011-06-06 14:27:21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log`
--

CREATE TABLE IF NOT EXISTS `log` (
  `message` varchar(200) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `creation_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user` varchar(50) COLLATE utf8_spanish_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`message`,`user`,`creation_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcar la base de datos para la tabla `log`
--

INSERT INTO `log` (`message`, `creation_date`, `user`) VALUES
('carver@collaboratia.com has been logged in', '2011-06-06 14:02:27', 'carver@collaboratia.com'),
('carver@collaboratia.com has been logged in', '2011-06-06 14:24:50', 'carver@collaboratia.com'),
('gonrod@collaboratia.com has been logged in', '2011-06-06 13:10:21', 'gonrod@collaboratia.com'),
('gonrod@collaboratia.com has been logged in', '2011-06-06 13:22:36', 'gonrod@collaboratia.com'),
('gonrod@collaboratia.com has created this task: Send information to the employees', '2011-06-06 13:11:56', 'gonrod@collaboratia.com'),
('gonrod@collaboratia.com has created this task: Write a letter to the main provider', '2011-06-06 13:16:46', 'gonrod@collaboratia.com'),
('gonrod@collaboratia.com has edited this task: Send information to the employees', '2011-06-06 13:12:23', 'gonrod@collaboratia.com'),
('gonrod@collaboratia.com has edited this task: Write a letter to the main provider', '2011-06-06 13:17:05', 'gonrod@collaboratia.com'),
('jesgut@collaboratia.com has been logged in', '2011-06-06 12:57:05', 'jesgut@collaboratia.com'),
('jesgut@collaboratia.com has been logged in', '2011-06-06 13:18:57', 'jesgut@collaboratia.com'),
('jesgut@collaboratia.com has been logged in', '2011-06-06 13:26:30', 'jesgut@collaboratia.com'),
('jesgut@collaboratia.com has been logged in', '2011-06-06 13:46:58', 'jesgut@collaboratia.com'),
('jesgut@collaboratia.com has been logged in', '2011-06-06 14:02:42', 'jesgut@collaboratia.com'),
('jesgut@collaboratia.com has been logged in', '2011-06-06 14:24:14', 'jesgut@collaboratia.com'),
('jesgut@collaboratia.com has been logged in', '2011-06-06 14:26:39', 'jesgut@collaboratia.com'),
('jesgut@collaboratia.com has created this incident: I love u root! You are the best!', '2011-06-06 14:27:21', 'jesgut@collaboratia.com'),
('jesgut@collaboratia.com has created this incident: I want perform more tasks!', '2011-06-06 14:26:55', 'jesgut@collaboratia.com'),
('jesgut@collaboratia.com has edited his profile', '2011-06-06 13:48:10', 'jesgut@collaboratia.com'),
('josvid@collaboratia.com has been logged in', '2011-06-06 13:50:19', 'josvid@collaboratia.com'),
('josvid@collaboratia.com has edited his profile', '2011-06-06 13:51:13', 'josvid@collaboratia.com'),
('kripet@collaboratia.com has been logged in', '2011-06-06 13:23:22', 'kripet@collaboratia.com'),
('kripet@collaboratia.com has been logged in', '2011-06-06 13:25:38', 'kripet@collaboratia.com'),
('kripet@collaboratia.com has been logged in', '2011-06-06 13:29:09', 'kripet@collaboratia.com'),
('kripet@collaboratia.com has been logged in', '2011-06-06 13:45:51', 'kripet@collaboratia.com'),
('kripet@collaboratia.com has created this task: Hire two new employees', '2011-06-06 13:24:55', 'kripet@collaboratia.com'),
('kripet@collaboratia.com has created this task: Meeting with the union representative.', '2011-06-06 13:30:57', 'kripet@collaboratia.com'),
('kripet@collaboratia.com has created this task: Talk with the president', '2011-06-06 13:41:55', 'kripet@collaboratia.com'),
('kripet@collaboratia.com has edited this task: Hire two new employees', '2011-06-06 13:25:10', 'kripet@collaboratia.com'),
('kripet@collaboratia.com has edited this task: Hire two new employees', '2011-06-06 13:26:03', 'kripet@collaboratia.com'),
('kripet@collaboratia.com has edited this task: Meeting with the union representative.', '2011-06-06 13:31:33', 'kripet@collaboratia.com'),
('kripet@collaboratia.com has edited this task: Meeting with the union representative.', '2011-06-06 13:32:16', 'kripet@collaboratia.com'),
('kripet@collaboratia.com has edited this task: Meeting with the union representative.', '2011-06-06 13:38:17', 'kripet@collaboratia.com'),
('kripet@collaboratia.com has edited this task: Talk with the president', '2011-06-06 13:42:09', 'kripet@collaboratia.com'),
('margon@collaboratia.com has been logged in', '2011-06-06 13:06:01', 'margon@collaboratia.com'),
('margon@collaboratia.com has been logged in', '2011-06-06 13:19:10', 'margon@collaboratia.com'),
('margon@collaboratia.com has been logged in', '2011-06-06 13:58:42', 'margon@collaboratia.com'),
('margon@collaboratia.com has created this task: Generate earnings reports', '2011-06-06 14:02:08', 'margon@collaboratia.com'),
('margon@collaboratia.com has created this task: Learn to use the new account software', '2011-06-06 13:59:45', 'margon@collaboratia.com'),
('margon@collaboratia.com has created this task: Meeting with the bank manager', '2011-06-06 13:07:51', 'margon@collaboratia.com'),
('margon@collaboratia.com has created this task: Sign the bills', '2011-06-06 14:00:29', 'margon@collaboratia.com'),
('margon@collaboratia.com has edited this task: Make a graph of monthly balance', '2011-06-06 13:21:38', 'margon@collaboratia.com'),
('margon@collaboratia.com has edited this task: Make a graph of monthly balance', '2011-06-06 13:21:59', 'margon@collaboratia.com'),
('margon@collaboratia.com has edited this task: Meeting with the bank manager', '2011-06-06 13:20:43', 'margon@collaboratia.com'),
('margon@collaboratia.com has edited this task: Meeting with the bank manager', '2011-06-06 13:20:58', 'margon@collaboratia.com'),
('root@collaboratia.com has been logged in', '2011-06-06 13:05:15', 'root@collaboratia.com'),
('root@collaboratia.com has been logged in', '2011-06-06 13:45:00', 'root@collaboratia.com'),
('root@collaboratia.com has been logged in', '2011-06-06 14:25:59', 'root@collaboratia.com'),
('root@collaboratia.com has been logged in', '2011-06-06 14:27:41', 'root@collaboratia.com'),
('rubver@collaboratia.com has been logged in', '2011-06-06 13:26:51', 'rubver@collaboratia.com'),
('rubver@collaboratia.com has been logged in', '2011-06-06 13:27:44', 'rubver@collaboratia.com'),
('rubver@collaboratia.com has been logged in', '2011-06-06 14:02:55', 'rubver@collaboratia.com'),
('rubver@collaboratia.com has been logged in', '2011-06-06 14:25:06', 'rubver@collaboratia.com'),
('rubver@collaboratia.com has created this task: Buy new computers', '2011-06-06 14:05:06', 'rubver@collaboratia.com'),
('rubver@collaboratia.com has created this task: Defragment hard drives', '2011-06-06 14:06:16', 'rubver@collaboratia.com'),
('rubver@collaboratia.com has created this task: Fix printers', '2011-06-06 14:04:33', 'rubver@collaboratia.com'),
('rubver@collaboratia.com has created this task: Install new operative system', '2011-06-06 14:07:11', 'rubver@collaboratia.com'),
('rubver@collaboratia.com has edited this task: Build a LAN for the accounting department', '2011-06-06 13:28:08', 'rubver@collaboratia.com'),
('rubver@collaboratia.com has edited this task: Buy new computers', '2011-06-06 14:07:30', 'rubver@collaboratia.com'),
('rubver@collaboratia.com has edited this task: Create a backup', '2011-06-06 14:03:33', 'rubver@collaboratia.com'),
('rubver@collaboratia.com has edited this task: Defragment hard drives', '2011-06-06 14:07:39', 'rubver@collaboratia.com'),
('rubver@collaboratia.com has edited this task: Fix printers', '2011-06-06 14:07:52', 'rubver@collaboratia.com'),
('rubver@collaboratia.com has edited this task: Install new operative system', '2011-06-06 14:08:04', 'rubver@collaboratia.com'),
('rubver@collaboratia.com has edited this task: Upgrade to a new version of Oracle', '2011-06-06 13:27:12', 'rubver@collaboratia.com'),
('rubver@collaboratia.com has edited this task: Upgrade to a new version of Oracle', '2011-06-06 13:28:36', 'rubver@collaboratia.com'),
('sersaa@collaboratia.com has been logged in', '2011-06-06 13:08:20', 'sersaa@collaboratia.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `task`
--

CREATE TABLE IF NOT EXISTS `task` (
  `description` varchar(200) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `type` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `done` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `minutes` int(11) NOT NULL,
  `user` varchar(50) COLLATE utf8_spanish_ci NOT NULL DEFAULT '0',
  `creation_date` timestamp NULL DEFAULT NULL,
  `finalization_date` timestamp NOT NULL DEFAULT '1999-10-10 00:00:00',
  PRIMARY KEY (`description`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcar la base de datos para la tabla `task`
--

INSERT INTO `task` (`description`, `type`, `done`, `minutes`, `user`, `creation_date`, `finalization_date`) VALUES
('Build a LAN for the accounting department', 'Support and maintenance', 'Yes', 750, 'frabla@collaboratia.com', '2011-06-04 14:16:55', '2011-06-06 13:28:08'),
('Buy new computers', 'Accounting', 'Yes', 180, 'jesgut@collaboratia.com', '2011-06-06 14:05:06', '2011-06-06 14:07:30'),
('Change the server''s OS to Red Hat', 'Support and maintenance', 'Yes', 630, 'jesgut@collaboratia.com', '2011-06-04 13:10:58', '2011-06-05 13:19:02'),
('Create a backup', 'Support and maintenance', 'Yes', 30, 'frabla@collaboratia.com', '2011-06-04 14:11:20', '2011-06-06 14:03:33'),
('Create documentation of Collaboratia project', 'Technological Innovation', 'Yes', 120, 'akikur@collaboratia.com', '2011-06-04 14:22:23', '1999-10-10 00:00:00'),
('Defragment hard drives', 'Support and maintenance', 'Yes', 60, 'jesgut@collaboratia.com', '2011-06-06 14:06:16', '2011-06-06 14:07:39'),
('Develop a new sorting algorithm', 'Technological Innovation', 'Yes', 285, 'javmar@collaboratia.com', '2011-06-04 13:16:52', '1999-10-10 00:00:00'),
('Fix printers', 'Support and maintenance', 'Yes', 90, 'jesgut@collaboratia.com', '2011-06-06 14:04:33', '2011-06-06 14:07:52'),
('Generate earnings reports', 'Accounting', 'No', 130, 'carver@collaboratia.com', '2011-06-06 14:02:08', '1999-10-10 00:00:00'),
('Hire two new employees', 'Human Resources', 'Yes', 480, 'crialb@collaboratia.com', '2011-06-06 13:24:55', '2011-06-06 13:26:03'),
('Install new operative system', 'Support and maintenance', 'Yes', 45, 'jesgut@collaboratia.com', '2011-06-05 14:07:11', '2011-06-05 14:08:04'),
('Learn to use the new account software', 'Accounting', 'No', 90, 'carver@collaboratia.com', '2011-06-06 13:59:45', '1999-10-10 00:00:00'),
('Make a graph of monthly balance', 'Accounting', 'Yes', 40, 'carver@collaboratia.com', '2011-06-04 17:03:45', '2011-06-06 13:21:59'),
('Meeting with the bank manager', 'Accounting', 'Yes', 150, 'sersaa@collaboratia.com', '2011-06-06 13:07:51', '2011-06-06 13:20:58'),
('Meeting with the union representative.', 'Human Resources', 'Yes', 840, 'luzpoz@collaboratia.com', '2011-06-06 13:30:57', '2011-06-06 13:38:17'),
('Optimize code for the next iteration', 'Technological Innovation', 'No', 150, 'akikur@collaboratia.com', '2011-06-04 14:26:52', '1999-10-10 00:00:00'),
('Send information to the employees', 'Administration', 'Yes', 20, 'nicdav@collaboratia.com', '2011-06-06 13:11:56', '2011-06-06 13:12:23'),
('Sign the bills', 'Accounting', 'No', 30, 'carver@collaboratia.com', '2011-06-06 14:00:29', '1999-10-10 00:00:00'),
('Talk with the president', 'Accounting', 'Yes', 80, 'crialb@collaboratia.com', '2011-06-06 13:41:55', '2011-06-06 13:42:09'),
('Upgrade to a new version of Oracle', 'Support and maintenance', 'Yes', 290, 'jesgut@collaboratia.com', '2011-06-04 13:08:25', '2011-06-04 13:28:36'),
('Write a letter to the main provider', 'Accounting', 'Yes', 10, 'nicdav@collaboratia.com', '2011-06-06 13:16:46', '2011-06-06 13:17:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `email` varchar(50) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `name` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `surname` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `password` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `type` int(11) NOT NULL,
  `boss` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `creation_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcar la base de datos para la tabla `user`
--

INSERT INTO `user` (`email`, `name`, `surname`, `password`, `type`, `boss`, `creation_date`) VALUES
('akikur@collaboratia.com', 'Akira', 'Kurosawa', '5404aaed006a1f773f6a1cc5ba717a0bb5d9dee9', 1, 'josvid@collaboratia.com', '2011-06-04 13:36:26'),
('carver@collaboratia.com', 'Carmen', 'Verdini', '5404aaed006a1f773f6a1cc5ba717a0bb5d9dee9', 1, 'margon@collaboratia.com', '2011-06-04 13:47:11'),
('crialb@collaboratia.com', 'Cristiano Alberto', 'Silva', '5404aaed006a1f773f6a1cc5ba717a0bb5d9dee9', 1, 'kripet@collaboratia.com', '2011-06-04 13:51:27'),
('frabla@collaboratia.com', 'Frank', 'Blanche', '5404aaed006a1f773f6a1cc5ba717a0bb5d9dee9', 1, 'rubver@collaboratia.com', '2011-06-04 13:33:48'),
('gonrod@collaboratia.com', 'Gonzalo Rodolfo', 'de la Serna', 'b6e2377b1ec3b93af7c7b39b44e170dc91f94942', 2, NULL, '2011-06-04 13:30:12'),
('javmar@collaboratia.com', 'Javier', 'Maladayo', '5404aaed006a1f773f6a1cc5ba717a0bb5d9dee9', 1, 'josvid@collaboratia.com', '2011-06-04 13:13:18'),
('jesgut@collaboratia.com', 'Jesus', 'Gutenberg', '5404aaed006a1f773f6a1cc5ba717a0bb5d9dee9', 1, 'rubver@collaboratia.com', '2011-06-04 12:58:38'),
('josvid@collaboratia.com', 'Joseph', 'Vidal', 'b6e2377b1ec3b93af7c7b39b44e170dc91f94942', 2, NULL, '2011-06-04 12:28:08'),
('kripet@collaboratia.com', 'Kristina', 'Petrova', 'b6e2377b1ec3b93af7c7b39b44e170dc91f94942', 2, NULL, '2011-06-04 13:25:10'),
('luzpoz@collaboratia.com', 'Luz', 'Pozo', '5404aaed006a1f773f6a1cc5ba717a0bb5d9dee9', 1, 'kripet@collaboratia.com', '2011-06-04 13:48:58'),
('margon@collaboratia.com', 'Marta', 'Gonifacio', 'b6e2377b1ec3b93af7c7b39b44e170dc91f94942', 2, NULL, '2011-06-04 13:23:37'),
('nicdav@collaboratia.com', 'Nicolai', 'Davidenko', '5404aaed006a1f773f6a1cc5ba717a0bb5d9dee9', 1, 'gonrod@collaboratia.com', '2011-06-04 13:54:09'),
('petsmi@collaboratia.com', 'Peter', 'Smith', '5404aaed006a1f773f6a1cc5ba717a0bb5d9dee9', 1, 'gonrod@collaboratia.com', '2011-06-04 13:53:27'),
('root@collaboratia.com', 'Root', 'Root', '47faa5c0ad16f2bc8712baad142907f02894bca0', 3, NULL, '2011-06-04 11:58:32'),
('rubver@collaboratia.com', 'Rupert', 'Wade', 'b6e2377b1ec3b93af7c7b39b44e170dc91f94942', 2, NULL, '2011-06-04 12:27:17'),
('sersaa@collaboratia.com', 'Sergio', 'Saavedra', '5404aaed006a1f773f6a1cc5ba717a0bb5d9dee9', 1, 'margon@collaboratia.com', '2011-06-04 13:43:57');
