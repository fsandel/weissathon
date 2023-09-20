import 'dart:io';
import 'dart:math';
import 'package:mqtt_client/mqtt_client.dart';
import 'dart:convert';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:async';

final broker = '10.1.70.4';
final port = 1883;
final topic = 'Wallduern/Hackathon/TC150T/DeviceProperties/Movement';

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
  client?.subscribe(topic, MqttQos.atMostOnce);
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
    final measuredCycleTime = decodedMessage['Measured Cycle Time'] as double;
    print('Received message on topic: $topic');
    print('Measured Cycle Time: $measuredCycleTime');

    // Push the measuredCycleTime to the stream
    mqttStreamController.sink.add(measuredCycleTime.toString());
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
