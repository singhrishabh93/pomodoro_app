// lib/widgets/settings_button.dart
import 'package:flutter/material.dart';

import '../screens/settings_screen.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SettingsScreen(),
          ),
        );
      },
      icon: const Icon(Icons.settings),
      iconSize: 32,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
