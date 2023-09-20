from DatabaseQuery import query
from CleanValues import createJson

measurements = ['RmsLastCycle', 'RmsLastCycle']

all_entries = query(*measurements)

print(createJson(all_entries, measurements))

