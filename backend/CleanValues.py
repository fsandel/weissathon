import json
from DatabaseQuery import query
# def createJson(allValues: dict, measurements: list) -> json:
#   return json.dumps(allValues[measurements[0]][1], indent=2)

GREEN = '1'
YELLOW = '2'
RED = '3'

def createJson() -> json:
  all_entries = query(sensor='kionixX',
                      measurement='temperature',
                      field='During_Cycle_Current[A]',
                      buckets='sensor_dS',
                      timeframe='start: -30h')
  # return_json = json()
  return_json = {}
  return_json['status'] = GREEN

  temperature = {}
  return_json['temperature'] = temperature
  return_json['temperature']['name'] = 'temperature'
  return_json['temperature']['description'] = 'this is the temperature of the machine'
  return_json['temperature']['status'] = GREEN
  return_json['temperature']['time'] = all_entries[0]
  return_json['temperature']['value'] = all_entries[1]

  temperature2 = {}
  return_json['temperature2'] = temperature2
  return_json['temperature2']['name'] = 'temperature2'
  return_json['temperature2']['description'] = 'this is the temperature of the machine'
  return_json['temperature2']['status'] = GREEN
  return_json['temperature2']['time'] = all_entries[0]
  return_json['temperature2']['value'] = all_entries[1]


  return return_json