import 'package:equatable/equatable.dart';
import '../../models/timer_stage.dart';

class TimerState extends Equatable {
  const TimerState({
    this.minutes = 25,
    this.seconds = 0,
    this.isRunning = false,
    this.stage = TimerStage.pomodoro,
    this.prevStage = TimerStage.longBreak,
    this.pomoCounter = 1,
  });

  final int minutes;
  final int seconds;
  final bool isRunning;
  final TimerStage stage;
  final TimerStage prevStage;
  final int pomoCounter;

  TimerState copyWith({
    int? minutes,
    int? seconds,
    bool? isRunning,
    TimerStage? stage,
    TimerStage? prevStage,
    int? pomoCounter,
  }) {
    return TimerState(
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      isRunning: isRunning ?? this.isRunning,
      stage: stage ?? this.stage,
      prevStage: prevStage ?? this.prevStage,
      pomoCounter: pomoCounter ?? this.pomoCounter,
    );
  }

  @override
  List<Object> get props => [
    minutes, 
    seconds, 
    isRunning, 
    stage, 
    prevStage, 
    pomoCounter
  ];

  // Methods for HydratedBloc persistence
  factory TimerState.fromJson(Map<String, dynamic> json) {
    return TimerState(
      minutes: json['minutes'] as int? ?? 25,
      seconds: json['seconds'] as int? ?? 0,
      isRunning: false, // Always start in paused state when restored
      stage: TimerStage.values.firstWhere(
        (e) => e.toString() == json['stage'],
        orElse: () => TimerStage.pomodoro,
      ),
      prevStage: TimerStage.values.firstWhere(
        (e) => e.toString() == json['prevStage'],
        orElse: () => TimerStage.longBreak,
      ),
      pomoCounter: json['pomoCounter'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'minutes': minutes,
      'seconds': seconds,
      'stage': stage.toString(),
      'prevStage': prevStage.toString(),
      'pomoCounter': pomoCounter,
    };
  }
}