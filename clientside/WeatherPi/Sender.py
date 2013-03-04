import ConfigParser, os, logging
from EncryptorWrapper import encryptData, decryptData, getSessionkey,encryptDataAES
import urllib, urllib2, sys, json

class RaspiSubmitter():
	def getData(self):
		pass

	def submit(self):
		config = Configer('config/config.cfg') 
		for weatherfile in getFiles():
			
			# Create sessionkey and initialization value for AES decryption
			sessionkey = getSessionkey()
			iv= os.urandom(16)
			
			# Retrieve a dictionary from the file which contains the according data in json format and add a field which contains the date. 
			# This date is saved in the filename
			json_data = retrieveJsonAsTextAndAddTime("data/todo/" + weatherfile)
			
			#Dump the dict as a string in json format
			filecontent = json.dumps(json_data)
			
			#prepare the payload for the POST request and send it
			data={'apikey':config.apikey,'iv': iv ,'sessionkey': encryptData(sessionkey, config.pubKeyPath), 'msg':encryptDataAES(filecontent, sessionkey, iv)}
			req = urllib2.Request(config.server, urllib.urlencode(data))
			
			try:
				response = urllib2.urlopen(req)
				if response.getcode == 401:
					pass #todo: copyfile

			except urllib2.URLError, e:
				logging.error("Could not post data from file '%s' (%s)", weatherfile, str(e))
				exit(1)

class Configer():
	def __init__(self, filename):
		self.filename = filename
		self.config = ConfigParser.ConfigParser()
		self.config.read(self.filename)
		self.server = self.config.get('main', 'server')
		self.apikey = self.config.get('main', 'apikey')
		self.pubKeyPath = self.config.get('main', 'pubKeyPath')

def getFiles():
	for f in os.listdir("data/todo"):
		if f.endswith(".txt"):
			yield f

def file_get_contents(filename):
	with open(filename) as f:
		return f.read()

def retrieveJsonAsTextAndAddTime(jsonFileName):
		js = open(jsonFileName)
		json_data = json.load(js)
		js.close()

		json_data['date']= jsonFileName.split('/')[-1].split('.')[0]
		
		return json_data