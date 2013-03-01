import ConfigParser, os, logging
from EncryptorWrapper import encryptData
import urllib, urllib2

class RaspiSubmitter():
	def getData(self):
		pass

	def submit(self):
		config = Configer('config/config.cfg') 
		for jsonfile in getFiles():
			jsonfile = "data/todo/" + jsonfile
			filecontent = file_get_contents(jsonfile)
			data = "apikey=" + config.apikey + "data = " + encryptData(filecontent, "conf/RSA.pub")
			req = urllib2.Request(config.server, data)
			

			try:
				response = urllib2.urlopen(req)
				if response.getcode == 401:
					pass #todo: copyfile
			except urllib2.URLError, e:
				logging.error("Could not post data from file '%s' (%s)", jsonfile, str(e))





class Configer():
	def __init__(self, filename):
		self.filename = filename
		self.config = ConfigParser.ConfigParser()
		self.config.read(self.filename)
		self.server = self.config.get('main', 'server')
		self.apikey = self.config.get('main', 'apikey')

def getFiles():
	for f in os.listdir("data/todo"):
		if f.endswith(".txt"):
			yield f

def file_get_contents(filename):
	with open(filename) as f:
		return f.read()
