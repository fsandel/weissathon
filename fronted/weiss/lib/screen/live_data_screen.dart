import 'package:flutter/material.dart';
import 'package:weiss/widgets/alert.dart';
import 'package:weiss/widgets/everything_okay.dart';
import 'package:weiss/widgets/warning.dart';

class LiveDataScreen extends StatefulWidget {
  const LiveDataScreen({super.key});

  @override
  State<LiveDataScreen> createState() => _LiveDataScreenState();
}

class _LiveDataScreenState extends State<LiveDataScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [Alert(), Warning(), EverythingOkay()],
    );
  }
}
