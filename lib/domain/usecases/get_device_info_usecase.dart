import 'package:platform_channels_definitivo/core/error/device_info_exception.dart';
import '../../data/repositories/device_info_repository.dart';
import '../entity/device_info.dart';
import 'package:platform_channels_definitivo/domain/entity/device_model_info.dart';
import 'package:platform_channels_definitivo/domain/entity/o_s_info.dart';

class GetDeviceInfoUseCase {
  final DeviceInfoRepository repository;

  GetDeviceInfoUseCase({required this.repository});

  Future<DeviceInfo> call() async {
     try {
      final osInfoData = await repository.getOsInfo();
      final deviceModelInfoData = await repository.getDeviceModelInfo();

      return DeviceInfo(
        osInfo: osInfoData,
        deviceModelInfo: deviceModelInfoData,
      );

    } catch (e) {
      throw DeviceInfoFailure(message: 'Get Device Info Use Case error:  $e');
    }
  }
}
