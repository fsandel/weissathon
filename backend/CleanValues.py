import json
import statistics
from DatabaseQuery import queryAll

GREEN = 1
YELLOW = 2
RED = 3

MESSAGES = ['placeholder',
            'Everything seem\'s like it\'s supposed to be',
            'Some routine check in the future might be very useful',
            'Contact Weiss as soon as possible, some major parts may need some checkup']


def average(lst: list) -> float:
    return sum(lst) / len(lst)


def checkAverageDeviation(timestamp: list, values: list) -> int:
    sigma_distance = 1.5

    monthly_average = average(values)
    weekly_average = average(values[:len(values) // 4])
    deviation = statistics.pstdev(values)

    if (weekly_average > monthly_average + 2 * sigma_distance * deviation or weekly_average < monthly_average - 2 * sigma_distance * deviation):
        return RED
    if (weekly_average > monthly_average + sigma_distance * deviation or weekly_average < monthly_average - sigma_distance * deviation):
        return YELLOW
    return GREEN


def createJson() -> json:

    timeframe = 'start: -30h'
    return_json = {}
    return_json['status'] = GREEN

    data_dictionary = queryAll(timeframe)

    temperature_data: tuple = data_dictionary['temperature']
    time = temperature_data[0]
    values = temperature_data[1]
    temperature = {}
    return_json['temperature'] = temperature
    return_json['temperature']['name'] = 'Temperature'
    return_json['temperature']['description'] = 'this is the temperature of the machine'
    status = checkAverageDeviation(time, values)
    return_json['temperature']['status'] = status.__str__()
    return_json['temperature']['average'] = average(values)
    return_json['temperature']['message'] = MESSAGES[status]
    return_json['temperature']['time'] = time
    return_json['temperature']['value'] = values

    current_data: tuple = data_dictionary['current']
    time = current_data[0]
    values = current_data[1]
    current = {}
    return_json['current'] = current
    return_json['current']['name'] = 'Current'
    return_json['current']['description'] = 'This is the root mean square of the current'
    status = checkAverageDeviation(time, values)
    return_json['current']['status'] = status.__str__()
    return_json['current']['average'] = average(values)
    return_json['current']['message'] = MESSAGES[status]
    return_json['current']['time'] = time
    return_json['current']['value'] = values

    kionix_data_x = data_dictionary['kionixX']
    time = kionix_data_x[0]
    values = kionix_data_x[1]

    vibration_kionixX = {}
    return_json['vibration_kionixX'] = vibration_kionixX
    return_json['vibration_kionixX']['name'] = 'vibration_kionixX'
    return_json['vibration_kionixX']['description'] = 'This is the vibration of the kinxix sensor into x direciton'
    status = checkAverageDeviation(time, values)
    return_json['vibration_kionixX']['status'] = status.__str__()
    return_json['vibration_kionixX']['average'] = average(values)
    return_json['vibration_kionixX']['message'] = MESSAGES[status]
    return_json['vibration_kionixX']['time'] = time
    return_json['vibration_kionixX']['value'] = values

    kionix_data_y = data_dictionary['kionixY']
    time = kionix_data_y[0]
    values = kionix_data_y[1]

    vibration_kionixY = {}
    return_json['vibration_kionixY'] = vibration_kionixY
    return_json['vibration_kionixY']['name'] = 'vibration_kionixY'
    return_json['vibration_kionixY']['description'] = 'This is the vibration of the kinxix sensor into y direciton'
    status = checkAverageDeviation(time, values)
    return_json['vibration_kionixY']['status'] = status.__str__()
    return_json['vibration_kionixY']['average'] = average(values)
    return_json['vibration_kionixY']['message'] = MESSAGES[status]
    return_json['vibration_kionixY']['time'] = time
    return_json['vibration_kionixY']['value'] = values

    kionix_data_z = data_dictionary['kionixZ']
    time = kionix_data_z[0]
    values = kionix_data_z[1]

    vibration_kionixZ = {}
    return_json['vibration_kionixZ'] = vibration_kionixZ
    return_json['vibration_kionixZ']['name'] = 'vibration_kionixZ'
    return_json['vibration_kionixZ']['description'] = 'This is the vibration of the kinxix sensor into z direciton'
    status = checkAverageDeviation(time, values)
    return_json['vibration_kionixZ']['status'] = status.__str__()
    return_json['vibration_kionixZ']['average'] = average(values)
    return_json['vibration_kionixZ']['message'] = MESSAGES[status]
    return_json['vibration_kionixZ']['time'] = time
    return_json['vibration_kionixZ']['value'] = values

    return return_json
