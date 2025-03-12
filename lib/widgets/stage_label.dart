// lib/widgets/stage_label.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro_app/blocs/timer/timer_state.dart';

import '../blocs/timer/timer_bloc.dart';
import '../models/timer_stage.dart';

class StageLabel extends StatelessWidget {
  const StageLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        String label;
        IconData icon;

        switch (state.stage) {
          case TimerStage.pomodoro:
            label = 'Focus';
            icon = Icons.psychology;
            break;
          case TimerStage.shortBreak:
            label = 'Short Break';
            icon = Icons.coffee;
            break;
          case TimerStage.longBreak:
            label = 'Long Break';
            icon = Icons.beach_access;
            break;
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.5),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Container(
            key: ValueKey<String>(label),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(24),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
