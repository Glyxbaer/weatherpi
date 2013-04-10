-- phpMyAdmin SQL Dump
-- version 3.5.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 15. Mrz 2013 um 17:53
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
  `gps_longitude` decimal(10,7) DEFAULT NULL,
  `gps_latitude` decimal(10,7) DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  `road` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Daten für Tabelle `qild9_weatherpi_location`
--

INSERT INTO `qild9_weatherpi_location` (`location_id`, `gps_longitude`, `gps_latitude`, `zip`, `road`) VALUES
(1, '23.0000000', '23.0000000', 70197, 'Reinsburgstraße');

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
('diesistderapikey', 'JB''s RaspPi', '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnUYaBUz3GigpWTLczA19\nT/ehXcd8SCAU6MT3kpD77AeRBtKXPDgZhqM2mhaTUFtzhMTRwEubaEQk17y0E/DZ\nsoccw0c188jESWGkXDBAKLuOXJxKmrZRLuUZySrxLj2q6AaITlsja/92m+4mPEcZ\nlylQQzyThPxHh/aGUpkW9Sar5DSwD+40e0bZCzc8jGCW9PxzZlqTg6wpfJoDb+qx\nQ41wM0HI6skouANBU+yZy+e4UkWdnL5XnWzKchYjWl0NO48h551MNO8FMddRATWP\naP/1ZWT1rDIEPgsJjTqyXj09nJuapUa5GQJgfeed7Q35WscR9osOikM0y9CEvmES\n1QIDAQAB\n-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAKCAQEAnUYaBUz3GigpWTLczA19T/ehXcd8SCAU6MT3kpD77AeRBtKX\nPDgZhqM2mhaTUFtzhMTRwEubaEQk17y0E/DZsoccw0c188jESWGkXDBAKLuOXJxK\nmrZRLuUZySrxLj2q6AaITlsja/92m+4mPEcZlylQQzyThPxHh/aGUpkW9Sar5DSw\nD+40e0bZCzc8jGCW9PxzZlqTg6wpfJoDb+qxQ41wM0HI6skouANBU+yZy+e4UkWd\nnL5XnWzKchYjWl0NO48h551MNO8FMddRATWPaP/1ZWT1rDIEPgsJjTqyXj09nJua\npUa5GQJgfeed7Q35WscR9osOikM0y9CEvmES1QIDAQABAoIBAELVaXVbMZ7R9lBL\nhvzHtrrm1pINlcjoqToJidOk/QleZcjqcQ5MILzQWwG8GjoJwttm8GOxPYdfffCX\n5kabEUgGlrh9aHYCmTc94SSz9G/a1DKS0DlSxMkS3pRYRUmLNzeGnyH9JN5eHz9A\nQstWw48zJUKNWXsn4hXrM0WifNkMPVzrAsnhwKdT5zygd1R1hFMoc0PRoKELXlIw\nWQJVECjNyHeGZcpd8DNncwupHn120ijpORMYwdRLxa17+C/vGfHf8Baqu9X4qtIL\nPtFJbeSO/FOZvRlf4TfjXdwmvyrLWEW70saomuy3WkOgD/4Z3FwjuejDFgwWsMQi\nIkIMjkECgYEAzvFRBLOvkJvC4BzOuEeXhNJrfbgUHGmkaHl2Y6SeimroxiyC08U7\ngkeKOzvXaW8fTiLUpeQ1Q+CaxqrZCI6RlF19PaWJAZpiaH1aZ8Chle6i2/SlS58/\nvYhcEIK35sQp1S148TcMCwEIZcpr9eIcNjddk7JkjRBYz3z6hobEnZkCgYEAwo6L\ngF6vT92inRjqTz16p68uDH46qJFAeZyyPOGBQlmqAJXlUDcKCE3zT7ZspCQJhEZj\n86etvrzcXYS1om+DPeHI2f6CgAWPH5zFjr3wCCFbkLro8uDoQFnUpPTGdJf5rbuO\nwZnz2XySgQaFfted9nxDG0f7yrVFe0myzVT7TJ0CgYBE+pEL5S0PIaxKca/CIzLx\nNgZYaIRjmB8SJ/J7ckLaVppyfCG7nxGf8mK0LdU2srCXpeqFxVSv5G0S7Z3cSVFj\nR+pYIxZQ73n/5FC/Jql1xY6JjLmQRGvFrG8rnbbY9+gNw9N9a+DaxiRbcaac1hqb\nQ8cwVRVJI/rGZp1HPCLLeQKBgHwD/vpZ4KgpIBHBowHVr4yZxuGhyORQime6sYbL\nO+i+XPY4lk6WdueqQJEsOH48lnBhqi7TUJYHrvRRtrIPIPpeJPiIGklewcel1+xQ\nOGQGV2afLgQ7xu/WEwz/Fk2V3kqXBr1z1BNrK7vhG1EqQf+vX9tQ/DhPajXXWYk3\nRWSlAoGAfx2u0zx3Q4KcUvugHkmOGakobX4TCdZ6iOngEwhhwjEn3ABQjt7HG9d6\nThzyCQA0jKmjP9gG53ppMXRghva/CmycbHT5Vmwxm8Bv7yWbc9Mfyezf14bAYo7N\nENHWC2oAn60G4q8U63voH/yHUnJGmOikjAnCMGZXRphyx31kq+c=\n-----END RSA PRIVATE KEY-----', 1);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `qild9_weatherpi_weather_data_continuous`
--

CREATE TABLE IF NOT EXISTS `qild9_weatherpi_weather_data_continuous` (
  `weather_id` int(11) NOT NULL,
  `time` time NOT NULL,
  `saved` datetime NOT NULL,
  `temperature` decimal(5,2) DEFAULT NULL,
  `rainfall` decimal(7,4) DEFAULT NULL,
  `wind_direction` varchar(5) DEFAULT NULL,
  `wind_speed` decimal(11,8) DEFAULT NULL,
  `air_pressure` int(11) DEFAULT NULL,
  `light_intensity` int(11) DEFAULT NULL,
  `humidity` decimal(5,2) DEFAULT NULL,
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
  `sunlight_minutes` int(11) DEFAULT NULL,
  PRIMARY KEY (`weather_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
