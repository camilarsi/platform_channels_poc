import 'package:flutter/services.dart';
import 'package:platform_channels_definitivo/core/error/device_info_exception.dart';
import 'package:platform_channels_definitivo/domain/entity/device_model_info.dart';
import 'package:platform_channels_definitivo/domain/entity/o_s_info.dart';
import 'package:platform_channels_definitivo/domain/repositories/i_device_info_repository.dart';

import '../datasource/device_info_datasource.dart';

class DeviceInfoRepository implements IDeviceInfoRepository {
  final DeviceInfoDataSource deviceInfoDatasource;

  DeviceInfoRepository({required this.deviceInfoDatasource});

  @override
  Future<OsInfo> getOsInfo() async {

    try {
      final data = await deviceInfoDatasource.getOsInfo();
      if (data =='') {
        throw OsInfoFailure(message: 'OS Info is empty');
      }
      return OsInfo(version: data);
    } catch (e) {
      throw OsInfoFailure(message: 'OS Info repository error: $e');
    }
  }

  @override
  Future<DeviceModelInfo> getDeviceModelInfo() async {

    try {
      final data = await deviceInfoDatasource.getDeviceModelInfo();
      if (data =='') {
        throw OsInfoFailure(message: 'Model Info is empty');
      }
      return DeviceModelInfo(model: data);
    } catch (e) {
      throw OsInfoFailure(message: 'Model Info repository error: $e');
    }
    /*final data = Map<String, dynamic>.from(await deviceInfoDatasource.getDeviceModelInfo());

    return DeviceModelInfo(
      manufacturer: data['manufacturer'],
      brand: data['brand'],
      model: data['model'],
      product: data['product'],
    );*/
  }
}
