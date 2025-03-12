import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/blocs/settings/settings_bloc.dart';
import 'package:pomodoro_app/screens/settings_screen.dart';

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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SettingsScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.more_horiz),
                              iconSize: 34,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                          ),
                          const SizedBox(width: 16),
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
                          const SizedBox(width: 16),
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
}
