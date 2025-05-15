import 'package:platform_channels_definitivo/core/error/device_info_exception.dart';
import 'package:platform_channels_definitivo/domain/entity/device_info.dart';
import 'package:platform_channels_definitivo/data/repositories/device_info_repository.dart';

class GetDeviceInfoUseCase {
  final DeviceInfoRepository repository;

  GetDeviceInfoUseCase({required this.repository});

  Future<DeviceInfo> call() async {
    try {
      final deviceInfo = await repository.getFullDeviceInfo();
      return deviceInfo;
    } catch (e) {
      throw DeviceInfoFailure(message: 'Get Device Info Use Case error: $e');
    }
  }
}
