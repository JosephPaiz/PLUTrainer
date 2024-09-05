import 'dart:async';
import 'package:flutter/material.dart';

class StopWatchViewModel extends ChangeNotifier {
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _isRunning = false;
  List<bool> _resultList = [];
  int _savedTime =
      0; // Variable para guardar el tiempo al detener el cronómetro

  int get elapsedSeconds => _elapsedSeconds;
  bool get isRunning => _isRunning;
  List<bool> get resultList => _resultList;
  int get savedTime => _savedTime; // Getter para obtener el tiempo guardado

  String get formattedTime {
    final minutes = (_elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void setResultList(List<bool> list, Function playStopButtonFuntion) {
    _resultList = list;
    if (_resultList.length >= 50) {
      playStopButtonFuntion();
      stop();
    }
  }

  void addResult(bool result) {
    _resultList.add(result);
    if (_resultList.length >= 50) {
      stop();
    }
    notifyListeners();
  }

  void start() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _elapsedSeconds++;
        notifyListeners();
      });
    }
  }

  void stop() {
    if (_isRunning) {
      _savedTime = _elapsedSeconds; // Guardar el tiempo al detener
      _timer?.cancel();
      _isRunning = false;
      notifyListeners();
    }
  }

  void reset() {
    stop();
    _elapsedSeconds = 0;
    _savedTime = 0;
    notifyListeners();
  }
}
