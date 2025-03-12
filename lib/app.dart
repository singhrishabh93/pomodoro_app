import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_app/blocs/timer/timer_state.dart';

import 'blocs/theme/theme_bloc.dart';
import 'blocs/timer/timer_bloc.dart';
import 'screens/timer_screen.dart';
import 'theme/app_theme.dart';

class PomoApp extends StatefulWidget {
  const PomoApp({Key? key}) : super(key: key);

  @override
  State<PomoApp> createState() => _PomoAppState();
}

class _PomoAppState extends State<PomoApp> {
  @override
  void initState() {
    super.initState();
    // Keep screen on during app usage - we removed wakelock package
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocListener<TimerBloc, TimerState>(
          listener: (context, timerState) {
            if (timerState.stage != timerState.prevStage) {
              context.read<ThemeBloc>().add(ThemeStageChanged(timerState.stage));
            }
          },
          child: MaterialApp(
            title: 'Pomo',
            debugShowCheckedModeBanner: false,
            theme: getLightTheme(themeState.accentColor),
            darkTheme: getDarkTheme(themeState.accentColor),
            themeMode: themeState.themeMode,
            home: const TimerScreen(),
          ),
        );
      },
    );
  }
}