import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plu_trainer/models/products_model.dart';
import 'package:plu_trainer/services/supabase_service.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';

class ExamPluListImageViewModel extends ChangeNotifier {
  final SupabaseService _service = SupabaseService();
  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;
  // ignore: prefer_final_fields
  List<bool> _results = [];
  int _currentIndex = 0;
  // List<bool> _visibilityFlags = [];
  bool _showScore = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<bool> get results => _results;
  int get currentIndex => _currentIndex;
  bool get showScore => _showScore;

  void connectToTimer(TimerViewModel timerViewModel) {
    timerViewModel.onTimerEnd = () {
      _showScore = true;

      notifyListeners();
    };
  }

  Future<void> fetchRandomProductsWithImage() async {
    _isLoading = true;

    notifyListeners();

    try {
      _products = await _service.fetchRandomProductsWithImage();
      _errorMessage = null;
      _results.clear();
      _currentIndex = 0;
    } catch (e) {
      _errorMessage = 'Error getting products: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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

    checkResultsLength();

    if (_results.length >= 10) {
      _handleResultsReachedLimit();
    }
  }

  void checkResultsLength() {
    if (_results.length >= 10) {
      _showScore = true;
    } else {
      _showScore = false;
    }
    notifyListeners();
  }

  bool hasMoreProducts() {
    return _currentIndex < _products.length;
  }

  void _handleResultsReachedLimit() {
    notifyListeners();
  }

  void openScoreView() {
    _showScore = true;
  }

  void resetButton() {
    _showScore = false;
    fetchRandomProductsWithImage();
  }
}
