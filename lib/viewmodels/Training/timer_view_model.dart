import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plu_trainer/models/timer_model.dart';

class TimerViewModel extends ChangeNotifier {
  Timer? _timer;
  late TimerModel _timerModel;
  bool _isTimerRunning = false;
  VoidCallback? onTimerEnd;
  late int _initialTimeLeft;
  int _elapsedSeconds = 0;

  int get timeLeft => _timerModel.timeLeft;
  bool get isTimerRunning => _isTimerRunning;
  int get elapsedSeconds => _elapsedSeconds;

  String get formattedTime => _formatTime(_timerModel.timeLeft);

  void initializeTimer(int initialTime) {
    _initialTimeLeft = initialTime;
    _timerModel = TimerModel(timeLeft: initialTime);
    _elapsedSeconds = 0;
    notifyListeners();
  }

  void startTimer() {
    if (_isTimerRunning) return;

    _isTimerRunning = true;
    notifyListeners();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_timerModel.timeLeft > 0) {
          _timerModel.timeLeft--;
          _elapsedSeconds++;
          notifyListeners();
        } else {
          stopTimer();
          if (onTimerEnd != null) {
            onTimerEnd!();
          }
          notifyListeners();
        }
      },
    );
  }

  void stopTimer() {
    if (_isTimerRunning) {
      _timer?.cancel();
      _isTimerRunning = false;
      notifyListeners();
    }
  }

  void resetTimer() {
    stopTimer();
    _timerModel.timeLeft = _initialTimeLeft;
    _elapsedSeconds = 0;
    notifyListeners();
  }

  void setTimerDuration(int seconds) {
    stopTimer();
    _timerModel.timeLeft = seconds;
    _initialTimeLeft = seconds;
    _elapsedSeconds = 0;
    notifyListeners();
  }

  String _formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${_twoDigits(minutes)}:${_twoDigits(seconds)}';
  }

  String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
