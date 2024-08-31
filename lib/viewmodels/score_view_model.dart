import 'package:flutter/material.dart';

class ScoreViewModel extends ChangeNotifier {
  List<dynamic> _previousProducts = [];
  List<bool> _responses = [];

  int _correctAnswers = 0;
  double _result = 0.0;

  List<dynamic> get previousProducts => _previousProducts;
  List<bool> get responses => _responses;
  int get correctAnswers => _correctAnswers;
  String get result => _result.toStringAsFixed(2);

  void addProduct(String product) {
    _previousProducts.add(product);
    notifyListeners();
  }

  void addResponse(bool response) {
    _responses.add(response);
    if (_responses.length == 6) {
      _calculateResults();
    }
    notifyListeners();
  }

  void _calculateResults() {
    _correctAnswers = _responses.where((response) => response).length;
    _result = (_correctAnswers * 100) / 6;
    _responses.clear();
  }

  void onResponsesChanged() {
    if (_responses.length == 6) {
      _calculateResults();
    }
  }

  void updateLists(List<dynamic> newProducts, List<bool> newResponses) {
    _previousProducts = newProducts;
    _responses = newResponses;
    notifyListeners();
    onResponsesChanged();
  }
}
