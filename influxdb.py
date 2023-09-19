from influxdb_client import InfluxDBClient, Point
from influxdb_client.client.write_api import SYNCHRONOUS

url = 'http://10.1.70.4:8086/'
token = 'GBrTQl7C-3RDzIkG_7wNM4hwLPhgweF9CBso-4x6fuvuc1m8I8VxKvwfYckeQqLECm-_BcUAbVjaIZfVAe0pqg=='
org = 'Weiss-GmbH'
buckets = ['plc_raw',
           'plc_dS',
           'sensor_raw',
           'sensor_dS']

client = InfluxDBClient(url=url, token=token, org=org)

# write_api = client.write_api(write_options=SYNCHRONOUS)
query_api = client.query_api()

# p = Point("my_measurement").tag("location", "Prague").field("temperature", 25.3)

# write_api.write(bucket=bucket, record=p)

## using Table structure
tables = query_api.query(f'from(bucket:"{buckets[0]}") |> range(start: -10m)')
# tables = query_api.query('SHOW DATABASES')

# print(tables)
for table in tables:
    print(f'bucket0: {buckets[0]}')
    print(table)
    for row in table.records:
        print (row.values)


# ## using csv library
# csv_result = query_api.query_csv('from(bucket:"my-bucket") |> range(start: -10m)')
# val_count = 0
# for row in csv_result:
#     for cell in row:
#         val_count += 1