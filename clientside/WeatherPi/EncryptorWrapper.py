import M2Crypto, os,sys,Crypto
from M2Crypto import EVP
from Crypto.Cipher import AES
from Crypto import Random


def encryptData(data, pubKeyPath):
	
	rsa = M2Crypto.RSA.load_pub_key(pubKeyPath)
	return rsa.public_encrypt(data, M2Crypto.RSA.pkcs1_oaep_padding)
	

def decryptData(data, privKeyPath):
	rsa = M2Crypto.RSA.load_key (privKeyPath)
	return rsa.private_decrypt(data, M2Crypto.RSA.pkcs1_oaep_padding)

def generateIV():
	return Random.new().read(AES.block_size)

def encryptDataAES(plaintext, key, iv):
	
	
	cipher = Crypto.Cipher.AES.new(key, Crypto.Cipher.AES.MODE_CFB, iv)
	return cipher.encrypt(plaintext)

def getSessionkey():
	return Random.new().read(16)
