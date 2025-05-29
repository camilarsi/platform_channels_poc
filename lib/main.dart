import 'package:flutter/material.dart';
import 'package:platform_channels_definitivo/presentation/bloc/theme_bloc.dart';
import 'package:platform_channels_definitivo/presentation/widget/app_initializer.dart';
import 'package:platform_channels_definitivo/presentation/widget/device_info_card.dart';
import 'package:platform_channels_definitivo/presentation/widget/home_drawer.dart';
import 'package:provider/provider.dart';

import 'core/dependencies_injector.dart';
import 'core/util/data_state.dart';

Future<void> initializeDependencies(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 3));
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final themeModeDependenciesInjector = ThemeModeDependenciesInjector.instance;
  runApp(AppInitializer(themeBloc: themeModeDependenciesInjector.themeBloc));
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;

  const MyApp({required this.isDarkMode, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Platform Channels PoC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Provider<DependenciesInjector>(
        create: (_) => DependenciesInjector.instance,
        child: MyHomePage(title: 'Device Info', isDarkMode: isDarkMode),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.isDarkMode, super.key, required this.title});

  final String title;
  final bool isDarkMode;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      drawer: HomeDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DeviceInfoPage(isDarkMode: widget.isDarkMode),
      ),
    );
  }
}
