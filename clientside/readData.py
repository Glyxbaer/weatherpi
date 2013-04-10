#!/usr/bin/env python

import serial
import datetime
import time

DEVICE = '/dev/ttyAMA0'
BAUD = 9600

class Communicator():
    def __init__(self):
        self._dir = "./data/todo/"
        self._format = "{" \
                       "\n\"arduino-id\": %s," \
                       "\n\"date\": \"%s\"," \
                       "\n\"data\": {" \
                       "\n    \"time\": \"%s\"," \
                       "\n    \"temperature\": %s," \
                       "\n    \"humidity\": %s,"\
                       "\n    \"rainfall\": %s," \
                       "\n    \"wind_direction\": \"%s\"," \
                       "\n    \"wind_speed\": %s," \
                       "\n    \"air_pressure\": %s," \
                       "\n    \"light_intensity\": %s" \
                       "\n    }" \
                       "\n}"

    def _readData(self):
        connection = serial.Serial(3)
        connection.timeout = None
        time.sleep(3)
        print("Benutze Port: " + connection.portstr)

        # Daten vom Arduino anfragen
        connection.write('D'.encode('ascii'))
        # Antwort kommt im Ascii format: b'xxx'\r\n - Umwandlung in xxx
        json = connection.readline().decode('utf-8')[:-2]

        now = datetime.datetime.now()
        name = now.strftime("%Y%m%d %H%M%S") + ".txt"

        # Ausgabe der empfangenen Daten
        print(now.strftime("%d.%m.%Y %H:%M:%S") + " -> " + json)
        file = open(self._dir + name, 'w')
        # JSON Fromat in die Datei schreiben
        file.writelines(self._generateJSON(json, now))
        file.close()
        connection.close()

    def _generateJSON(self, json, now):
        data = json.split(';')
        date = now.strftime("%Y-%m-%d")
        time = now.strftime("%H:%M:%S")
        return self._format%(data[0], date, time, data[1], data[2], 0, data[4], 0, data[6], 0)


print("Beginne das lesen")
com = Communicator()
i = 0
while i < 10:
    com._readData()
    time.sleep(120)