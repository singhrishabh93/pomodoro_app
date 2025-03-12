import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/settings/settings_bloc.dart';
import '../blocs/timer/timer_bloc.dart';
import '../blocs/timer/timer_event.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        return IconButton(
          onPressed: () {
            context.read<TimerBloc>().add(
              TimerSkipped(settingsState),
            );
          },
          icon: const Icon(Icons.skip_next),
          iconSize: 32,
          color: Theme.of(context).colorScheme.primary,
        );
      },
    );
  }
}