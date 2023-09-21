import json
import statistics

from DatabaseQuery import queryAll
from utils import average

# global settings for our traffic lights
GREEN: int = 1
YELLOW: int = 2
RED: int = 3

# standard messages for the json
MESSAGES: list = ['placeholder',
            'Everything seem\'s like it\'s supposed to be',
            'Some routine check in the future might be very useful',
            'Contact Weiss as soon as possible, some major parts may need some checkup']


# function that compares the recent average to the one from the whole dataset
# then uses the differences to give a Green, Yellow or Red status
def checkAverageDeviation(timestamp: list, values: list) -> int:
  # derivation factor for traffic light
  sigma_distance = 0.5

  # calcutaion of weekly and monthly averages and standard derivcation
  monthly_average = average(values)
  weekly_average = average(values[:len(values) // 4])
  deviation = statistics.pstdev(values)

  # gives the traffic status based on the difference from weekly to monthl
  if (weekly_average > monthly_average + 2 * sigma_distance * deviation or weekly_average < monthly_average - 2 * sigma_distance * deviation):
      return RED
  if (weekly_average > monthly_average + sigma_distance * deviation or weekly_average < monthly_average - sigma_distance * deviation):
      return YELLOW
  return GREEN


# queries the database based on our values and creates the response json
def createJson() -> json:
  # setup of the base timeframe
  timeframe: str = 'start: -30h'

  #creation of empty json
  return_json: json = {}

  # queries all the data from the buckets with the keys specified inside
  data_dictionary: dict = queryAll(timeframe)


  # getting temperature data from dictionary
  temperature_data: tuple = data_dictionary['temperature']
  time: list = temperature_data[0]
  values: list = temperature_data[1]
  temperature: dict = {}

  # putting temperature data into json
  return_json['temperature'] = temperature
  return_json['temperature']['name'] = 'Temperature'
  return_json['temperature']['description'] = 'this is the temperature of the machine'
  status_temperature: int = checkAverageDeviation(time, values)
  return_json['temperature']['status'] = status_temperature
  return_json['temperature']['average'] = average(values)
  return_json['temperature']['message'] = MESSAGES[status_temperature]
  return_json['temperature']['time'] = time
  return_json['temperature']['value'] = values


  # getting current data from dictionary
  current_data: tuple = data_dictionary['current']
  time: list = current_data[0]
  values: list = current_data[1]
  current: dict = {}

  # putting current data into json
  return_json['current'] = current
  return_json['current']['name'] = 'Current'
  return_json['current']['description'] = 'This is the root mean square of the current'
  status_current: int = checkAverageDeviation(time, values)
  return_json['current']['status'] = status_current
  return_json['current']['average'] = average(values)
  return_json['current']['message'] = MESSAGES[status_current]
  return_json['current']['time'] = time
  return_json['current']['value'] = values


  # getting x-vibration data from dictionary
  kionix_data_x: tuple = data_dictionary['kionixX']
  time: list = kionix_data_x[0]
  values: list = kionix_data_x[1]
  vibration_kionixX: dict = {}

  # putting x-vibration data into json
  return_json['vibration_kionixX'] = vibration_kionixX
  return_json['vibration_kionixX']['name'] = 'vibration_kionixX'
  return_json['vibration_kionixX']['description'] = 'This is the vibration of the kinxix sensor into x direciton'
  status_vib_x: int = checkAverageDeviation(time, values)
  return_json['vibration_kionixX']['status'] = status_vib_x
  return_json['vibration_kionixX']['average'] = average(values)
  return_json['vibration_kionixX']['message'] = MESSAGES[status_vib_x]
  return_json['vibration_kionixX']['time'] = time
  return_json['vibration_kionixX']['value'] = values


  # getting y-vibration data from dictionary
  kionix_data_y: tuple = data_dictionary['kionixY']
  time: list = kionix_data_y[0]
  values: list = kionix_data_y[1]
  vibration_kionixY: dict = {}

  # putting y-vibration data into json
  return_json['vibration_kionixY'] = vibration_kionixY
  return_json['vibration_kionixY']['name'] = 'vibration_kionixY'
  return_json['vibration_kionixY']['description'] = 'This is the vibration of the kinxix sensor into y direciton'
  status_vib_y: int = checkAverageDeviation(time, values)
  return_json['vibration_kionixY']['status'] = status_vib_y
  return_json['vibration_kionixY']['average'] = average(values)
  return_json['vibration_kionixY']['message'] = MESSAGES[status_vib_y]
  return_json['vibration_kionixY']['time'] = time
  return_json['vibration_kionixY']['value'] = values


  # getting z-vibration data from dictionary
  kionix_data_z: tuple = data_dictionary['kionixZ']
  time: list = kionix_data_z[0]
  values: list = kionix_data_z[1]
  vibration_kionixZ: dict = {}

  # putting z-vibration data into json
  return_json['vibration_kionixZ'] = vibration_kionixZ
  return_json['vibration_kionixZ']['name'] = 'vibration_kionixZ'
  return_json['vibration_kionixZ']['description'] = 'This is the vibration of the kinxix sensor into z direciton'
  status_vib_z: int = checkAverageDeviation(time, values)
  return_json['vibration_kionixZ']['status'] = status_vib_z
  return_json['vibration_kionixZ']['average'] = average(values)
  return_json['vibration_kionixZ']['message'] = MESSAGES[status_vib_z]
  return_json['vibration_kionixZ']['time'] = time
  return_json['vibration_kionixZ']['value'] = values


  # calculation of the total status and saving it into the json
  return_json['status'] = max([status_temperature,
                                status_current,
                                status_vib_x,
                                status_vib_y,
                                status_vib_z])

  # return of the json
  return return_json
