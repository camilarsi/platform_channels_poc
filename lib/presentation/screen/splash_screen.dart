import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Starting with Platform Channels'),
            Text('Communication with Native Code'),
            SizedBox(height: 20, child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
