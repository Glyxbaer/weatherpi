-- phpMyAdmin SQL Dump
-- version 3.5.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 25. Feb 2013 um 14:15
-- Server Version: 5.5.28-1~dotdeb.0
-- PHP-Version: 5.2.17-0.dotdeb.0

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `usr_web1025_1`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `qild9_weatherpi_arduino`
--

CREATE TABLE IF NOT EXISTS `qild9_weatherpi_arduino` (
  `arduino_id` int(11) NOT NULL AUTO_INCREMENT,
  `raspi_api_key` varchar(100) NOT NULL,
  `name` varchar(45) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`arduino_id`,`raspi_api_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `qild9_weatherpi_location`
--

CREATE TABLE IF NOT EXISTS `qild9_weatherpi_location` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `gps_longitude` decimal(10,0) DEFAULT NULL,
  `gps_latitude` decimal(10,0) DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  `road` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `qild9_weatherpi_raspi`
--

CREATE TABLE IF NOT EXISTS `qild9_weatherpi_raspi` (
  `api_key` varchar(100) NOT NULL,
  `name` varchar(45) NOT NULL,
  `public_key` varchar(128) NOT NULL,
  `private_key` varchar(128) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`api_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `qild9_weatherpi_weather_data`
--

CREATE TABLE IF NOT EXISTS `qild9_weatherpi_weather_data` (
  `weather_id` int(11) NOT NULL AUTO_INCREMENT,
  `ardunio_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `saved` datetime NOT NULL,
  `location_id` int(11) NOT NULL,
  PRIMARY KEY (`weather_id`,`ardunio_id`,`date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `qild9_weatherpi_weather_data_continous`
--

CREATE TABLE IF NOT EXISTS `qild9_weatherpi_weather_data_continous` (
  `weather_id` int(11) NOT NULL,
  `time` time NOT NULL,
  `saved` datetime NOT NULL,
  `temperature` decimal(5,0) DEFAULT NULL,
  `rainfall` int(11) DEFAULT NULL,
  `wind_direction` varchar(5) DEFAULT NULL,
  `wind_speed` decimal(10,0) DEFAULT NULL,
  `air_pressure` int(11) DEFAULT NULL,
  `light_intensity` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`weather_id`,`time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `qild9_weatherpi_weather_data_daily`
--

CREATE TABLE IF NOT EXISTS `qild9_weatherpi_weather_data_daily` (
  `weather_id` int(11) NOT NULL,
  `saved` datetime NOT NULL,
  `sunrise` time DEFAULT NULL,
  `sunset` time DEFAULT NULL,
  `sunlight_hours` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`weather_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
