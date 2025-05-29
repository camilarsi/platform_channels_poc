import 'dart:async';
import 'package:platform_channels_definitivo/domain/usecases/listen_to_battery_level.dart';
import '../../core/util/data_state.dart';

class BatteryBloc {
  final ListenToBatteryLevelUseCase listenToBatteryLevelUseCase;

  late final StreamController<DataState<int>> _streamController;

  BatteryBloc({required this.listenToBatteryLevelUseCase}) {
    _streamController = StreamController.broadcast();
    listenBatteryLevel();
  }

  Stream<DataState<int>> get stream => _streamController.stream;

  Future<void> listenBatteryLevel() async {
    _streamController.add(DataState(state: StateType.loading));

    listenToBatteryLevelUseCase.call().listen(
      (batteryLevelData) {
        _streamController.add(
          DataState(state: StateType.success, data: batteryLevelData),
        );
      },
      onError: (error) {
        _streamController.add(
          DataState(state: StateType.error, error: error.toString()),
        );
      },
    );
  }
}
