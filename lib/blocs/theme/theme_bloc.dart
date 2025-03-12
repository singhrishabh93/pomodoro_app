import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/timer_stage.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ThemeModeToggled>(_onThemeModeToggled);
    on<ThemeStageChanged>(_onThemeStageChanged);
  }

  void _onThemeModeToggled(ThemeModeToggled event, Emitter<ThemeState> emit) {
    emit(state.copyWith(themeMode: event.themeMode));
  }

  void _onThemeStageChanged(ThemeStageChanged event, Emitter<ThemeState> emit) {
    Color accentColor;
    
    switch (event.stage) {
      case TimerStage.pomodoro:
        accentColor = Colors.red;
        break;
      case TimerStage.shortBreak:
        accentColor = Colors.green;
        break;
      case TimerStage.longBreak:
        accentColor = Colors.blue;
        break;
    }
    
    emit(state.copyWith(accentColor: accentColor));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toJson();
  }
}