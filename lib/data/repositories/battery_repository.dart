import 'package:platform_channels_definitivo/data/datasource/native_battery_datasource.dart';
import 'package:platform_channels_definitivo/domain/repositories/i_battery_repository.dart';

class BatteryRepository implements IBatteryRepository {
  final NativeBatteryDataSource dataSource;

  BatteryRepository(this.dataSource);

  @override
  Stream<int> batteryLevelStream() {
    return dataSource.getBatteryLevelStream();
  }
}
