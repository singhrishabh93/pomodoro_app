import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/settings/settings_bloc.dart';
import 'blocs/timer/timer_bloc.dart';
import 'blocs/theme/theme_bloc.dart';
import 'services/notification_service.dart';
import 'services/sound_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize HydratedBloc for persisting state
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  
  // Use the storage to initialize HydratedBloc
  HydratedBloc.storage = storage;
  
  // Initialize services
  final notificationService = NotificationService();
  await notificationService.init();
  
  final soundService = SoundService();
  await soundService.init();
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(),
        ),
        BlocProvider<TimerBloc>(
          create: (context) => TimerBloc(
            notificationService: notificationService,
            soundService: soundService,
          ),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: const PomoApp(),
    ),
  );
}