import '../entity/device_info.dart';

abstract class IDeviceInfoRepository {
  Future<DeviceInfo> getFullDeviceInfo();
}
