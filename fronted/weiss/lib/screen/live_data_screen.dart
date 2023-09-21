import 'package:flutter/material.dart';
import 'package:weiss/api/mqtt_client.dart';
import 'package:weiss/services/notification_service.dart';
import 'package:weiss/widgets/alert.dart';
import 'package:weiss/widgets/everything_okay.dart';

class LiveDataScreen extends StatefulWidget {
  const LiveDataScreen({Key? key}) : super(key: key);

  @override
  State<LiveDataScreen> createState() => _LiveDataScreenState();
}

class _LiveDataScreenState extends State<LiveDataScreen> {
  String? measuredCycleTime = 'N/A';
  String? measuredTemperature = 'N/A';
  String? measuredVibration = 'N/A';

  Color textColor = Colors.green; // Default text color for cycle
  Color textColorTemp = Colors.green; // Default text color for temperature
  Color textColorVibration = Colors.green; // Default text color for vibration

  double previousMeasuredCycleTime = 0.58;
  double previousMeasuredTemperature = 42.0; // Set an initial value
  double previousMeasuredVibration = 10.0; // Set an initial value

  bool isLoading = true; // Initially, set loading to true
  bool showPopup = false; // Tracks whether to show the Alert() widget
  bool loadindSecondTime = false;

  @override
  void initState() {
    super.initState();
    if (!loadindSecondTime) {
      loadindSecondTime = true;
    } else {
      onDisconnected();
    }

    connectMqtt();
    subscribe();
    mqttStreamController.stream.listen((data) {
      // Your existing data processing logic here
      if (data.startsWith("cycle:")) {
        final newMeasuredCycleTime = double.tryParse(data.split(" ")[1]);
        if (newMeasuredCycleTime != null) {
          setState(() {
            if (previousMeasuredCycleTime != null) {
              // Check if it's 50% higher or lower
              final percentChange =
                  (newMeasuredCycleTime - previousMeasuredCycleTime!) /
                      previousMeasuredCycleTime! *
                      100;
              if (percentChange > 50.0 || percentChange < -50.0) {
                // Show notification
                NotificationService().showNotification(
                    title: "Measured Cycle Time Change Alert",
                    body: "Measured cycle time has changed by more than 50%.");
                // Set showPopup to true to display Alert()
                setState(() {
                  showPopup = true;
                });
              }
            }

            measuredCycleTime = data;
            if (previousMeasuredCycleTime != null &&
                newMeasuredCycleTime > previousMeasuredCycleTime!) {
              textColor = Colors.red;
            } else {
              textColor = Colors.green;
            }
            previousMeasuredCycleTime = newMeasuredCycleTime;
          });
        }
      } else if (data.startsWith("temperature:")) {
        final newMeasuredTemperature = double.tryParse(data.split(" ")[1]);
        if (newMeasuredTemperature != null) {
          setState(() {
            if (previousMeasuredTemperature != null) {
              // Check if it's 5% higher or lower
              double percentChangeTemp =
                  (newMeasuredTemperature - previousMeasuredTemperature!) /
                      previousMeasuredTemperature! *
                      100;
              if (percentChangeTemp >= 5.0 || percentChangeTemp <= -5.0) {
                // Show notification
                NotificationService().showNotification(
                    title: "Measured Temperature Change Alert",
                    body: "Measured temperature has changed by more than 5%.");
                // Set showPopup to true to display Alert()
                setState(() {
                  showPopup = true;
                });
              }
            }

            measuredTemperature = data;
            previousMeasuredTemperature = newMeasuredTemperature;
            if (previousMeasuredTemperature != null &&
                newMeasuredTemperature > previousMeasuredTemperature!) {
              textColorTemp = Colors.red;
            } else {
              textColorTemp = Colors.green;
            }
          });
        }
      } else if (data.startsWith("frequency:")) {
        final newMeasuredVibration = double.tryParse(data.split(" ")[1]);
        if (newMeasuredVibration != null) {
          setState(() {
            if (previousMeasuredVibration != null) {
              // Check if it's 200% higher or lower
              double percentChange =
                  (newMeasuredVibration - previousMeasuredVibration!) /
                      previousMeasuredVibration! *
                      100;
              if (percentChange >= 200.0 || percentChange <= -200.0) {
                // Show notification
                NotificationService().showNotification(
                    title: "Measured Vibration Change Alert",
                    body: "Measured vibration has changed by more than 200%.");
                // Set showPopup to true to display Alert()
                setState(() {
                  showPopup = true;
                });
              }
            }

            measuredVibration = data;
            previousMeasuredVibration = newMeasuredVibration;
            if (previousMeasuredVibration != null &&
                newMeasuredVibration > previousMeasuredVibration!) {
              textColorVibration = Colors.red;
            } else {
              textColorVibration = Colors.green;
            }
          });
        }
      }

      // Set isLoading to false when data is loaded
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Conditional rendering of EverythingOkay() or Alert()
        if (!showPopup)
          EverythingOkay()
        else
          Alert(), // Display Alert() when showPopup is true

        isLoading
            ? Center(
                child:
                    CircularProgressIndicator()) // Show a loading indicator while data is loading
            : Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Measured Cycle Time:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          StreamBuilder<String>(
                            stream: mqttStreamController.stream,
                            builder: (context, snapshot) {
                              return Text(
                                (measuredCycleTime
                                        ?.split(" ")[1]
                                        ?.substring(0, 10) ??
                                    'N/A'),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: textColor,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Measured Temperature:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          StreamBuilder<String>(
                            stream: mqttStreamController.stream,
                            builder: (context, snapshot) {
                              return Text(
                                (measuredTemperature
                                        ?.split(" ")[1]
                                        ?.substring(0, 10) ??
                                    'N/A'),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: textColorTemp, // Use textColorTemp
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Measured Vibration:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          StreamBuilder<String>(
                            stream: mqttStreamController.stream,
                            builder: (context, snapshot) {
                              return Text(
                                (measuredVibration
                                        ?.split(" ")[1]
                                        ?.substring(0, 10) ??
                                    'N/A'),
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      textColorVibration, // Use textColorVibration
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
