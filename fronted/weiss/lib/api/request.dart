import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Request {
  static const String apiUrl = "http://10.1.76.105:5000/errors";

  static Future<List<double>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<double> result = data.cast<double>();
        print(result);
        return result;
      } else {
        throw Exception('1: Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
