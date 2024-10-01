import 'package:flutter/foundation.dart';
import 'package:plu_trainer/models/exam_history_data.dart';
import 'package:plu_trainer/models/profile_model.dart';
import 'package:plu_trainer/services/supabase_service.dart';
import 'package:logger/logger.dart';

class ExamScoreViewModel extends ChangeNotifier {
  final Logger _logger = Logger();
  final SupabaseService _supabaseService = SupabaseService();

  List<dynamic> _previousProducts = [];
  List<bool> _responses = [];
  int _superKey = 0;
  int _answeredAnswers = 0;
  int _correctAnswers = 0;
  int _authorizedSuperkey = 0;
  int _duration = 0;
  double _score = 0.0;
  String? _profileName;

  bool _isDataReady = false;
  bool _isInserting = false;
  bool _hasInserted = false;

  // Getters
  List<dynamic> get previousProducts => _previousProducts;
  List<bool> get responses => _responses;
  int get answeredAnswers => _answeredAnswers;
  int get correctAnswers => _correctAnswers;
  int get duration => _duration;
  int get authorizedSuperkey => _authorizedSuperkey;
  double get score => _score;
  String? get profileName => _profileName;
  bool get isDataReady => _isDataReady;
  bool get hasInserted => _hasInserted;

  Future<void> updateData({
    required List<dynamic> products,
    required List<bool> responses,
    required int superKey,
    required int duration,
    required int authorizedSuperkey,
  }) async {
    _previousProducts = products;
    _responses = responses;
    _superKey = superKey;
    _duration = duration;
    _authorizedSuperkey = authorizedSuperkey;

    await _loadProfileName(authorizedSuperkey);
    _calculateScoreAndAnswers();

    _isDataReady = true;
    notifyListeners();

    // Attempt to insert data if it hasn't been inserted yet
    if (!_hasInserted) {
      await _insertDataIfReady();
    }
  }

  Future<void> _loadProfileName(int superkey) async {
    try {
      _logger.d('Fetching profile with superkey: $superkey');
      ProfileModel? profile =
          await _supabaseService.fetchProfileBySuperkey(superkey);

      if (profile != null) {
        _profileName = profile.name;
        _logger.d('Profile found: ${profile.name}');
      } else {
        _profileName = 'Profile not found';
        _logger.w('No profile found for superkey: $superkey');
      }
    } catch (e) {
      _profileName = 'Error loading profile';
      _logger.e('Error loading profile: $e');
    }
  }

  void _calculateScoreAndAnswers() {
    _answeredAnswers = _previousProducts.length;
    _correctAnswers = _responses.where((response) => response == true).length;
    _score =
        _answeredAnswers > 0 ? (_correctAnswers / _answeredAnswers) * 100 : 0.0;
    _score = double.parse(_score.toStringAsFixed(2));
    _logger.d('Score calculated: $_score');
  }

  Future<void> _insertDataIfReady() async {
    if (!_isDataReady || _isInserting || _hasInserted) return;

    _isInserting = true;
    notifyListeners();

    try {
      ExamHistoryData examHistoryData = ExamHistoryData(
        superKey: _superKey,
        score: _score,
        answeredQuestions: _answeredAnswers,
        correctAnswers: _correctAnswers,
        authorizedSuperkey: _authorizedSuperkey,
        duration: _duration,
      );

      await _supabaseService.examInsertHistory(examHistoryData);
      _logger.d('Exam History successfully inserted into Supabase.');
      _hasInserted = true;
    } catch (e) {
      _logger.e('Error inserting exam history into Supabase: $e');
    } finally {
      _isInserting = false;
      notifyListeners();
    }
  }

  void resetData() {
    _logger.d('Reset Data succesfully');
    _previousProducts = [];
    _responses = [];
    _superKey = 0;
    _answeredAnswers = 0;
    _correctAnswers = 0;
    _authorizedSuperkey = 0;
    _duration = 0;
    _score = 0.0;
    _profileName = null;
    _isDataReady = false;
    _isInserting = false;
    _hasInserted = false;
    notifyListeners();
  }
}
