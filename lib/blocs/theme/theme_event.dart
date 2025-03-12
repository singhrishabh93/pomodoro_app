part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeModeToggled extends ThemeEvent {
  const ThemeModeToggled(this.themeMode);
  
  final ThemeMode themeMode;
  
  @override
  List<Object> get props => [themeMode];
}

class ThemeStageChanged extends ThemeEvent {
  const ThemeStageChanged(this.stage);
  
  final TimerStage stage;
  
  @override
  List<Object> get props => [stage];
}