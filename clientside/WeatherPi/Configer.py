import ConfigParser

class Configer():
	def __init__(self, filename):
		self.filename = filename
		self.config = ConfigParser.ConfigParser()
		self.config.read('config/config.cfg')
		self.server = config.get('main', 'server')
		self.apiKey = config.get('main', 'apikey')
