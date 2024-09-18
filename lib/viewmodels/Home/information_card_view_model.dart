import 'package:flutter/material.dart';
import 'package:plu_trainer/models/history_model.dart';
import 'package:plu_trainer/services/supabase_service.dart';

class InformationCardViewModel extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();

  List<double> _scores = [];
  List<int> _answeredQuestions = [];
  List<int> _correctAnswers = [];
  List<int> _pluHelperUsage = [];
  List<int> _duration = [];

  double _timePerQuestion = 0;
  double _totalResults = 0;
  double _averagePerTest = 0;
  double _averagePerPlUHelper = 0;
  double _realCorrectAnswers = 0;
  double _totalPLUHelper = 0;

  // ignore: unused_field
  int _countCorrectAnswers = 0;
  int _numberOfPLUHelper = 0;
  int _totalCorrectAnswers = 0;
  int _totalAnsweredQuestions = 0;
  int _totalDuration = 0;
  int _numberOfTest = 0;

  bool _isLoading = false;
  String? _errorMessage;

  List<double> get scores => _scores;
  List<int> get answeredQuestions => _answeredQuestions;
  List<int> get correctAnswers => _correctAnswers;
  List<int> get pluHelperUsage => _pluHelperUsage;
  List<int> get duration => _duration;
  int get totalCorrectAnswers => _totalCorrectAnswers;
  double get realCorrectAnswers => _realCorrectAnswers;
  double get timePerQuestion => _timePerQuestion;
  double get averagePerTest => _averagePerTest;
  double get averagePerPlUHelper => _averagePerPlUHelper;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchHistory(int superkey) async {
    _isLoading = true;
    notifyListeners();

    try {
      List<HistoryModel> histories =
          await _supabaseService.fetchHistoryBySuperkey(superkey);

      _scores = [];
      _answeredQuestions = [];
      _correctAnswers = [];
      _pluHelperUsage = [];
      _duration = [];
      _totalCorrectAnswers = 0;

      for (var history in histories) {
        _scores.add(history.score);
        _answeredQuestions.add(history.answeredQuestions);
        _correctAnswers.add(history.correctAnswers);
        _pluHelperUsage.add(history.pluHelperUsage);
        _duration.add(history.duration);
      }

      _calculateStatistics(
        _scores,
        _answeredQuestions,
        _correctAnswers,
        _duration,
      );

      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Error fetching history: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _calculateStatistics(List<double> scores, List<int> answeredQuestions,
      List<int> correctAnswers, List<int> duration) {
    if (answeredQuestions.isEmpty ||
        correctAnswers.isEmpty ||
        duration.isEmpty ||
        scores.isEmpty) {
      _totalAnsweredQuestions = 0;
      _totalCorrectAnswers = 0;
      _realCorrectAnswers = 0;
      _totalDuration = 0;
      _timePerQuestion = 0;
      _numberOfTest = 0;
      _totalResults = 0;
      _averagePerTest = 0;
      _numberOfPLUHelper = 0;
      _totalPLUHelper = 0;
      _averagePerPlUHelper = 0;
    } else {
      _totalAnsweredQuestions =
          answeredQuestions.fold(0, (sum, item) => sum + item);
      _countCorrectAnswers = correctAnswers.length;
      _totalCorrectAnswers = correctAnswers.fold(0, (sum, item) => sum + item);
      _realCorrectAnswers = 10 * _totalCorrectAnswers / _totalAnsweredQuestions;
      _totalDuration = duration.fold(0, (sum, item) => sum + item);
      _timePerQuestion = _totalDuration / _totalAnsweredQuestions;
      _numberOfTest = scores.length;
      _totalResults = scores.fold(0, (sum, item) => sum + item);
      _averagePerTest = _totalResults / _numberOfTest;
      _totalPLUHelper = _pluHelperUsage.fold(0, (sum, item) => sum + item);
      _numberOfPLUHelper = _pluHelperUsage.length;
      _averagePerPlUHelper = _totalPLUHelper / _numberOfPLUHelper;
    }
    notifyListeners();
  }
}
