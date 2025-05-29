import '../../data/repositories/device_theme_mode_repository.dart';

class LoadDeviceThemeModeUsecase {
  final DeviceThemeModeRepository repository;

  LoadDeviceThemeModeUsecase(this.repository);

  Future<bool> isDarkMode() async {
    try {
      final result = await repository.getDeviceThemeMode();
      print('USE CASE RESULT: ${result} ');
      return result;
    } catch (e) {
      throw Exception('Requesting is Dark Mode failed: $e');
    }
  }
}
