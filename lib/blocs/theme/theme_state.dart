part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({
    this.themeMode = ThemeMode.system,
    this.accentColor = Colors.red,
  });

  final ThemeMode themeMode;
  final Color accentColor;

  ThemeState copyWith({
    ThemeMode? themeMode,
    Color? accentColor,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
    );
  }

  @override
  List<Object> get props => [themeMode, accentColor];

  // Methods for HydratedBloc persistence
  factory ThemeState.fromJson(Map<String, dynamic> json) {
    return ThemeState(
      themeMode: ThemeMode.values.firstWhere(
        (e) => e.toString() == json['themeMode'],
        orElse: () => ThemeMode.system,
      ),
      accentColor: Color(json['accentColor'] as int? ?? Colors.red.value),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.toString(),
      'accentColor': accentColor.value,
    };
  }
}