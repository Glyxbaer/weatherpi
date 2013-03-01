from WeatherPi import Sender
import sys, logging

class WeatherPiCore():
	def dailySubmit(self):
		submitter = Sender.RaspiSubmitter()
		submitter.submit()
	def intervalSubmit(self):
		submitter = Sender.RaspiSubmitter()
		submitter.submit()
	def Submit():
		pass

if __name__ == "__main__":
	logging.basicConfig(filename="logs/WeatherPi.log", level=logging.INFO, format='[%(asctime)s] - %(levelname)s: %(message)s', datefmt='%Y-%m-%d %H:%M:%S')
	if len(sys.argv) > 1:
		WeatherPiCore().dailySubmit()
	else:
		WeatherPiCore().intervalSubmit()
