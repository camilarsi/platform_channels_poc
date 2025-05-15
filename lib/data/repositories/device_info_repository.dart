import 'package:platform_channels_definitivo/core/error/device_info_exception.dart';
import 'package:platform_channels_definitivo/domain/repositories/i_device_info_repository.dart';

import '../../domain/entity/device_info.dart';
import '../datasource/device_info_datasource.dart';

class DeviceInfoRepository implements IDeviceInfoRepository {
  final DeviceInfoDataSource deviceInfoDatasource;

  DeviceInfoRepository({required this.deviceInfoDatasource});

  @override
  Future<DeviceInfo> getFullDeviceInfo() async {
    try {
      final data = await deviceInfoDatasource.getFullDeviceInfo();
      return DeviceInfo.fromMap(data);
    } catch (e) {
      throw OsInfoFailure(message: 'Full Device Info repository error: $e');
    }
  }
}
