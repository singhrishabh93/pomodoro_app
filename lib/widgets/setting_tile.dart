// lib/widgets/setting_tile.dart
import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({
    Key? key,
    required this.title,
    this.isSwitchSetting = false,
    this.value = 0,
    this.onValueChanged,
    this.onSwitchChanged,
  }) : super(key: key);

  final String title;
  final bool isSwitchSetting;
  final dynamic value;
  final Function(int)? onValueChanged;
  final Function(bool)? onSwitchChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: isSwitchSetting
          ? Switch(
              value: value as bool,
              onChanged: onSwitchChanged,
              activeColor: Theme.of(context).colorScheme.primary,
            )
          : SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: value > 1
                        ? () => onValueChanged?.call((value as int) - 1)
                        : null,
                  ),
                  Text('$value'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: value < 60
                        ? () => onValueChanged?.call((value as int) + 1)
                        : null,
                  ),
                ],
              ),
            ),
    );
  }
}