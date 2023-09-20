import 'package:flutter/material.dart';
import 'package:weiss/api/mqtt_client.dart';
import 'package:weiss/widgets/alert.dart';
import 'package:weiss/widgets/warning.dart';
import 'package:weiss/widgets/everything_okay.dart';

class LiveDataScreen extends StatefulWidget {
  const LiveDataScreen({Key? key}) : super(key: key);

  @override
  State<LiveDataScreen> createState() => _LiveDataScreenState();
}

class _LiveDataScreenState extends State<LiveDataScreen> {
  String? measuredCycleTime = 'N/A';

  @override
  void initState() {
    super.initState();

    // Listen to the MQTT stream and update the UI
    mqttStreamController.stream.listen((data) {
      setState(() {
        measuredCycleTime = data;
      });
    });
  }

  @override
  void dispose() {
    mqttStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Alert(),
        Warning(),
        EverythingOkay(),
        Text('Measured Cycle Time: $measuredCycleTime'),
      ],
    );
  }
}
