<?php


if(isset($_POST["apikey"]) && isset($_POST["sessionkey"]) && isset($_POST["msg"]) && isset($_POST["iv"])) {

	include_once("lib/phpseclib/Crypt/RSA.php");
	include_once("conf/WeatherDBConfig.php");
	$conf = new WeatherDBConfig();

	// Fetch the private RSA-Key from the DB
	$privateKey = getPrivateKey($conf, $_POST["apikey"]);

	// Check if a key was found (apikey valid)
	if($privateKey) {
		// Decrypt the sessionKey for the AES-Decryption
		//$sessionKey = decryptSessionKey($privateKey, $_POST["sessionkey"]);
		// Decrypt the actual message
		//$message = decryptMessage($sessionKey, $_POST["msg"], $_POST["iv"]);
		$message = file_get_contents("data/test-data.json");
		// Transform the JSON into a PHP-Object
		$data = json_decode($message);
		// Insert the Object into the DB
		insertIntoDB($conf, $data);

		returnResponse("200", "Successfully inserted");


	} else {
		returnResponse("403", "API-key not valid");
	}


} else {
	returnResponse("401", "Required parameters missing");
}


// Fetch the private key corresponding to apikey from database
function getPrivateKey($conf, $apikey) {

	$db = mysqli_connect($conf->db_server, $conf->db_user, $conf->db_pw, $conf->db_name);
	if(!$db)
		returnResponse("503", $db->error);

	$sql = "SELECT private_key FROM ".$conf->db_keytable." WHERE api_key=?";
	$statement = $db->prepare($sql);
	if(!$statement)
		returnResponse("503", $db->error);
	$statement->bind_param("s", $apikey);
	$statement->execute();
	$statement->bind_result($privateKey);
	$statement->fetch();
	$statement->close();
	mysqli_close($db);

	return $privateKey;
}


// Decrypt the SessionKey (RSA)
function decryptSessionKey($pk, $data) {

	$rsa = new Crypt_RSA();
	$rsa->loadKey($pk, CRYPT_RSA_PRIVATE_FORMAT_PKCS1);
	$plainSessionKey = $rsa->decrypt($data);

	return $plainSessionKey;
}

// Decrypt the message (AES)
function decryptMessage($key, $data, $iv) {
	return trim(mcrypt_decrypt(MCRYPT_RIJNDAEL_128, $key, $data, MCRYPT_MODE_CFB, $iv));
}

// Insert the data into the DB
function insertIntoDB($conf, $data_object) {

	$db = mysqli_connect($conf->db_server, $conf->db_user, $conf->db_pw, $conf->db_name);
	if(!$db)
		returnResponse("503", $db->error);

	$arduino_id = $data_object->{'arduino-id'};
	$date = $data_object->{'date'};
	$weather_data = $data_object->{'data'};

	// Get the current location of the arduino
	$sql = "SELECT location_id FROM ".$conf->db_arduinotable." WHERE arduino_id=?";
	$statement = $db->prepare($sql);
	if(!$statement)
		returnResponse("503", $db->error);
	$statement->bind_param("i", $arduino_id);
	$statement->execute();
	$statement->bind_result($location_id);
	$statement->fetch();
	$statement->close();

	if($location_id) {
		// location_id found --> arduino exists
		// Check if there already exists an entry for this id at this date and the current location
		$weather_id = getWeatherID($db, $conf, $arduino_id, $date, $location_id);

		if(!$weather_id) {
			// entry doesn't exist --> create a new one
			$sql = "INSERT INTO ".$conf->db_weathertable." (arduino_id, date, location_id) VALUES(?, ?, ?)";
			$statement = $db->prepare($sql);
			if(!$statement)
				returnResponse("503", $db->error);
			$statement->bind_param("isi", $arduino_id, $date, $location_id);
			if(!$statement->execute())
				returnResponse("503", $db->error);
			$statement->close();
			// get the weather_id of the inserted entry
			$weather_id = getWeatherID($db, $conf, $arduino_id, $date, $location_id);
		}

		// weather_id has been fetched --> now insert the actual data
		$sql = "INSERT IGNORE INTO ".$conf->db_weathertable_continuous." (weather_id, time, saved, temperature, "
				."rainfall, wind_direction, wind_speed, air_pressure, light_intensity) VALUES(?, ?, NOW(), ?, ?, ?, ?, ?, ?)";

		$statement = $db->prepare($sql);
		if(!$statement)
			returnResponse("503", $db->error);
		$statement->bind_param("isdisdid",
				$weather_id,
				$weather_data->{'time'},
				$weather_data->{'temperature'},
				$weather_data->{'rainfall'},
				$weather_data->{'wind_direction'},
				$weather_data->{'wind_speed'},
				$weather_data->{'air_pressure'},
				$weather_data->{'light_intensity'}
		);

		if(!$statement->execute())
			returnResponse("503", $db->error);
		$statement->close();


	} else {
		// arduino_id not found --> error
		returnResponse("503", "ArduinoID not found");
	}

	mysqli_close($db);

}


function getWeatherID($db, $conf, $arduino_id, $date, $location_id) {

	$sql = "SELECT weather_id FROM ".$conf->db_weathertable." WHERE arduino_id=? AND date=? AND location_id=?";
	$statement = $db->prepare($sql);
	if(!$statement)
		returnResponse("503", $db->error);
	$statement->bind_param("isi", $arduino_id, $date, $location_id);
	$statement->execute();
	$statement->bind_result($weather_id);
	$statement->fetch();
	$statement->close();

	return $weather_id;
}


// Return a customized HTTP-response
function returnResponse($statusCode, $message) {
	http_response_code($statusCode);
	echo "{status-code: ".$statusCode.", message: \"".$message."\"}";
	die();
}



?>
