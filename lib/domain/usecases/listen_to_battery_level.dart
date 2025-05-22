import 'package:platform_channels_definitivo/data/repositories/battery_repository.dart';

class ListenToBatteryLevelUseCase {
  final BatteryRepository batteryRepository;

  ListenToBatteryLevelUseCase(this.batteryRepository);

  Stream<int> call() {
    return batteryRepository.batteryLevelStream();
  }
}
