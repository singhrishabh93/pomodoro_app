part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class PomoLengthChanged extends SettingsEvent {
  const PomoLengthChanged(this.length);
  
  final int length;
  
  @override
  List<Object> get props => [length];
}

class ShortBreakLengthChanged extends SettingsEvent {
  const ShortBreakLengthChanged(this.length);
  
  final int length;
  
  @override
  List<Object> get props => [length];
}

class LongBreakLengthChanged extends SettingsEvent {
  const LongBreakLengthChanged(this.length);
  
  final int length;
  
  @override
  List<Object> get props => [length];
}

class PomosUntilLongBreakChanged extends SettingsEvent {
  const PomosUntilLongBreakChanged(this.count);
  
  final int count;
  
  @override
  List<Object> get props => [count];
}

class AutoResumeToggled extends SettingsEvent {
  const AutoResumeToggled(this.enabled);
  
  final bool enabled;
  
  @override
  List<Object> get props => [enabled];
}

class SoundToggled extends SettingsEvent {
  const SoundToggled(this.enabled);
  
  final bool enabled;
  
  @override
  List<Object> get props => [enabled];
}

class NotificationsToggled extends SettingsEvent {
  const NotificationsToggled(this.enabled);
  
  final bool enabled;
  
  @override
  List<Object> get props => [enabled];
}