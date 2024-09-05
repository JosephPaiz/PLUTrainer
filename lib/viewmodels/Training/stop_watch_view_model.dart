// import 'dart:async';
// import 'package:flutter/material.dart';

// class StopWatchViewModel extends ChangeNotifier {
//   Timer? _timer;
//   int _elapsedSeconds = 0;
//   bool _isRunning = false;

//   int get elapsedSeconds => _elapsedSeconds;
//   bool get isRunning => _isRunning;

//   String get formattedTime {
//     final minutes = (_elapsedSeconds ~/ 60).toString().padLeft(2, '0');
//     final seconds = (_elapsedSeconds % 60).toString().padLeft(2, '0');
//     return '$minutes:$seconds';
//   }

//   void start() {
//     if (!_isRunning) {
//       _isRunning = true;
//       _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//         _elapsedSeconds++;
//         notifyListeners();
//       });
//     }
//   }

//   void stop() {
//     if (_isRunning) {
//       _timer?.cancel();
//       _isRunning = false;
//       notifyListeners();
//     }
//   }

//   void reset() {
//     _timer?.cancel();
//     _elapsedSeconds = 0;
//     _isRunning = false;
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';

class StopWatchViewModel extends ChangeNotifier {
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _isRunning = false;
  List<bool> _resultList = [];

  int get elapsedSeconds => _elapsedSeconds;
  bool get isRunning => _isRunning;
  List<bool> get resultList => _resultList;

  String get formattedTime {
    final minutes = (_elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  // Establecer la lista y verificar su tamaño
  void setResultList(List<bool> list, Function playStopButtonFuntion) {
    _resultList = list;
    // Detiene el cronómetro si la lista tiene 50 elementos
    if (_resultList.length >= 50) {
      playStopButtonFuntion();
      stop();
    }
  }

  void addResult(bool result) {
    _resultList.add(result);
    // Verificar si la lista ha alcanzado los 50 elementos
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
      _timer?.cancel();
      _isRunning = false;
      notifyListeners();
    }
  }

  void reset() {
    _timer?.cancel();
    _elapsedSeconds = 0;
    _isRunning = false;
    _resultList.clear(); // También resetea la lista de resultados
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
