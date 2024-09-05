import 'package:flutter/material.dart';

class PLUHelperViewModel extends ChangeNotifier {
  late AnimationController _animationController;
  // ignore: unused_field
  bool _hasAnimationStarted = false;
  bool _isAnimationComplete = false;
  int _lastListLength = 0;
  bool _firstAnimationDone = false;
  bool _wasTimerRunning = false;
  int _productIndex = 0;
  List<dynamic> _previousList = [];
  int _pluHelperUsage = 0;

  AnimationController get animationController => _animationController;
  bool get isAnimationComplete => _isAnimationComplete;
  int get productIndex => _productIndex;
  int get pluHelperUsage => _pluHelperUsage;

  void initAnimationController(TickerProvider vsync) {
    _animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 5),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isAnimationComplete = true;
        _pluHelperUsage++;
        notifyListeners();
      }
    });
  }

  void startAnimationIfNeeded(
      bool isTimerRunning, List<bool> boolList, List<dynamic> dynamicList) {
    if (_hasListChanged(dynamicList)) {
      resetIndex();
    }

    if (isTimerRunning && !_wasTimerRunning) {
      _startAnimation();
      _firstAnimationDone = true;
    } else if (isTimerRunning) {
      if (_firstAnimationDone && boolList.length > _lastListLength) {
        _incrementIndexAndStartAnimation();
      }
      _lastListLength = boolList.length;
    }

    _wasTimerRunning = isTimerRunning;
  }

  bool _hasListChanged(List<dynamic> dynamicList) {
    if (_previousList.length != dynamicList.length) {
      _previousList = List.from(dynamicList);
      return true;
    }
    for (int i = 0; i < dynamicList.length; i++) {
      if (_previousList[i] != dynamicList[i]) {
        _previousList = List.from(dynamicList);
        return true;
      }
    }
    return false;
  }

  void _startAnimation() {
    _hasAnimationStarted = true;
    _isAnimationComplete = false;
    _animationController.forward(from: 0.0);
    notifyListeners();
  }

  void _incrementIndexAndStartAnimation() {
    _productIndex++;
    _startAnimation();
  }

  void resetIndex() {
    _productIndex = 0;
    notifyListeners();
  }

  void resetPluHelperUsage() {
    _pluHelperUsage = 0;
    notifyListeners();
  }

  void resetAnimation() {
    _hasAnimationStarted = false;
    _isAnimationComplete = false;
    _firstAnimationDone = false;
    _lastListLength = 0;
    _productIndex = 0;
    _previousList.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
