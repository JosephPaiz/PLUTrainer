import 'package:flutter/material.dart';

class PLUHelperViewModel extends ChangeNotifier {
  late AnimationController _animationController;
  bool _hasAnimationStarted = false;
  bool _isAnimationComplete = false;
  List<dynamic> _previousProducts = [];
  int _lastResultsLength = 0;
  int _productIndex = 0;

  AnimationController get animationController => _animationController;
  bool get isAnimationComplete => _isAnimationComplete;
  int get productIndex => _productIndex;

  void initAnimationController(TickerProvider vsync) {
    _animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 5),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isAnimationComplete = true;
        notifyListeners();
      }
    });
  }

  void disposeAnimationController() {
    _animationController.dispose();
  }

  void checkAndAnimate({
    required bool isTimerRunning,
    required List<dynamic> products,
    required List<bool> results,
  }) {
    if (isTimerRunning && !_hasAnimationStarted) {
      _startAnimation();
    } else if (isTimerRunning &&
        (_hasProductsChanged(products) || _hasResultsChanged(results))) {
      _startAnimation();
    }
  }

  bool _hasProductsChanged(List<dynamic> currentProducts) {
    if (currentProducts.length != _previousProducts.length) {
      _previousProducts = List.from(currentProducts);
      _resetProductIndex();
      return true;
    }

    for (int i = 0; i < currentProducts.length; i++) {
      if (currentProducts[i] != _previousProducts[i]) {
        _previousProducts = List.from(currentProducts);
        _resetProductIndex();
        return true;
      }
    }

    return false;
  }

  void _resetProductIndex() {
    _productIndex = 0;
    notifyListeners();
  }

  bool _hasResultsChanged(List<bool> results) {
    if (results.length > _lastResultsLength) {
      _lastResultsLength = results.length;
      _productIndex = _lastResultsLength;
      notifyListeners();
      return true;
    }
    return false;
  }

  void _startAnimation() {
    _hasAnimationStarted = true;
    _isAnimationComplete = false;
    _animationController.forward(from: 0.0);
    notifyListeners();
  }
}
