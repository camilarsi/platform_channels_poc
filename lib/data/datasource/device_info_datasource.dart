import 'package:flutter/services.dart';

class DeviceInfoDataSource {
  static const _channel = MethodChannel('com.example.platform_channels_poc');

  Future<Map<String, dynamic>> getFullDeviceInfo() async {
    try {
      final result = await _channel.invokeMethod<Map>('getFullDeviceInfo');
      if (result == null) return {};
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      throw Exception('Failed to get full device info: ${e.message}');
    }
  }
}
