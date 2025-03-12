import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/settings/settings_bloc.dart';
import '../blocs/theme/theme_bloc.dart';
import '../widgets/setting_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return ListView(
                children: [
                  SettingTile(
                    title: 'Dark Mode',
                    isSwitchSetting: true,
                    value: themeState.themeMode == ThemeMode.dark,
                    onSwitchChanged: (value) {
                      context.read<ThemeBloc>().add(
                        ThemeModeToggled(value ? ThemeMode.dark : ThemeMode.light)
                      );
                    },
                  ),
                  SettingTile(
                    title: 'Pomodoro Length',
                    value: settingsState.pomoLength,
                    onValueChanged: (value) {
                      context.read<SettingsBloc>().add(
                        PomoLengthChanged(value),
                      );
                    },
                  ),
                  SettingTile(
                    title: 'Short Break Length',
                    value: settingsState.shortBreakLength,
                    onValueChanged: (value) {
                      context.read<SettingsBloc>().add(
                        ShortBreakLengthChanged(value),
                      );
                    },
                  ),
                  SettingTile(
                    title: 'Long Break Length',
                    value: settingsState.longBreakLength,
                    onValueChanged: (value) {
                      context.read<SettingsBloc>().add(
                        LongBreakLengthChanged(value),
                      );
                    },
                  ),
                  SettingTile(
                    title: 'Pomodoros Until Long Break',
                    value: settingsState.pomosUntilLongBreak,
                    onValueChanged: (value) {
                      context.read<SettingsBloc>().add(
                        PomosUntilLongBreakChanged(value),
                      );
                    },
                  ),
                  SettingTile(
                    title: 'Auto Resume Timer',
                    isSwitchSetting: true,
                    value: settingsState.autoResume,
                    onSwitchChanged: (value) {
                      context.read<SettingsBloc>().add(
                        AutoResumeToggled(value),
                      );
                    },
                  ),
                  SettingTile(
                    title: 'Sound',
                    isSwitchSetting: true,
                    value: settingsState.soundEnabled,
                    onSwitchChanged: (value) {
                      context.read<SettingsBloc>().add(
                        SoundToggled(value),
                      );
                    },
                  ),
                  SettingTile(
                    title: 'Notifications',
                    isSwitchSetting: true,
                    value: settingsState.notificationsEnabled,
                    onSwitchChanged: (value) {
                      context.read<SettingsBloc>().add(
                        NotificationsToggled(value),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}