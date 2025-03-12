part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.pomoLength,
    required this.shortBreakLength,
    required this.longBreakLength,
    required this.pomosUntilLongBreak,
    required this.autoResume,
    required this.soundEnabled,
    required this.notificationsEnabled,
  });

  final int pomoLength;
  final int shortBreakLength;
  final int longBreakLength;
  final int pomosUntilLongBreak;
  final bool autoResume;
  final bool soundEnabled;
  final bool notificationsEnabled;

  factory SettingsState.initial() {
    return const SettingsState(
      pomoLength: 25,
      shortBreakLength: 5,
      longBreakLength: 15,
      pomosUntilLongBreak: 4,
      autoResume: false,
      soundEnabled: true,
      notificationsEnabled: true,
    );
  }

  SettingsState copyWith({
    int? pomoLength,
    int? shortBreakLength,
    int? longBreakLength,
    int? pomosUntilLongBreak,
    bool? autoResume,
    bool? soundEnabled,
    bool? notificationsEnabled,
  }) {
    return SettingsState(
      pomoLength: pomoLength ?? this.pomoLength,
      shortBreakLength: shortBreakLength ?? this.shortBreakLength,
      longBreakLength: longBreakLength ?? this.longBreakLength,
      pomosUntilLongBreak: pomosUntilLongBreak ?? this.pomosUntilLongBreak,
      autoResume: autoResume ?? this.autoResume,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  @override
  List<Object> get props => [
    pomoLength,
    shortBreakLength,
    longBreakLength,
    pomosUntilLongBreak,
    autoResume,
    soundEnabled,
    notificationsEnabled,
  ];

  // Methods for HydratedBloc persistence
  factory SettingsState.fromJson(Map<String, dynamic> json) {
    return SettingsState(
      pomoLength: json['pomoLength'] as int? ?? 25,
      shortBreakLength: json['shortBreakLength'] as int? ?? 5,
      longBreakLength: json['longBreakLength'] as int? ?? 15,
      pomosUntilLongBreak: json['pomosUntilLongBreak'] as int? ?? 4,
      autoResume: json['autoResume'] as bool? ?? false,
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pomoLength': pomoLength,
      'shortBreakLength': shortBreakLength,
      'longBreakLength': longBreakLength,
      'pomosUntilLongBreak': pomosUntilLongBreak,
      'autoResume': autoResume,
      'soundEnabled': soundEnabled,
      'notificationsEnabled': notificationsEnabled,
    };
  }
}