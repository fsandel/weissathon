from influxdb_client import InfluxDBClient, QueryApi

import json

# function to query all the data we want and store it in a dictionary
def queryAll(timeframe: str = 'start: -730h') -> dict:

  # creating empty dictionary
  return_dict: dict = dict()

  # setting up base values to login into db
  token: str = 'GBrTQl7C-3RDzIkG_7wNM4hwLPhgweF9CBso-4x6fuvuc1m8I8VxKvwfYckeQqLECm-_BcUAbVjaIZfVAe0pqg=='
  url: str = 'http://10.1.70.4:8086/'
  org: str = 'Weiss-GmbH'

  # setting up client and client api
  client: InfluxDBClient = InfluxDBClient(url=url, token=token, org=org)
  query_api: QueryApi = client.query_api()



  # querying all the data from the specified timeframe and bucket from the db
  tables: TableList = query_api.query(f'from(bucket:"sensor_dS") |> range({timeframe})')
  data: json = json.loads(tables.to_json())

  # creating empty lists to store data that should be put into dictionary later
  temperature_value: list = []
  temperature_time: list = []

  kionixX_value: list = []
  kionixX_time: list = []
  kionixY_value: list = []
  kionixY_time: list = []
  kionixZ_value: list = []
  kionixZ_time: list = []

  # looping through the queried data, checking if the value fits with the one we want
  # and then storing the datapoint with their timestamp into the list
  for entry in data:
    if entry['_measurement'] == 'temperature':
      temperature_value.append(entry['_value'])
      temperature_time.append(entry['_time'])
    elif entry['_field'] == 'rms_high_frequency':
      if entry['sensor'] == 'kionixX':
        kionixX_value.append(entry['_value'])
        kionixX_time.append(entry['_time'])
      elif entry['sensor'] == 'kionixY':
        kionixY_value.append(entry['_value'])
        kionixY_time.append(entry['_time'])
      elif entry['sensor'] == 'kionixZ':
        kionixZ_value.append(entry['_value'])
        kionixZ_time.append(entry['_time'])

  # adding the lists into the dictionary as tuple, with their field as key
  return_dict['temperature'] = (temperature_time, temperature_value)
  return_dict['kionixX'] = (kionixX_time, kionixX_value)
  return_dict['kionixY'] = (kionixY_time, kionixY_value)
  return_dict['kionixZ'] = (kionixZ_time, kionixZ_value)



  # querying all the data from the specified timeframe and bucket from the db
  tables: TableList = query_api.query(f'from(bucket:"plc_dS") |> range({timeframe})')
  data: json = json.loads(tables.to_json())

  # creating empty lists to store data that should be put into dictionary later
  current_value: list = []
  current_time: list = []

  # looping through the queried data, checking if the value fits with the one we want
  # and then storing the datapoint with their timestamp into the list
  for entry in data:
    if entry['_field'] == 'RmsLastCycle':
      current_value.append(entry['_value'])
      current_time.append(entry['_time'])

  # adding the lists into the dictionary as tuple, with their field as key
  return_dict['current'] = (current_time, current_value)

  # returning the dicitonary
  return return_dict
