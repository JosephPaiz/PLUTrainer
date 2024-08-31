import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plu_trainer/models/timer_model.dart';

class TimerViewModel extends ChangeNotifier {
  Timer? _timer;
  final TimerModel _timerModel = TimerModel(timeLeft: 120);
  bool _isTimerRunning = false;
  VoidCallback? onTimerEnd;
  int _initialTimeLeft = 120;

  int get timeLeft => _timerModel.timeLeft;
  bool get isTimerRunning => _isTimerRunning;

  void startTimer() {
    if (_isTimerRunning) return;

    _initialTimeLeft = _timerModel.timeLeft;

    _isTimerRunning = true;
    notifyListeners();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_timerModel.timeLeft > 0) {
          _timerModel.timeLeft--;
          notifyListeners();
        } else {
          stopTimer();
          if (onTimerEnd != null) {
            onTimerEnd!();
          }
        }
      },
    );
  }

  void stopTimer() {
    _timer?.cancel();
    _isTimerRunning = false;
    notifyListeners();
  }

  void resetTimer() {
    stopTimer();
    _timerModel.timeLeft = _initialTimeLeft;
    notifyListeners();
  }

  void setTimerDuration(int seconds) {
    stopTimer();
    _timerModel.timeLeft = seconds;
    _initialTimeLeft = seconds;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
