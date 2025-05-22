import 'package:flutter/material.dart';
import 'package:platform_channels_definitivo/core/util/data_state.dart';
import 'package:platform_channels_definitivo/domain/entity/device_info.dart';
import 'package:platform_channels_definitivo/data/datasource/device_info_datasource.dart';
import 'package:platform_channels_definitivo/data/repositories/device_info_repository.dart';
import 'package:platform_channels_definitivo/domain/usecases/get_device_info_usecase.dart';
import '../bloc/device_info_bloc.dart';
import 'battery_level_indicator.dart';

class DeviceInfoPage extends StatefulWidget {
  const DeviceInfoPage({super.key});

  @override
  State<DeviceInfoPage> createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  late final DeviceInfoBloc _bloc;

  @override
  void initState() {
    super.initState();

    final dataSource = DeviceInfoDataSource();
    final repository = DeviceInfoRepository(deviceInfoDatasource: dataSource);
    final useCase = GetDeviceInfoUseCase(repository: repository);

    _bloc = DeviceInfoBloc(getDeviceInfoUseCase: useCase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DataState<DeviceInfo>>(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.state == StateType.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.state == StateType.error) {
            return Center(child: Text('Error: ${snapshot.data!.error}'));
          } else if (snapshot.data!.state == StateType.success) {
            final info = snapshot.data!.data!;
            return ListView(
              padding: const EdgeInsets.all(16),
              children:
                  [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 28.0),
                          child: BatteryLevelIndicator(),
                        ),
                        Text('OS Version: ${info.osVersion}'),
                        Text('Model: ${info.deviceModel}'),
                        Text('Manufacturer: ${info.manufacturer}'),
                        Text('Brand: ${info.brand}'),
                        Text('Android ID: ${info.androidId}'),
                        Text('Power Saving Mode: ${info.powerSavingMode}'),
                        Text('Language: ${info.language}'),
                        Text('Time Zone: ${info.timeZone}'),
                      ]
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: e,
                        ),
                      )
                      .toList(),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
