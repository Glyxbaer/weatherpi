-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Erstellungszeit: 12. Mrz 2013 um 10:18
-- Server Version: 5.5.27
-- PHP-Version: 5.4.7

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Daten für Tabelle `qild9_weatherpi_arduino`
--

INSERT INTO `qild9_weatherpi_arduino` (`arduino_id`, `raspi_api_key`, `name`, `location_id`) VALUES
(1, 'diesistderapikey', 'JB''s erster Arduino', 1);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Daten für Tabelle `qild9_weatherpi_location`
--

INSERT INTO `qild9_weatherpi_location` (`location_id`, `gps_longitude`, `gps_latitude`, `zip`, `road`) VALUES
(1, 23, 23, 70197, 'Reinsburgstraße');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `qild9_weatherpi_raspi`
--

CREATE TABLE IF NOT EXISTS `qild9_weatherpi_raspi` (
  `api_key` varchar(100) NOT NULL,
  `name` varchar(45) NOT NULL,
  `public_key` text NOT NULL,
  `private_key` text NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`api_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `qild9_weatherpi_raspi`
--

INSERT INTO `qild9_weatherpi_raspi` (`api_key`, `name`, `public_key`, `private_key`, `user_id`) VALUES
('diesistderapikey', 'JB''s RaspPi', 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnUYaBUz3GigpWTLczA19\r\nT/ehXcd8SCAU6MT3kpD77AeRBtKXPDgZhqM2mhaTUFtzhMTRwEubaEQk17y0E/DZ\r\nsoccw0c188jESWGkXDBAKLuOXJxKmrZRLuUZySrxLj2q6AaITlsja/92m+4mPEcZ\r\nlylQQzyThPxHh/aGUpkW9Sar5DSwD+40e0bZCzc8jGCW9PxzZlqTg6wpfJoDb+qx\r\nQ41wM0HI6skouANBU+yZy+e4UkWdnL5XnWzKchYjWl0NO48h551MNO8FMddRATWP\r\naP/1ZWT1rDIEPgsJjTqyXj09nJuapUa5GQJgfeed7Q35WscR9osOikM0y9CEvmES\r\n1QIDAQAB', 'MIIEogIBAAKCAQEAnUYaBUz3GigpWTLczA19T/ehXcd8SCAU6MT3kpD77AeRBtKX\r\nPDgZhqM2mhaTUFtzhMTRwEubaEQk17y0E/DZsoccw0c188jESWGkXDBAKLuOXJxK\r\nmrZRLuUZySrxLj2q6AaITlsja/92m+4mPEcZlylQQzyThPxHh/aGUpkW9Sar5DSw\r\nD+40e0bZCzc8jGCW9PxzZlqTg6wpfJoDb+qxQ41wM0HI6skouANBU+yZy+e4UkWd\r\nnL5XnWzKchYjWl0NO48h551MNO8FMddRATWPaP/1ZWT1rDIEPgsJjTqyXj09nJua\r\npUa5GQJgfeed7Q35WscR9osOikM0y9CEvmES1QIDAQABAoIBAELVaXVbMZ7R9lBL\r\nhvzHtrrm1pINlcjoqToJidOk/QleZcjqcQ5MILzQWwG8GjoJwttm8GOxPYdfffCX\r\n5kabEUgGlrh9aHYCmTc94SSz9G/a1DKS0DlSxMkS3pRYRUmLNzeGnyH9JN5eHz9A\r\nQstWw48zJUKNWXsn4hXrM0WifNkMPVzrAsnhwKdT5zygd1R1hFMoc0PRoKELXlIw\r\nWQJVECjNyHeGZcpd8DNncwupHn120ijpORMYwdRLxa17+C/vGfHf8Baqu9X4qtIL\r\nPtFJbeSO/FOZvRlf4TfjXdwmvyrLWEW70saomuy3WkOgD/4Z3FwjuejDFgwWsMQi\r\nIkIMjkECgYEAzvFRBLOvkJvC4BzOuEeXhNJrfbgUHGmkaHl2Y6SeimroxiyC08U7\r\ngkeKOzvXaW8fTiLUpeQ1Q+CaxqrZCI6RlF19PaWJAZpiaH1aZ8Chle6i2/SlS58/\r\nvYhcEIK35sQp1S148TcMCwEIZcpr9eIcNjddk7JkjRBYz3z6hobEnZkCgYEAwo6L\r\ngF6vT92inRjqTz16p68uDH46qJFAeZyyPOGBQlmqAJXlUDcKCE3zT7ZspCQJhEZj\r\n86etvrzcXYS1om+DPeHI2f6CgAWPH5zFjr3wCCFbkLro8uDoQFnUpPTGdJf5rbuO\r\nwZnz2XySgQaFfted9nxDG0f7yrVFe0myzVT7TJ0CgYBE+pEL5S0PIaxKca/CIzLx\r\nNgZYaIRjmB8SJ/J7ckLaVppyfCG7nxGf8mK0LdU2srCXpeqFxVSv5G0S7Z3cSVFj\r\nR+pYIxZQ73n/5FC/Jql1xY6JjLmQRGvFrG8rnbbY9+gNw9N9a+DaxiRbcaac1hqb\r\nQ8cwVRVJI/rGZp1HPCLLeQKBgHwD/vpZ4KgpIBHBowHVr4yZxuGhyORQime6sYbL\r\nO+i+XPY4lk6WdueqQJEsOH48lnBhqi7TUJYHrvRRtrIPIPpeJPiIGklewcel1+xQ\r\nOGQGV2afLgQ7xu/WEwz/Fk2V3kqXBr1z1BNrK7vhG1EqQf+vX9tQ/DhPajXXWYk3\r\nRWSlAoGAfx2u0zx3Q4KcUvugHkmOGakobX4TCdZ6iOngEwhhwjEn3ABQjt7HG9d6\r\nThzyCQA0jKmjP9gG53ppMXRghva/CmycbHT5Vmwxm8Bv7yWbc9Mfyezf14bAYo7N\r\nENHWC2oAn60G4q8U63voH/yHUnJGmOikjAnCMGZXRphyx31kq+c=', 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `qild9_weatherpi_weather_data`
--

CREATE TABLE IF NOT EXISTS `qild9_weatherpi_weather_data` (
  `weather_id` int(11) NOT NULL AUTO_INCREMENT,
  `arduino_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `location_id` int(11) NOT NULL,
  PRIMARY KEY (`weather_id`,`arduino_id`,`date`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `qild9_weatherpi_weather_data_continuous`
--

CREATE TABLE IF NOT EXISTS `qild9_weatherpi_weather_data_continuous` (
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
