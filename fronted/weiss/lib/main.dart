import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weiss/screen/home_screen.dart';
import 'package:weiss/services/notification_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeissApp',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 91, 91, 91))),
      home: const HomeScreen(),
    );
  }
}
