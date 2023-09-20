import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Data {
  final int status;
  final Map<String, dynamic> temperature;
  final Map<String, dynamic> current;

  Data(
      {required this.status, required this.temperature, required this.current});

  factory Data.fromJson(Map<String, dynamic> json) {
    // Get the temperature data
    final temperatureData = json['temperature'];
    final currentData = json['current'];

    // Check if the temperature data has a `time` property
    if (temperatureData.containsKey('time')) {
      // Create a list of time values
      final timeList = temperatureData['time'] as List<dynamic>;

      // Create a list of value values
      final valueList = temperatureData['value'] as List<dynamic>;

      // Create a list of time values
      final currenttimeList = currentData['time'] as List<dynamic>;

      // Create a list of value values
      final currentValueList = currentData['value'] as List<dynamic>;

      // Create a new Data object with the temperature data
      return Data(status: json['status'], temperature: {
        'name': temperatureData['name'],
        'description': temperatureData['description'],
        'status': temperatureData['status'],
        'average': temperatureData['average'],
        'message': temperatureData['message'],
        'time': timeList,
        'value': valueList,
      }, current: {
        'name': currentData['name'],
        'description': currentData['description'],
        'status': currentData['status'],
        'average': currentData['average'],
        'message': currentData['message'],
        'time': currenttimeList,
        'value': currentValueList,
      });
    } else {
      throw Exception('2: Failed to fetch data');
    }
  }
}

class Request {
  static const String apiUrl = "http://10.1.76.108:5000/errors";

  static Future<List<Data>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final dataSet = Data.fromJson(data);

        // Create a list containing the parsed data
        final List<Data> result = [dataSet];
        return result;
      } else {
        throw Exception('1: Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
