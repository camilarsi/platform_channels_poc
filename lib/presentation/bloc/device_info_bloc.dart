import 'dart:async';

import 'package:platform_channels_definitivo/core/util/data_state.dart';
import 'package:platform_channels_definitivo/core/error/device_info_exception.dart';
import 'package:platform_channels_definitivo/domain/entity/device_info.dart';
import 'package:platform_channels_definitivo/domain/usecases/get_device_info_usecase.dart';

class DeviceInfoBloc {
  late final StreamController<DataState<DeviceInfo>> _streamController;
  final GetDeviceInfoUseCase getDeviceInfoUseCase;

  DeviceInfoBloc({required this.getDeviceInfoUseCase}) {
    _streamController = StreamController.broadcast();
    getDeviceInfo();
  }

  Stream<DataState<DeviceInfo>> get stream => _streamController.stream;

  Future<void> getDeviceInfo() async {
    _streamController.add(DataState(state: StateType.loading));
    try {
      final osInfoData = await getDeviceInfoUseCase.call();
      _streamController.add(
        DataState(state: StateType.success, data: osInfoData),
      );
    } on OsInfoFailure catch (e) {
      _streamController.add(
        DataState(state: StateType.error, error: e.message),
      );
    } catch (e) {
      _streamController.add(
        DataState(state: StateType.error, error: 'Unexpected error: $e'),
      );
    }
  }
}
