import 'package:flutter/material.dart';
import 'package:platform_channels_definitivo/core/dependencies_injector.dart';
import 'package:platform_channels_definitivo/core/util/const/loading_indicator.dart';
import 'package:platform_channels_definitivo/core/util/data_state.dart';
import 'package:platform_channels_definitivo/domain/entity/device_info.dart';
import 'package:provider/provider.dart';

class DeviceInfoCard extends StatelessWidget {
  const DeviceInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceInfoBloc = context.read<DependenciesInjector>().deviceInfoBloc;
    return StreamBuilder<DataState<DeviceInfo>>(
      stream: deviceInfoBloc.stream,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return UIConstants.loadingIndicator;
        }

        if (snapshot.hasData) {
          DataState<DeviceInfo> deviceInfoState = snapshot.data!;
          if (deviceInfoState.state == StateType.success) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Device Info'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Device Model Info: '),
                        Text(deviceInfoState.data!.deviceModelInfo.model),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Operating System Version: '),
                        Text(deviceInfoState.data!.osInfo.version),
                      ],
                    ),
                    /* Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Batery Level: '), Text('---level---')],
                    ),*/
                  ],
                ),
              ),
            );
          } else if (deviceInfoState.state == StateType.error) {
            return Text('${deviceInfoState.error}');
          }
        }
        return UIConstants.loadingIndicator;
      },
    );
  }
}
