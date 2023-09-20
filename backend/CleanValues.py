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
  temperature = {}
  return_json['status'] = GREEN
  return_json['temperature'] = temperature
  return_json['temperature']['status'] = GREEN
  return_json['temperature']['name'] = 'temperature'
  return_json['temperature']['time'] = all_entries[0]
  return_json['temperature']['value'] = all_entries[1]
  return_json['temperature']['description'] = 'this is the temperature of the machine'


  return return_json

print(json.dumps(createJson(), indent=2))