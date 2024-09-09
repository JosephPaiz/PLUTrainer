import 'package:flutter/material.dart';
import 'package:plu_trainer/services/supabase_service.dart';
import 'package:logger/logger.dart';

class ScoreViewModel extends ChangeNotifier {
  final Logger _logger = Logger();

  List<dynamic> _previousProducts = [];
  List<bool> _responses = [];

  int superKey = 0;
  int _answeredAnswers = 0;
  int _correctAnswers = 0;
  int _pluHelperUsage = 0;
  String trainingType = '';
  int duration = 0;
  double _score = 0.0;
  bool _shouldInsert = false;

  final SupabaseService _supabaseService = SupabaseService();

  List<dynamic> get previousProducts => _previousProducts;
  List<bool> get responses => _responses;
  int get answeredAnswers => _answeredAnswers;
  int get correctAnswers => _correctAnswers;
  int get pluHelperUsage => _pluHelperUsage;
  double get score => _score;

  void updateData({
    required List<dynamic> products,
    required List<bool> responses,
    required int superKey,
    required int duration,
    required String trainingType,
    required int pluHelperUsage,
    required bool shouldInsert,
  }) {
    _previousProducts = products;
    _responses = responses;
    this.superKey = superKey;
    this.duration = duration;
    this.trainingType = trainingType;
    _pluHelperUsage = pluHelperUsage;

    if (shouldInsert && !_shouldInsert) {
      _shouldInsert = true;
      _calculateAndInsertData();
    } else {
      _shouldInsert = false;
    }

    notifyListeners();
  }

  Future<void> _calculateAndInsertData() async {
    _answeredAnswers = _previousProducts.length;
    _correctAnswers = _responses.where((response) => response == true).length;
    _calculateScore();

    if (_answeredAnswers > 0 && _correctAnswers >= 0) {
      await insertHistoryInSupabase();
    } else {
      _logger.e('Data is incomplete or incorrect, skipping insertion.');
    }
  }

  void _calculateScore() {
    if (_answeredAnswers > 0) {
      _score = (_correctAnswers / _answeredAnswers) * 100;
    } else {
      _score = 0.0;
    }
    _score = double.parse(_score.toStringAsFixed(2));
  }

  Future<void> insertHistoryInSupabase() async {
    try {
      await _supabaseService.insertHistory(
        superKey,
        _score,
        _answeredAnswers,
        _correctAnswers,
        _pluHelperUsage,
        trainingType,
        duration,
      );
      _logger.d('History successfully inserted into Supabase.');
    } catch (e) {
      _logger.e('Error inserting history into Supabase: $e');
    }
  }
}
