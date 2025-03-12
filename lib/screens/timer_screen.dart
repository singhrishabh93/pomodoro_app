import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro_app/blocs/settings/settings_bloc.dart';
import 'package:pomodoro_app/blocs/theme/theme_bloc.dart';

import '../blocs/timer/timer_bloc.dart';
import '../blocs/timer/timer_state.dart';
import '../blocs/timer/timer_event.dart';
import '../widgets/display.dart';
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
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.close,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 20),
                                    content: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                0.7,
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.9,
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
                                                          .add(
                                                            ThemeModeToggled(
                                                                value
                                                                    ? ThemeMode
                                                                        .dark
                                                                    : ThemeMode
                                                                        .light),
                                                          ),
                                                      context,
                                                    ),
                                                    _buildNumberSetting(
                                                      'Pomodoro length',
                                                      settingsState.pomoLength,
                                                      (value) => context
                                                          .read<SettingsBloc>()
                                                          .add(
                                                            PomoLengthChanged(
                                                                value),
                                                          ),
                                                      context,
                                                    ),
                                                    _buildNumberSetting(
                                                      'Pomodoros until long break',
                                                      settingsState
                                                          .pomosUntilLongBreak,
                                                      (value) => context
                                                          .read<SettingsBloc>()
                                                          .add(
                                                            PomosUntilLongBreakChanged(
                                                                value),
                                                          ),
                                                      context,
                                                    ),
                                                    _buildNumberSetting(
                                                      'Short break length',
                                                      settingsState
                                                          .shortBreakLength,
                                                      (value) => context
                                                          .read<SettingsBloc>()
                                                          .add(
                                                            ShortBreakLengthChanged(
                                                                value),
                                                          ),
                                                      context,
                                                    ),
                                                    _buildNumberSetting(
                                                      'Long break length',
                                                      settingsState
                                                          .longBreakLength,
                                                      (value) => context
                                                          .read<SettingsBloc>()
                                                          .add(
                                                            LongBreakLengthChanged(
                                                                value),
                                                          ),
                                                      context,
                                                    ),
                                                    _buildSwitchSetting(
                                                      'Auto resume timer',
                                                      settingsState.autoResume,
                                                      (value) => context
                                                          .read<SettingsBloc>()
                                                          .add(
                                                            AutoResumeToggled(
                                                                value),
                                                          ),
                                                      context,
                                                    ),
                                                    _buildSwitchSetting(
                                                      'Sound',
                                                      settingsState
                                                          .soundEnabled,
                                                      (value) => context
                                                          .read<SettingsBloc>()
                                                          .add(
                                                            SoundToggled(value),
                                                          ),
                                                      context,
                                                    ),
                                                    _buildSwitchSetting(
                                                      'Notifications',
                                                      settingsState
                                                          .notificationsEnabled,
                                                      (value) => context
                                                          .read<SettingsBloc>()
                                                          .add(
                                                            NotificationsToggled(
                                                                value),
                                                          ),
                                                      context,
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
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

  Widget _buildSwitchSetting(String title, bool value, Function(bool) onChanged, BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Theme.of(context).colorScheme.primary,
          activeTrackColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        ),
      ],
    ),
  );
}

Widget _buildNumberSetting(String title, int value, Function(int) onChanged, BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 90,
          height: 36,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => onChanged(value > 1 ? value - 1 : 1),
                child: Container(
                  width: 28,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(7)),
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Text(
                '$value',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              InkWell(
                onTap: () => onChanged(value + 1),
                child: Container(
                  width: 28,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: const BorderRadius.horizontal(right: Radius.circular(7)),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}
