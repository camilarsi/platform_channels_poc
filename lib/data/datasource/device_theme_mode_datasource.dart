import 'package:flutter/services.dart';

class DeviceThemeModeDataSource {
  final _channel = BasicMessageChannel<void>(
    'theme_mode',
    StandardMessageCodec(),
  );

  Future<bool> getDeviceThemeMode() async {
    try {
      final result = await _channel.send('getDarkModeStatus');
      return result as bool ?? false;
    } catch (e) {
      throw Exception('Retrieving device theme mode failed: $e');
    }
  }
}
