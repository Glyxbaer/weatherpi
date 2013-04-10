<?php 


include_once("functions.php");
include_once("conf/WeatherDBConfig.php");
$conf = new WeatherDBConfig();

$keyArray = generateRSAKeyPair();
$privateKey = $keyArray["privateKey"];
$publicKey = $keyArray["publicKey"];


$plaintext = generateAPIkey($conf);

echo "Plaintext: ".$plaintext."<br>";

openssl_public_encrypt($plaintext, $encrypted, $publicKey);
echo "Encrypted data: ".$encrypted."<br>";

openssl_private_decrypt($encrypted, $decrypted, $privateKey);
echo "Decrypted data: ".$decrypted."<br>";

openssl_free_key(openssl_pkey_get_private($privateKey));
openssl_free_key(openssl_pkey_get_public($publicKey));






?>