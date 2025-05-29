import '../datasource/device_theme_mode_datasource.dart';

class DeviceThemeModeRepository {
  final DeviceThemeModeDataSource deviceThemeModeDataSource;

  DeviceThemeModeRepository(this.deviceThemeModeDataSource);

  Future<bool> getDeviceThemeMode() async {
    try {
      final result = await deviceThemeModeDataSource.getDeviceThemeMode();
      return result;
    } catch (e) {
      throw Exception('Getting device theme mode failed: $e');
    }
  }
}
