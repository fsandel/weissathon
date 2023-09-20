// data_service.dart
import 'package:flutter/material.dart';
import 'package:weiss/api/request.dart';

class DataService {
  static List<dynamic> data = [];

  static Future<List> fetchData() async {
    try {
      final List fetchedData = await Request.fetchData();
      data = fetchedData;
      return data;
    } catch (e) {
      // Handle errors
      debugPrint("1. Error fetching data: $e");
      return [];
    }
  }
}
