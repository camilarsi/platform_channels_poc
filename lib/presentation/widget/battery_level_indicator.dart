import 'package:flutter/material.dart';
import 'package:platform_channels_definitivo/presentation/bloc/battery_bloc.dart';
import 'package:provider/provider.dart';

import '../../core/dependencies_injector.dart';
import '../../core/util/data_state.dart';

class BatteryLevelIndicator extends StatefulWidget {
  const BatteryLevelIndicator({super.key});

  @override
  State<BatteryLevelIndicator> createState() => _BatteryLevelIndicatorState();
}

class _BatteryLevelIndicatorState extends State<BatteryLevelIndicator> {
  late final BatteryBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc =
        Provider.of<DependenciesInjector>(context, listen: false).batteryBloc;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.data!.state == StateType.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data!.state == StateType.error) {
          return Center(child: Text('Error: ${snapshot.data!.error}'));
        } else if (snapshot.data!.state == StateType.success) {
          final batteryLevel = snapshot.data!.data ?? 0;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Battery Level', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 12),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: batteryLevel / 100,
                      strokeWidth: 8,
                      backgroundColor: Colors.grey[300],
                      color: batteryLevel > 20 ? Colors.green : Colors.red,
                    ),
                  ),
                  Text(
                    '$batteryLevel%',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
