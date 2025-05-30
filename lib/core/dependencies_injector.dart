import 'package:platform_channels_definitivo/data/datasource/device_info_datasource.dart';
import 'package:platform_channels_definitivo/data/datasource/device_theme_mode_datasource.dart';
import 'package:platform_channels_definitivo/data/datasource/native_battery_datasource.dart';
import 'package:platform_channels_definitivo/data/datasource/photo_gallery_datasourse.dart';
import 'package:platform_channels_definitivo/data/repositories/battery_repository.dart';
import 'package:platform_channels_definitivo/data/repositories/device_info_repository.dart';
import 'package:platform_channels_definitivo/data/repositories/device_theme_mode_repository.dart';
import 'package:platform_channels_definitivo/domain/repositories/i_image_repository.dart';
import 'package:platform_channels_definitivo/domain/usecases/get_device_info_usecase.dart';
import 'package:platform_channels_definitivo/domain/usecases/listen_to_battery_level.dart';
import 'package:platform_channels_definitivo/domain/usecases/pick_image_usecase.dart';
import 'package:platform_channels_definitivo/presentation/bloc/battery_bloc.dart';
import 'package:platform_channels_definitivo/presentation/bloc/device_info_bloc.dart';
import 'package:platform_channels_definitivo/presentation/bloc/theme_bloc.dart';

import '../data/repositories/image_repository.dart';
import '../domain/usecases/load_device_theme_mode_usecase.dart';

class DependenciesInjector {
  late final DeviceInfoDataSource _deviceInfoDataSource;
  late final DeviceInfoRepository _deviceInfoRepository;
  late final GetDeviceInfoUseCase _getDeviceInfoUseCase;
  late final DeviceInfoBloc _deviceInfoBloc;
  late final PhotoGalleryDataSource _photoGalleryDataSource;
  late final IImageRepository _imageRepository;
  late final PickImageUseCase _pickImageUseCase;
  late final NativeBatteryDataSource _nativeBatteryDataSource;
  late final BatteryRepository _batteryRepository;
  late final ListenToBatteryLevelUseCase _listenToBatteryLevelUseCase;
  late final BatteryBloc _batteryBloc;

  static final DependenciesInjector _instance = DependenciesInjector._();

  static DependenciesInjector get instance => _instance;

  DependenciesInjector._() {
    _initializeDependencies();
  }

  DeviceInfoBloc get deviceInfoBloc => _deviceInfoBloc;

  PickImageUseCase get pickImageUseCase => _pickImageUseCase;

  BatteryBloc get batteryBloc => _batteryBloc;

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
    _photoGalleryDataSource = PhotoGalleryDataSource();
    _imageRepository = ImageRepository(_photoGalleryDataSource);
    _pickImageUseCase = PickImageUseCase(_imageRepository);
    _nativeBatteryDataSource = NativeBatteryDataSource();
    _batteryRepository = BatteryRepository(_nativeBatteryDataSource);
    _listenToBatteryLevelUseCase = ListenToBatteryLevelUseCase(
      _batteryRepository,
    );
    _batteryBloc = BatteryBloc(
      listenToBatteryLevelUseCase: _listenToBatteryLevelUseCase,
    );
  }
}

class ThemeModeDependenciesInjector {
  late final LoadDeviceThemeModeUsecase _loadingDeviceThemeModeUsecase;
  late final DeviceThemeModeRepository _deviceThemeModeRepository;
  late final DeviceThemeModeDataSource _deviceThemeModeDataSource;
  late final ThemeBloc _themeBloc;

  static final ThemeModeDependenciesInjector _instance =
      ThemeModeDependenciesInjector._();

  ThemeBloc get themeBloc => _themeBloc;

  static ThemeModeDependenciesInjector get instance => _instance;

  ThemeModeDependenciesInjector._() {
    _initializeDependencies();
  }

  void _initializeDependencies() {
    _deviceThemeModeDataSource = DeviceThemeModeDataSource();
    _deviceThemeModeRepository = DeviceThemeModeRepository(
      _deviceThemeModeDataSource,
    );
    _loadingDeviceThemeModeUsecase = LoadDeviceThemeModeUsecase(
      _deviceThemeModeRepository,
    );
    _themeBloc = ThemeBloc(
      loadDeviceThemeModeUsecase: _loadingDeviceThemeModeUsecase,
    );
  }
}
