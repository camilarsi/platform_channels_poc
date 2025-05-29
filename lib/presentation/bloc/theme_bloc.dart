import 'dart:async';

import 'package:platform_channels_definitivo/core/util/data_state.dart';

import '../../domain/usecases/load_device_theme_mode_usecase.dart';

class ThemeBloc {
  late final LoadDeviceThemeModeUsecase loadDeviceThemeModeUsecase;
  late final _streamController = StreamController<DataState<bool>>.broadcast();
  late final _eventController = StreamController<ThemeEvent>();

  final Completer<void> _initialLoadCompleter = Completer<void>();
  bool _isInitialLoadDone = false;

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  Stream<DataState<bool>> get stream => _streamController.stream;

  Sink<ThemeEvent> get eventSink => _eventController.sink;

  Future<void> get whenInitialLoadDone => _initialLoadCompleter.future;

  ThemeBloc({required this.loadDeviceThemeModeUsecase}) {
    _eventController.stream.listen(_mapEventToState);
    //eventSink.add(LoadThemeEvent());
  }

  void _handleLoadThemeMode() async {
    print('[ThemeBloc] Loading theme mode...');

    try {
      final data = await loadDeviceThemeModeUsecase.isDarkMode();
      _streamController.add(DataState(state: StateType.success, data: data));
      _isDarkMode = data;
      if (!_initialLoadCompleter.isCompleted) {
        _initialLoadCompleter.complete();
        print('[ThemeBloc] Completer completed');
      }
    } catch (e) {
      _streamController.add(
        DataState(state: StateType.error, error: e.toString()),
      );
      if (!_initialLoadCompleter.isCompleted) {
        _initialLoadCompleter.completeError(e);
      }
    }
  }

  void _mapEventToState(ThemeEvent event) async {
    if (event is LoadThemeEvent) {
      _handleLoadThemeMode();
    } else if (event is ToggleTheme) {
      _isDarkMode = event.isDarkMode;
      _streamController.add(
        DataState(state: StateType.success, data: _isDarkMode),
      );
    }
  }

  void toggleThemeMode(bool value) {
    eventSink.add(ToggleTheme(value));
  }
}

abstract class ThemeEvent {}

class ToggleTheme extends ThemeEvent {
  final bool isDarkMode;

  ToggleTheme(this.isDarkMode);
}

class LoadThemeEvent extends ThemeEvent {}
