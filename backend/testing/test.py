from DatabaseQuery import query, queryAll
from CleanValues import createJson
from matplotlib import pyplot as plt

measurements = ['RmsLastCycle', 'RmsLastCycle']

# value = 'peak_high_frequency'
# all_entries = query(sensor='adxlX',
#                     measurement='vibration',
#                     field=value,
#                     buckets='sensor_dS',
#                     timeframe='start: -30h')

all_entries = queryAll()

keys = ['temperature',
        'kionixX',
        'kionixY',
        'kionixZ',
        'adxlX',
        'adxlY',
        'adxlZ',
        'current']

# plt.plot(*all_entries)
# plt.title(value)
# plt.show()
