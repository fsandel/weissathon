from influxdb_client import InfluxDBClient, Point
from influxdb_client.client.write_api import SYNCHRONOUS
from matplotlib import pyplot as plt

import json
def query(*argv,
          url: str = 'http://10.1.70.4:8086/', 
          token: str = 'GBrTQl7C-3RDzIkG_7wNM4hwLPhgweF9CBso-4x6fuvuc1m8I8VxKvwfYckeQqLECm-_BcUAbVjaIZfVAe0pqg==',
          buckets: str = 'plc_dS', 
          org: str = 'Weiss-GmbH',
          timeframe: str = 'start: -10000h'
          ) -> dict:
  client = InfluxDBClient(url=url, token=token, org=org)
  query_api = client.query_api()
  tables = query_api.query(f'from(bucket:"{buckets}") |> range({timeframe})')
  data = json.loads(tables.to_json())
  return_dict = dict()
  for arg in argv:
    time = []
    value_array = []
    for entry in data:
      if entry['_field'] == arg:
        time.append(entry['_time'])
        value_array.append(entry['_value'])
    tpl = (time, value_array)
    return_dict.update({arg: tpl})
  return return_dict
