import 'package:flutter/material.dart';
import 'package:plu_trainer/models/history_data.dart';
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
  bool _hasInserted = false;
  bool _isInserting = false;

  final SupabaseService _supabaseService = SupabaseService();

  // Getters
  List<dynamic> get previousProducts => _previousProducts;
  List<bool> get responses => _responses;
  int get answeredAnswers => _answeredAnswers;
  int get correctAnswers => _correctAnswers;
  int get pluHelperUsage => _pluHelperUsage;
  double get score => _score;
  bool get shouldInsert => _shouldInsert;
  bool get hasInserted => _hasInserted;

  // Setters
  set shouldInsert(bool value) {
    _shouldInsert = value;
    notifyListeners();
  }

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

    if (shouldInsert && !_hasInserted && !_isInserting) {
      _shouldInsert = true;
      _calculateAndInsertData();
    } else {
      _shouldInsert = false;
    }

    notifyListeners();
  }

  Future<void> _calculateAndInsertData() async {
    if (_hasInserted || _isInserting) return;

    _isInserting = true;

    _answeredAnswers = _previousProducts.length;
    _correctAnswers = _responses.where((response) => response == true).length;
    _calculateScore();

    if (_answeredAnswers > 0 && _correctAnswers >= 0) {
      _logger.d('Data is valid, proceeding with insert');
      await insertHistoryInSupabase();
    } else {
      _logger.e('Data is incomplete or incorrect, skipping insertion.');
    }

    _isInserting = false;
    notifyListeners();
  }

  void _calculateScore() {
    if (_answeredAnswers > 0) {
      _score = (_correctAnswers / _answeredAnswers) * 100;
    } else {
      _score = 0.0;
    }
    _score = double.parse(_score.toStringAsFixed(2));
    _logger.d('Score calculated: $_score');
  }

  Future<void> insertHistoryInSupabase() async {
    if (_hasInserted) return;

    try {
      HistoryData historyData = HistoryData(
          superKey: superKey,
          score: _score,
          answeredQuestions: _answeredAnswers,
          correctAnswers: _correctAnswers,
          pluHelperUsage: _pluHelperUsage,
          trainingType: trainingType,
          duration: duration,
          date: DateTime.now());

      await _supabaseService.insertHistory(historyData);
      _logger.d('History successfully inserted into Supabase.');

      _hasInserted = true;
      _shouldInsert = false;
    } catch (e) {
      _logger.e('Error inserting history into Supabase: $e');
    }
  }

  void resetData() {
    _logger.d('Reset data score is ready');
    _previousProducts = [];
    _responses = [];
    superKey = 0;
    _answeredAnswers = 0;
    _correctAnswers = 0;
    _pluHelperUsage = 0;
    trainingType = '';
    duration = 0;
    _score = 0.0;
    _hasInserted = false;
    _shouldInsert = false;
    _isInserting = false;
    notifyListeners();
  }
}
