import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weiss/widgets/custom_app_bar.dart';
import 'package:weiss/widgets/machine_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showIcon: false,
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          MachineData(),
        ]),
      ),
    );
  }
}
