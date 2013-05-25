<?php 


include_once("functions.php");
include_once("conf/WeatherDBConfig.php");
$conf = new WeatherDBConfig();

$keyArray = generateRSAKeyPair();
$privateKey = $keyArray["privateKey"];
$publicKey = $keyArray["publicKey"];


$db = mysqli_connect($conf->db_server, $conf->db_user, $conf->db_pw, $conf->db_name);
if(!$db)
	returnResponse("503", $db->error);


echo "Validating Arduino-ID...";
var_dump(validateArduinoID($db, $conf, 1, "diesistderapikey"));





?>