import 'package:flutter/material.dart';

class PlayStopButtonViewModel extends ChangeNotifier {
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;

  void togglePlayStop() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void stopPlaying() {
    _isPlaying = false;
    notifyListeners();
  }
}
