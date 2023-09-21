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
        elif (buckets.find('plc') != -1):
            if entry['_field'] == field:
                time.append(entry['_time'])
                value_array.append(entry['_value'])
    return_tpl = (time, value_array)
    return return_tpl
