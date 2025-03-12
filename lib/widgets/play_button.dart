import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/timer/timer_bloc.dart';
import '../blocs/timer/timer_state.dart';
import '../blocs/timer/timer_event.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            context.read<TimerBloc>().add(const TimerToggled());
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            shape: const CircleBorder(),
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
          ),
          child: Icon(
            state.isRunning ? Icons.pause : Icons.play_arrow,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 36,
          ),
        );
      },
    );
  }
}