import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/timer_stage.dart';
import '../../services/notification_service.dart';
import '../../services/sound_service.dart';
import '../settings/settings_bloc.dart';
import 'timer_event.dart';
import 'timer_state.dart';

class TimerBloc extends HydratedBloc<TimerEvent, TimerState> {
  TimerBloc({
    required NotificationService notificationService,
    required SoundService soundService,
  }) : 
    _notificationService = notificationService,
    _soundService = soundService,
    super(const TimerState()) {
    on<TimerInitialized>(_onTimerInitialized);
    on<TimerToggled>(_onTimerToggled);
    on<TimerTicked>(_onTimerTicked);
    on<TimerReset>(_onTimerReset);
    on<TimerStageChanged>(_onTimerStageChanged);
    on<TimerSkipped>(_onTimerSkipped);
  }

  final NotificationService _notificationService;
  final SoundService _soundService;
  Timer? _timer;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void _onTimerInitialized(TimerInitialized event, Emitter<TimerState> emit) {
    // Initialize with default values
    final settings = event.settings ?? SettingsState.initial();
    final duration = _getDurationFromStage(state.stage, settings);
    
    emit(state.copyWith(
      minutes: duration,
      seconds: 0,
    ));
  }

  void _onTimerToggled(TimerToggled event, Emitter<TimerState> emit) {
    if (!state.isRunning) {
      // Start the timer
      _startTimer(emit);
      _soundService.playStart();
      emit(state.copyWith(isRunning: true));
    } else {
      // Pause the timer
      _timer?.cancel();
      emit(state.copyWith(isRunning: false));
    }
  }

  void _onTimerTicked(TimerTicked event, Emitter<TimerState> emit) {
    if (state.minutes == 0 && state.seconds == 0) {
      _timer?.cancel();
      
      // Timer is complete, move to next stage
      _onTimerSkipped(
        TimerSkipped(event.settings),
        emit,
      );
    } else {
      // Update the timer countdown
      if (state.seconds == 0) {
        emit(state.copyWith(
          minutes: state.minutes - 1,
          seconds: 59,
        ));
      } else {
        emit(state.copyWith(
          seconds: state.seconds - 1,
        ));
      }
    }
  }

  void _onTimerReset(TimerReset event, Emitter<TimerState> emit) {
    _timer?.cancel();
    final duration = _getDurationFromStage(state.stage, event.settings);
    
    emit(state.copyWith(
      minutes: duration,
      seconds: 0,
      isRunning: false,
    ));
  }

  void _onTimerStageChanged(TimerStageChanged event, Emitter<TimerState> emit) {
    _timer?.cancel();
    
    final duration = _getDurationFromStage(event.stage, event.settings);
    final prevStage = state.stage;
    
    // Send notification for stage change
    if (event.settings.notificationsEnabled) {
      _sendStageNotification(event.stage);
    }
    
    // Play sound for stage change
    if (event.settings.soundEnabled) {
      _playStageChangeSound(prevStage, event.stage);
    }

    emit(state.copyWith(
      stage: event.stage,
      prevStage: prevStage,
      minutes: duration,
      seconds: 0,
      isRunning: event.settings.autoResume,
    ));
    
    if (event.settings.autoResume) {
      _startTimer(emit);
    }
  }

  void _onTimerSkipped(TimerSkipped event, Emitter<TimerState> emit) {
    TimerStage nextStage;
    
    // Determine next stage based on current stage
    switch (state.stage) {
      case TimerStage.pomodoro:
        if (state.pomoCounter >= event.settings.pomosUntilLongBreak) {
          nextStage = TimerStage.longBreak;
        } else {
          nextStage = TimerStage.shortBreak;
        }
        break;
      case TimerStage.shortBreak:
      case TimerStage.longBreak:
        nextStage = TimerStage.pomodoro;
        break;
    }
    
    // Update pomo counter for next stage
    int nextPomoCounter = state.pomoCounter;
    if (nextStage == TimerStage.pomodoro) {
      if (state.stage == TimerStage.longBreak) {
        nextPomoCounter = 1;
      } else {
        nextPomoCounter = state.pomoCounter + 1;
      }
    }
    
    add(TimerStageChanged(
      stage: nextStage,
      settings: event.settings,
    ));
    
    emit(state.copyWith(
      pomoCounter: nextPomoCounter,
    ));
  }

  void _startTimer(Emitter<TimerState> emit) {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => add(TimerTicked(settings: SettingsState.initial())),
    );
  }

  int _getDurationFromStage(TimerStage stage, SettingsState settings) {
    switch (stage) {
      case TimerStage.pomodoro:
        return settings.pomoLength;
      case TimerStage.shortBreak:
        return settings.shortBreakLength;
      case TimerStage.longBreak:
        return settings.longBreakLength;
    }
  }

  void _sendStageNotification(TimerStage stage) {
    switch (stage) {
      case TimerStage.pomodoro:
        _notificationService.showNotification(
          'Pomo',
          'Time to focus!',
        );
        break;
      case TimerStage.shortBreak:
        _notificationService.showNotification(
          'Pomo',
          'Time for a short break!',
        );
        break;
      case TimerStage.longBreak:
        _notificationService.showNotification(
          'Pomo',
          'Time for a long break!',
        );
        break;
    }
  }

  void _playStageChangeSound(TimerStage prevStage, TimerStage newStage) {
    if (newStage == TimerStage.pomodoro) {
      if (prevStage == TimerStage.shortBreak) {
        _soundService.playShortBreakEnd();
      } else if (prevStage == TimerStage.longBreak) {
        _soundService.playLongBreakEnd();
      }
    } else if (newStage == TimerStage.shortBreak) {
      _soundService.playShortBreakStart();
    } else if (newStage == TimerStage.longBreak) {
      _soundService.playLongBreakStart();
    }
  }

  @override
  TimerState? fromJson(Map<String, dynamic> json) {
    return TimerState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(TimerState state) {
    return state.toJson();
  }
}