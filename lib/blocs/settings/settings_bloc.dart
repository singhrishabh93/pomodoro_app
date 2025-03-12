import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState.initial()) {
    on<PomoLengthChanged>(_onPomoLengthChanged);
    on<ShortBreakLengthChanged>(_onShortBreakLengthChanged);
    on<LongBreakLengthChanged>(_onLongBreakLengthChanged);
    on<PomosUntilLongBreakChanged>(_onPomosUntilLongBreakChanged);
    on<AutoResumeToggled>(_onAutoResumeToggled);
    on<SoundToggled>(_onSoundToggled);
    on<NotificationsToggled>(_onNotificationsToggled);
  }

  void _onPomoLengthChanged(PomoLengthChanged event, Emitter<SettingsState> emit) {
    emit(state.copyWith(pomoLength: event.length));
  }

  void _onShortBreakLengthChanged(ShortBreakLengthChanged event, Emitter<SettingsState> emit) {
    emit(state.copyWith(shortBreakLength: event.length));
  }

  void _onLongBreakLengthChanged(LongBreakLengthChanged event, Emitter<SettingsState> emit) {
    emit(state.copyWith(longBreakLength: event.length));
  }

  void _onPomosUntilLongBreakChanged(PomosUntilLongBreakChanged event, Emitter<SettingsState> emit) {
    emit(state.copyWith(pomosUntilLongBreak: event.count));
  }

  void _onAutoResumeToggled(AutoResumeToggled event, Emitter<SettingsState> emit) {
    emit(state.copyWith(autoResume: event.enabled));
  }

  void _onSoundToggled(SoundToggled event, Emitter<SettingsState> emit) {
    emit(state.copyWith(soundEnabled: event.enabled));
  }

  void _onNotificationsToggled(NotificationsToggled event, Emitter<SettingsState> emit) {
    emit(state.copyWith(notificationsEnabled: event.enabled));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return state.toJson();
  }
}