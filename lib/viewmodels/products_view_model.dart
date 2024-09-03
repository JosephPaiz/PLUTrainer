import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plu_trainer/models/products_model.dart';
import 'package:plu_trainer/services/supabase_service.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';

class ProductViewModel extends ChangeNotifier {
  final SupabaseService _service = SupabaseService();
  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;
  List<bool> _results = [];
  int _currentIndex = 0;
  List<bool> _visibilityFlags = [];
  TimerViewModel? _timerViewModel;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<bool> get results => _results;
  int get currentIndex => _currentIndex;
  List<bool> get visibilityFlags => _visibilityFlags;

  void setTimerViewModel(TimerViewModel timerViewModel) {
    _timerViewModel = timerViewModel;
    _timerViewModel?.onTimerEnd = () {
      _handleTimerEnd();
      fetchRandomProducts();
    };
  }

  Future<void> fetchRandomProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _service.fetchRandomProducts();
      _errorMessage = null;
      _results.clear();
      _currentIndex = 0;
      _initializeVisibilityFlags();
      _startAnimationSequence();
    } catch (e) {
      _errorMessage = 'Error getting products: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _initializeVisibilityFlags() {
    _visibilityFlags = List<bool>.filled(_products.length, false);
  }

  void _startAnimationSequence() {
    for (int i = 0; i < _visibilityFlags.length; i++) {
      Timer(Duration(milliseconds: i * 200), () {
        _visibilityFlags[i] = true;
        notifyListeners();
      });
    }
  }

  void restartAnimation() {
    _initializeVisibilityFlags();
    _startAnimationSequence();
  }

  void checkPLU(String pluStr) {
    int enteredPlu = int.tryParse(pluStr) ?? -1;

    if (enteredPlu == _products[_currentIndex].plu) {
      _results.add(true);
    } else {
      _results.add(false);
    }

    _currentIndex++;
    notifyListeners();

    if (_results.length >= 6) {
      _handleResultsReachedLimit();
    }
  }

  bool hasMoreProducts() {
    return _currentIndex < _products.length;
  }

  void _handleTimerEnd() {
    _handleRestartCondition();
  }

  void _handleRestartCondition() {
    fetchRandomProducts();
    _timerViewModel?.resetTimer();
    _timerViewModel?.startTimer();
  }

  void _handleResultsReachedLimit() {
    _timerViewModel?.stopTimer();
    _timerViewModel?.resetTimer();

    if (_timerViewModel?.onTimerEnd != null) {
      _timerViewModel?.onTimerEnd!();
    }

    fetchRandomProducts();
    notifyListeners();
  }
}
