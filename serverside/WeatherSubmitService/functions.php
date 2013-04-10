<?php 


/* BEGIN USER FUNCTIONS */

// Create a unique API-key for a RaspberryPi (check against DB to be sure)
function generateAPIkey($conf) {
	do {
		$apikey = md5(uniqid(rand(), true));
	}
	while (getPrivateKey($conf, $apikey));

	return $apikey;
}

// Generate a public/private keyPair, returns an array with both keys
function generateRSAKeyPair() {

	$keyPairCreator = openssl_pkey_new();
	$publicKey = openssl_pkey_get_details($keyPairCreator);
	$publicKey = $publicKey["key"];
	openssl_pkey_export($keyPairCreator, $privateKey);

	return array("publicKey"=>$publicKey, "privateKey"=>$privateKey);
}

/* END USER FUNCTIONS */


/* BEGIN DATABASE FUNCTIONS */

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

/* END DATABASE FUNCTIONS */


/* BEGIN CRYPT FUNCTIONS */


// Decrypt the SessionKey (RSA)
function decryptSessionKey($pk, $data) {
	openssl_private_decrypt($data, $plainSessionKey, openssl_pkey_get_private($pk), OPENSSL_PKCS1_OAEP_PADDING);
	openssl_free_key(openssl_pkey_get_private($pk));
	return $plainSessionKey;
}

// Decrypt the message (AES)
function decryptMessage($key, $data, $iv) {
	return trim(mcrypt_decrypt(MCRYPT_RIJNDAEL_128, $key, $data, MCRYPT_MODE_CFB, $iv));
}

/* END CRYPT FUNCTIONS */

?>