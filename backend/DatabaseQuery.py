from influxdb_client import InfluxDBClient

import json

def query(sensor: str,
          measurement: str,
          field: str,
          url: str = 'http://10.1.70.4:8086/', 
          token: str = 'GBrTQl7C-3RDzIkG_7wNM4hwLPhgweF9CBso-4x6fuvuc1m8I8VxKvwfYckeQqLECm-_BcUAbVjaIZfVAe0pqg==',
          buckets: str = 'sensor_dS', 
          org: str = 'Weiss-GmbH',
          timeframe: str = 'start: -10000h'
          ) -> tuple:
  client = InfluxDBClient(url=url, token=token, org=org)
  query_api = client.query_api()
  tables = query_api.query(f'from(bucket:"{buckets}") |> range({timeframe})')
  data = json.loads(tables.to_json())
  time = []
  value_array = []
  for entry in data:
    # print(json.dumps(entry, indent=2))
    if (buckets.find('sensor') != -1):
      if measurement == 'vibration' and entry['_measurement'] == measurement:
        if entry['sensor'] == sensor:
          if entry['_field'] == field:
            time.append(entry['_time'])
            value_array.append(entry['_value'])
      elif measurement == 'temperature' and entry['_measurement'] == measurement:
        time.append(entry['_time'])
        value_array.append(entry['_value'])
    elif(buckets.find('plc') != -1):
        if entry['_field'] == field:
          time.append(entry['_time'])
          value_array.append(entry['_value'])
  return_tpl = (time, value_array)
  return return_tpl


def queryAll(timeframe: str = 'start: -730h') -> dict:

  return_dict = dict()

  token: str = 'GBrTQl7C-3RDzIkG_7wNM4hwLPhgweF9CBso-4x6fuvuc1m8I8VxKvwfYckeQqLECm-_BcUAbVjaIZfVAe0pqg=='
  url: str = 'http://10.1.70.4:8086/'
  org: str = 'Weiss-GmbH'

  client = InfluxDBClient(url=url, token=token, org=org)
  query_api = client.query_api()

  tables = query_api.query(f'from(bucket:"sensor_dS") |> range({timeframe})')
  data = json.loads(tables.to_json())

  temperature_value = []
  temperature_time = []

  kionixX_value = []
  kionixX_time = []
  kionixY_value = []
  kionixY_time = []
  kionixZ_value = []
  kionixZ_time = []

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

  return_dict['temperature'] = (temperature_time, temperature_value)
  return_dict['kionixX'] = (kionixX_time, kionixX_value)
  return_dict['kionixY'] = (kionixY_time, kionixY_value)
  return_dict['kionixZ'] = (kionixZ_time, kionixZ_value)

  tables = query_api.query(f'from(bucket:"plc_dS") |> range({timeframe})')
  data = json.loads(tables.to_json())

  current_value = []
  current_time = []

  for entry in data:
    if entry['_field'] == 'RmsLastCycle':
      current_value.append(entry['_value'])
      current_time.append(entry['_time'])

  return_dict['current'] = (current_time, current_value)

  return return_dict
