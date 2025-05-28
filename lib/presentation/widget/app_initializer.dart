import 'package:flutter/material.dart';
import 'package:platform_channels_definitivo/presentation/screen/splash_screen.dart';

import '../../main.dart';
import '../bloc/theme_bloc.dart';

class AppInitializer extends StatefulWidget {
  final ThemeBloc themeBloc;

  const AppInitializer({super.key, required this.themeBloc});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  void initState() {
    super.initState();
    widget.themeBloc.eventSink.add(LoadThemeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.themeBloc.whenInitialLoadDone,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        }
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(
                  'Theme Mode initialization failed: ${snapshot.hasError}',
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp(isDarkMode: widget.themeBloc.isDarkMode);
        }
        return Text('Error');
      },
    );
  }
}
