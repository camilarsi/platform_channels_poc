import 'package:platform_channels_definitivo/data/datasource/device_info_datasource.dart';
import 'package:platform_channels_definitivo/data/repositories/device_info_repository.dart';
import 'package:platform_channels_definitivo/domain/usecases/get_device_info_usecase.dart';
import 'package:platform_channels_definitivo/presentation/bloc/device_info_bloc.dart';

class DependenciesInjector {
  late final DeviceInfoDataSource _deviceInfoDataSource;
  late final DeviceInfoRepository _deviceInfoRepository;
  late final GetDeviceInfoUseCase _getDeviceInfoUseCase;
  late final DeviceInfoBloc _deviceInfoBloc;

  static final DependenciesInjector _instance = DependenciesInjector._();

  static DependenciesInjector get instance => _instance;

  DependenciesInjector._() {
    _initializeDependencies();
  }

  DeviceInfoBloc get deviceInfoBloc => _deviceInfoBloc;

  void _initializeDependencies() {
    _deviceInfoDataSource = DeviceInfoDataSource();
    _deviceInfoRepository = DeviceInfoRepository(
      deviceInfoDatasource: _deviceInfoDataSource,
    );
    _getDeviceInfoUseCase = GetDeviceInfoUseCase(
      repository: _deviceInfoRepository,
    );
    _deviceInfoBloc = DeviceInfoBloc(
      getDeviceInfoUseCase: _getDeviceInfoUseCase,
    );
  }
}
