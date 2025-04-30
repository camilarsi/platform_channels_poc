abstract class AppException implements Exception {
  final String message;

  AppException({required this.message});

  @override
  String toString() {
    return 'AppException: $message';
  }
}

class DeviceInfoFailure extends AppException {
  DeviceInfoFailure({required super.message});
}

class OsInfoFailure extends AppException {
  OsInfoFailure({required super.message});
}

class DeviceModelInfoFailure extends AppException {
  DeviceModelInfoFailure({required super.message});
}
