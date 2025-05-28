import 'package:flutter/material.dart';

class DarkModeSwitcher extends StatelessWidget {
  const DarkModeSwitcher({required this.isDarkMode, super.key});

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Dark Mode', style: TextStyle(fontSize: 20)),
        SizedBox(
          height: 120,
          child: Transform.scale(
            scale: 1.5,
            child: Switch(value: isDarkMode, onChanged: null),
          ),
        ),
      ],
    );
  }
}
