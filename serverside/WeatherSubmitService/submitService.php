<?php


if(isset($_GET["apikey"]) && isset($_GET["sessionkey"]) && isset($_GET["msg"])) {

	include_once("lib/phpseclib/Crypt/RSA.php");
	include_once("conf/WeatherDBConfig.php");
	$conf = new WeatherDBConfig();

	if(validateKey($conf, $_GET["apikey"])) {

		// Fetch the private RSA-Key from the DB
		$privateKey = getPrivateKey();
		// Decrypt the sessionKey for the AES-Decryption
		//$sessionKey = decryptSessionKey($privateKey, $_GET["sessionkey"]);
		// Decrypt the actual message
		//$message = decryptMessage($sessionKey, $_GET["msg"]);
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
	echo $_GET["apikey"]."<br>";
	echo $_GET["sessionkey"]."<br>";
	echo $_GET["msg"]."<br>";
	returnResponse("401", "Required parameters missing");
}


// Check if API-key is in the database
function validateKey($conf, $key) {

	$valid = false;

	$db = mysqli_connect($conf->db_server, $conf->db_user, $conf->db_pw, $conf->db_name);

	$sql = "SELECT * FROM ".$conf->db_keytable." WHERE api_key=?";

	$statement = $db->prepare($sql);
	if(!$statement)
		die ("Query couldn't be prepared... ".$db->error);
	$statement->bind_param("s", $key);
	$statement->execute();
	if($statement->get_result()->fetch_assoc())
		$valid = true;

	$statement->close();
	mysqli_close($db);

	return $valid;
}

// Fetch private key from database
function getPrivateKey() {

	$privateKey = "";

	return $privateKey;
}


// Decrypt the SessionKey (RSA)
function decryptSessionKey($pk, $data) {

	$rsa = new Crypt_RSA();
	$rsa->loadKey($pk);
	$plainMsg = $rsa->decrypt($data);

	return $plainMsg;
}

// Decrypt the message (AES)
function decryptMessage($key, $data) {

	$decoded = base64_decode($data);
	$iv = mcrypt_create_iv(mcrypt_get_iv_size(MCRYPT_RIJNDAEL_256, MCRYPT_MODE_ECB), MCRYPT_RAND);
	$decrypted = trim(mcrypt_decrypt(MCRYPT_RIJNDAEL_256, $mc_key, trim($decoded), MCRYPT_MODE_ECB, $iv));

	return $decrypted;
}

// Insert the data into the DB
function insertIntoDB($conf, $data_object) {

	$db = mysqli_connect($conf->db_server, $conf->db_user, $conf->db_pw, $conf->db_name);

	$arduino_id = $data_object->{'arduino-id'};
	$date = $data_object->{'date'};
	$weather_data = $data_object->{'data'};


	// Get the current location of the arduino
	$sql = "SELECT location_id FROM ".$conf->db_arduinotable." WHERE arduino_id=?";
	$statement = $db->prepare($sql);
	if(!$statement)
		die ("Query couldn't be prepared... ".$db->error);
	$statement->bind_param("i", $arduino_id);
	$statement->execute();
	$location_id = $statement->get_result()->fetch_assoc()["location_id"];
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
				die ("Query couldn't be prepared... ".$db->error);
			$statement->bind_param("isi", $arduino_id, $date, $location_id);
			if(!$statement->execute())
				die("Query couldn't be executed: ".$db->error);

			// get the weather_id of the inserted entry
			$weather_id = getWeatherID($db, $conf, $arduino_id, $date, $location_id);
		}

		// weather_id has been fetched --> now insert the actual data
		echo "WeatherID fetched: ".$weather_id."<br>";
		echo "Beginning insertion...<br>";



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
		die ("Query couldn't be prepared... ".$db->error);
	$statement->bind_param("isi", $arduino_id, $date, $location_id);
	$statement->execute();
	$weather_id = $statement->get_result()->fetch_assoc()["weather_id"];
	$statement->close();

	return $weather_id;
}


// Return a customized HTTP-response
function returnResponse($statusCode, $message) {
	echo "<p>Statuscode: ".$statusCode."<br>Message: ".$message."</p>";
	die();
}



?>
