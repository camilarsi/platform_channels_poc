import 'package:flutter/services.dart';

class NativeBatteryDataSource {
  static const _channel = EventChannel('com.example.batteryStream');

  Stream<int> getBatteryLevelStream() {
    return _channel.receiveBroadcastStream().map((event) => event as int);
  }
}
