import 'package:platform_channels_definitivo/domain/entity/device_model_info.dart';
import 'package:platform_channels_definitivo/domain/entity/o_s_info.dart';

abstract class IDeviceInfoRepository {

  Future<OsInfo> getOsInfo();
  Future<DeviceModelInfo> getDeviceModelInfo();
}