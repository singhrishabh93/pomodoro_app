import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro_app/blocs/settings/settings_bloc.dart';
import 'package:pomodoro_app/blocs/theme/theme_bloc.dart';
import 'package:pomodoro_app/screens/settings_screen.dart';
import 'package:pomodoro_app/widgets/setting_tile.dart';

import '../blocs/timer/timer_bloc.dart';
import '../blocs/timer/timer_state.dart';
import '../blocs/timer/timer_event.dart';
import '../widgets/display.dart';
import '../widgets/play_button.dart';
import '../widgets/skip_button.dart';
import '../widgets/settings_button.dart';
import '../widgets/stage_label.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize timer with the correct stage duration
    context.read<TimerBloc>().add(const TimerInitialized());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          return GestureDetector(
            // Full screen tappable area to toggle timer
            onTap: () => context.read<TimerBloc>().add(const TimerToggled()),
            behavior: HitTestBehavior.opaque,
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),
                      const StageLabel(),
                      const SizedBox(height: 48),
                      Display(
                        minutes: state.minutes,
                        seconds: state.seconds,
                        isRunning: state.isRunning,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Settings',
                                          style: GoogleFonts.outfit(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ],
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    content: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                0.7,
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                      ),
                                      child: SingleChildScrollView(
                                        child: BlocBuilder<SettingsBloc,
                                            SettingsState>(
                                          builder: (context, settingsState) {
                                            return BlocBuilder<ThemeBloc,
                                                ThemeState>(
                                              builder: (context, themeState) {
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    _buildSwitchSetting(
                                                      'Enable dark mode',
                                                      themeState.themeMode ==
                                                          ThemeMode.dark,
                                                      (value) => context
                                                          .read<ThemeBloc>()
                                                          .add(ThemeModeToggled(
                                                              value
                                                                  ? ThemeMode
                                                                      .dark
                                                                  : ThemeMode
                                                                      .light)),
                                                    ),
                                                    _buildNumberSetting(
                                                      'Pomodoro length',
                                                      settingsState.pomoLength,
                                                      (value) => context
                                                          .read<SettingsBloc>()
                                                          .add(
                                                              PomoLengthChanged(
                                                                  value)),
                                                    ),
                                                    _buildNumberSetting(
                                                      'Pomodoros until long break',
                                                      settingsState
                                                          .pomosUntilLongBreak,
                                                      (value) => context
                                                          .read<SettingsBloc>()
                                                          .add(
                                                              PomosUntilLongBreakChanged(
                                                                  value)),
                                                    ),
                                                    _buildNumberSetting(
                                                      'Short break length',
                                                      settingsState
                                                          .shortBreakLength,
                                                      (value) => context
                                                          .read<SettingsBloc>()
                                                          .add(
                                                              ShortBreakLengthChanged(
                                                                  value)),
                                                    ),
                                                    _buildNumberSetting(
                                                      'Long break length',
                                                      settingsState
                                                          .longBreakLength,
                                                      (value) => context
                                                          .read<SettingsBloc>()
                                                          .add(
                                                              LongBreakLengthChanged(
                                                                  value)),
                                                    ),
                                                    _buildSwitchSetting(
                                                      'Auto resume timer',
                                                      settingsState.autoResume,
                                                      (value) => context
                                                          .read<SettingsBloc>()
                                                          .add(
                                                              AutoResumeToggled(
                                                                  value)),
                                                    ),
                                                    _buildSwitchSetting(
                                                      'Sound',
                                                      settingsState
                                                          .soundEnabled,
                                                      (value) => context
                                                          .read<SettingsBloc>()
                                                          .add(SoundToggled(
                                                              value)),
                                                    ),
                                                    _buildSwitchSetting(
                                                      'Notifications',
                                                      settingsState
                                                          .notificationsEnabled,
                                                      (value) => context
                                                          .read<SettingsBloc>()
                                                          .add(
                                                              NotificationsToggled(
                                                                  value)),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    actions: null,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.more_horiz),
                              iconSize: 34,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: IconButton(
                              onPressed: () => context
                                  .read<TimerBloc>()
                                  .add(const TimerToggled()),
                              icon: Icon(state.isRunning
                                  ? Icons.pause
                                  : Icons.play_arrow),
                              iconSize: 44,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 16),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              onPressed: () {
                                context.read<TimerBloc>().add(
                                      TimerSkipped(
                                          context.read<SettingsBloc>().state),
                                    );
                              },
                              icon: const Icon(Icons.fast_forward),
                              iconSize: 34,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSwitchSetting(
      String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildNumberSetting(String title, int value, Function(int) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(width: 8),
          Container(
            width: 80,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 4),
                Text(
                  '$value',
                  style: const TextStyle(fontSize: 16),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => onChanged(value + 1),
                      child: const Icon(Icons.keyboard_arrow_up, size: 18),
                    ),
                    InkWell(
                      onTap: () => onChanged(value > 1 ? value - 1 : 1),
                      child: const Icon(Icons.keyboard_arrow_down, size: 18),
                    ),
                  ],
                ),
                SizedBox(width: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
