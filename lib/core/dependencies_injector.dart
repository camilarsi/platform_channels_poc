import 'package:platform_channels_definitivo/data/datasource/device_info_datasource.dart';
import 'package:platform_channels_definitivo/data/datasource/photo_gallery_datasourse.dart';
import 'package:platform_channels_definitivo/data/repositories/device_info_repository.dart';
import 'package:platform_channels_definitivo/domain/repositories/i_image_repository.dart';
import 'package:platform_channels_definitivo/domain/usecases/get_device_info_usecase.dart';
import 'package:platform_channels_definitivo/domain/usecases/pick_image_usecase.dart';
import 'package:platform_channels_definitivo/presentation/bloc/device_info_bloc.dart';

import '../data/repositories/image_repository.dart';

class DependenciesInjector {
  late final DeviceInfoDataSource _deviceInfoDataSource;
  late final DeviceInfoRepository _deviceInfoRepository;
  late final GetDeviceInfoUseCase _getDeviceInfoUseCase;
  late final DeviceInfoBloc _deviceInfoBloc;
  late final PhotoGalleryDataSource _photoGalleryDataSource;
  late final IImageRepository _imageRepository;
  late final PickImageUseCase _pickImageUseCase;

  static final DependenciesInjector _instance = DependenciesInjector._();

  static DependenciesInjector get instance => _instance;

  DependenciesInjector._() {
    _initializeDependencies();
  }

  DeviceInfoBloc get deviceInfoBloc => _deviceInfoBloc;

  PickImageUseCase get pickImageUseCase => _pickImageUseCase;

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
  }
}
