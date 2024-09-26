import 'package:flutter/material.dart';
import 'package:plu_trainer/models/exam_history_data.dart';
import 'package:plu_trainer/models/profile_model.dart';
import 'package:plu_trainer/services/supabase_service.dart';
import 'package:logger/logger.dart';

class ExamScoreViewModel extends ChangeNotifier {
  final Logger _logger = Logger();

  List<dynamic> _previousProducts = [];
  List<bool> _responses = [];

  int superKey = 0;
  int _answeredAnswers = 0;
  int _correctAnswers = 0;
  int _authorizedSuperkey = 0;
  int duration = 0;
  double _score = 0.0;
  bool _shouldInsert = false;
  bool _hasInserted = false;
  bool _isInserting = false;
  String? _profileName;

  final SupabaseService _supabaseService = SupabaseService();

  // Getters
  List<dynamic> get previousProducts => _previousProducts;
  List<bool> get responses => _responses;
  int get answeredAnswers => _answeredAnswers;
  int get correctAnswers => _correctAnswers;
  int get authorizedSuperkey => _authorizedSuperkey;
  double get score => _score;
  bool get shouldInsert => _shouldInsert;
  bool get hasInserted => _hasInserted;
  String? get profileName => _profileName;

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
    required int authorizedSuperkey,
    required bool shouldInsert,
  }) {
    _previousProducts = products;
    _responses = responses;
    this.superKey = superKey;
    this.duration = duration;
    _authorizedSuperkey = authorizedSuperkey;
    _loadProfileName(authorizedSuperkey);
    if (shouldInsert && !_hasInserted && !_isInserting) {
      _shouldInsert = true;
      _calculateAndInsertData();
    } else {
      _shouldInsert = false;
    }

    notifyListeners();
  }

  Future<void> _loadProfileName(int superkey) async {
    try {
      _logger.d('Buscando perfil con superkey: $superkey');
      ProfileModel? profile =
          await _supabaseService.fetchProfileBySuperkey(superkey);

      if (profile != null) {
        _profileName = profile.name;
        _logger.d('Perfil encontrado: ${profile.name}');
      } else {
        _profileName = 'Perfil no encontrado';
        _logger.w('No se encontró el perfil para la superkey: $superkey');
      }
    } catch (e) {
      _profileName = 'Error al cargar el perfil: $e';
      _logger.e('Error al cargar el perfil: $e');
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
      ExamHistoryData examHistoryData = ExamHistoryData(
        superKey: superKey,
        score: _score,
        answeredQuestions: _answeredAnswers,
        correctAnswers: _correctAnswers,
        authorizedSuperkey: _authorizedSuperkey,
        duration: duration,
      );

      await _supabaseService.examInsertHistory(examHistoryData);
      _logger.d('Exam History successfully inserted into Supabase.');

      _hasInserted = true;
      _shouldInsert = false;
    } catch (e) {
      _logger.e('Error inserting exam history into Supabase: $e');
    }
  }

  void resetData() {
    _previousProducts = [];
    _responses = [];
    superKey = 0;
    _answeredAnswers = 0;
    _correctAnswers = 0;
    _authorizedSuperkey = 0;
    duration = 0;
    _score = 0.0;
    _hasInserted = false;
    _shouldInsert = false;
    _isInserting = false;
    notifyListeners();
  }
}
