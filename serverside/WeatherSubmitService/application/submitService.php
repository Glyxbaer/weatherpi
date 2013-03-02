<?php



if($_POST["apikey"] && sizeof($_POST["apikey"]) == 20) {

	include_once("conf/DBconfig.inc.php");
	include_once("lib/phpseclib/Crypt/RSA.php");

	if(validateKey($_POST["apikey"])) {

		// Fetch the private RSA-Key from the DB
		$privateKey = getPrivateKey();
		// Decrypt the sessionKey for the AES-Decryption
		$sessionKey = decryptSessionKey($privateKey, $_POST["sessionkey"]);
		// Decrypt the actual message
		$message = decryptMessage($sessionKey, $_POST["msg"]);
		// Transform the JSON into a PHP-Object
		$data = json_decode($message);
		// Insert the Object into the DB
		insertIntoDB($data);

		returnResponse("200", "Successfully inserted");


	} else {
		returnResponse("403", "API-key not valid");
	}




} else {
	returnResponse("401", "No API-key submitted");
}


// Check if API-key is in the database
function validateKey($key) {

	$valid = false;

	$db = mysqli_connect($db_server, $db_user, $db_pw, $db_name);

	$sql = "SELECT * FROM ".$db_keytable." WHERE api_key='?'";

	$statement = $db->prepare($sql);
	if(!$statement) {
		die ("Query couldn't be prepared... ".$db->error);
	}

	$statement->bind_param("s", $key);
	$result = $statement->execute();

	if (!$result) {
		die("Query couldn't be executed: ".$db->error);
	}

	if ($result->num_rows)
		$valid = true;

	mysqli_close($db);

	return valid;
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
function insertIntoDB($data_object) {

	$db = mysqli_connect($db_server, $db_user, $db_pw, $db_name);

	$arduino_id = $data_object->{'arduino-id'};
	$date = $data_object->{'date'};
	$weather_data = $data_object->{'data'};

	// Get the current location of the arduino
	$sql = "SELECT location_id FROM ".$db_arduinotable." WHERE arduino_id=?";
	$statement = $db->prepare($sql);
	if(!$statement) {
		die ("Query couldn't be prepared... ".$db->error);
	}
	$statement->bind_param("s", $arduino_id);
	if($result->num_rows > 0) {
		// location_id found --> arduino exists
		$row = $result->fetch_assoc();
		$location_id = $row["location_id"];

		// Check if there already exists an entry for this id at this date and the current location
		$sql = "SELECT weather_id FROM ".$db_weathertable." WHERE arduino_id=? AND date=? AND location_id=?";

		$statement = $db->prepare($sql);
		if(!$statement) {
			die ("Query couldn't be prepared... ".$db->error);
		}
		$statement->bind_param("sss", $arduino_id, $date, $location_id);
		$result = $statement->execute();
		if($result->num_rows > 0) {
			// entry already exists --> get weather_id
			$row = $result->fetch_assoc();
			$weather_id = $row["weather_id"];


		} else {
			// entry doesn't exist --> create a new one
			$sql = "INSERT INTO ".$db_weathertable." (arduino_id, date, location_id) VALUES(?, ?, ?)";
			$statement = $db->prepare($sql);
			if(!$statement) {
				die ("Query couldn't be prepared... ".$db->error);
			}
			$statement->bind_param("sss", $arduino_id, $date, $location_id);
			if(!$statement->execute()) {
				die("Query couldn't be executed: ".$db->error);
			}
				
			// get the weather_id of the inserted entry
			$sql = "SELECT weather_id FROM ".$db_weathertable." WHERE arduino_id=? AND date=? AND location_id=?";
				
			$statement = $db->prepare($sql);
			if(!$statement) {
				die ("Query couldn't be prepared... ".$db->error);
			}
			$statement->bind_param("sss", $arduino_id, $date, $location_id);
			$result = $statement->execute();
			$row = $result->fetch_assoc();
			$weather_id = $row["weather_id"];
		}

		// weather_id has been fetched --> now insert the actual data




	} else {
		// arduino_id not found --> error
	}

	mysqli_close($db);

}


// Forge a custom response
function returnResponse($statusCode, $message) {

}



?>
