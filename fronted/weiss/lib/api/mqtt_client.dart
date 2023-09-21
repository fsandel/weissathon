import 'dart:io';
import 'dart:math';
import 'package:mqtt_client/mqtt_client.dart';
import 'dart:convert';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:async';

final broker = '10.1.70.4';
final port = 1883;
final topics = [
  'Wallduern/Hackathon/TC150T/DeviceProperties/Movement',
  'Wallduern/Hackathon/TC150T/DeviceProperties/Temperature_processed',
  'Wallduern/Hackathon/TC150T/DeviceProperties/Vibration_processed',
];

MqttServerClient? client;

// Create a stream controller
StreamController<String> mqttStreamController =
    StreamController<String>.broadcast();

void connectMqtt() {
  client = MqttServerClient(broker, '');

  client?.logging(on: true);
  client?.onConnected = onConnected;
  client?.onDisconnected = onDisconnected;
  client?.onSubscribed = onSubscribed;
  client?.onSubscribeFail = onSubscribeFail;
  client?.keepAlivePeriod = 60;

  final connMessage = MqttConnectMessage()
      .withClientIdentifier('subscribe-${Random().nextInt(100)}')
      .startClean();

  client?.connectionMessage = connMessage;

  try {
    client!.connect();
  } on Exception catch (e) {
    print('Exception: $e');
    client?.disconnect();
  }
}

void onConnected() {
  print('Connected to MQTT Broker!');
  for (String topic in topics) {
    client?.subscribe(topic, MqttQos.atMostOnce);
  }
}

void onDisconnected() {
  print('Disconnected from MQTT Broker!');
  client?.disconnect();
}

void onSubscribed(String topic) {
  print('Subscribed to topic: $topic');
}

void onUnsubscribed(String topic) {
  print('Unsubscribed from topic: $topic');
}

void onSubscribeFail(String topic) {
  print('Failed to subscribe to topic: $topic');
}

void onMessage(String topic, MqttMessage message) {
  if (message is MqttPublishMessage) {
    final payload = utf8.decode(message.payload.message);
    final decodedMessage = json.decode(payload);

    // Process the message based on the topic
    switch (topic) {
      case 'Wallduern/Hackathon/TC150T/DeviceProperties/Movement':
        final measuredCycleTime =
            decodedMessage['Measured Cycle Time'] as double;
        print('Received message on topic: $topic');
        print('Measured Cycle Time: $measuredCycleTime');
        mqttStreamController.sink.add("cycle: " + measuredCycleTime.toString());
        break;
      case 'Wallduern/Hackathon/TC150T/DeviceProperties/Temperature_processed':
        final measuredTemperature = decodedMessage['temperature'] as double;
        print('Received message on topic: $topic');
        print('Temperature: $measuredTemperature');
        mqttStreamController.sink
            .add("temperature: " + measuredTemperature.toString());
        break;
      case 'Wallduern/Hackathon/TC150T/DeviceProperties/Vibration_processed':
        final measuredVibration = decodedMessage['adxlX']['Key Values']
            ['peak_high_frequency'] as double;
        print('Received message on topic: $topic');
        print('Vibration Peak High Frequency: $measuredVibration');
        mqttStreamController.sink
            .add("frequency: " + measuredVibration.toString());
        break;
      default:
        print('Unexpected topic: $topic');
        break;
    }
  }
}

void subscribe() {
  client?.updates?.listen((List<MqttReceivedMessage<MqttMessage>>? c) {
    final recMess = c?[0].payload as MqttPublishMessage;
    onMessage(c![0].topic, recMess);
  });
}

void run() {
  connectMqtt();
  subscribe();
}

void main() {
  run();
}
