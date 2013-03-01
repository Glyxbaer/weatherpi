from WeatherPi import Sender
import sys

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
	if len(sys.argv) > 1:
		WeatherPiCore().dailySubmit()
	else:
		WeatherPiCore().intervalSubmit()
