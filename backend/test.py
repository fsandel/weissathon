from DatabaseQuery import query
from CleanValues import createJson
from matplotlib import pyplot as plt

measurements = ['RmsLastCycle', 'RmsLastCycle']

all_entries = query(sensor='kionixX', measurement='temperature', field='During_Cycle_Current[A]', buckets='sensor_dS', timeframe='start: -730h')
# all_entries = query(sensor='adxlX', measurement='temperature', field='temp')


plt.plot(*all_entries)
plt.show()
# str = all_entries[1][0]
# plt.plot(str.split('|'))
# plt.show()

