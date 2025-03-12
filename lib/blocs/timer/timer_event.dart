import 'package:equatable/equatable.dart';
import '../settings/settings_bloc.dart';
import '../../models/timer_stage.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object?> get props => [];
}

class TimerInitialized extends TimerEvent {
  const TimerInitialized({this.settings});
  
  final SettingsState? settings;
  
  @override
  List<Object?> get props => [settings];
}

class TimerToggled extends TimerEvent {
  const TimerToggled();
}

class TimerTicked extends TimerEvent {
  const TimerTicked({required this.settings});
  
  final SettingsState settings;
  
  @override
  List<Object> get props => [settings];
}

class TimerReset extends TimerEvent {
  const TimerReset({required this.settings});
  
  final SettingsState settings;
  
  @override
  List<Object> get props => [settings];
}

class TimerStageChanged extends TimerEvent {
  const TimerStageChanged({
    required this.stage,
    required this.settings,
  });
  
  final TimerStage stage;
  final SettingsState settings;
  
  @override
  List<Object> get props => [stage, settings];
}

class TimerSkipped extends TimerEvent {
  const TimerSkipped(this.settings);
  
  final SettingsState settings;
  
  @override
  List<Object> get props => [settings];
}