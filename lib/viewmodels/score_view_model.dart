// import 'package:flutter/material.dart';
// import 'package:plu_trainer/services/supabase_service.dart';
// import 'package:logger/logger.dart';

// class ScoreViewModel extends ChangeNotifier {
//   final Logger _logger = Logger();

//   List<dynamic> _previousProducts = [];
//   List<bool> _responses = [];

//   int superKey = 0;
//   int _answeredAnswers = 0;
//   int _correctAnswers = 0;
//   int _pluHelperUsage = 0;
//   String trainingType = '';
//   int duration = 0;
//   double _score = 0.0;
//   bool _shouldInsert = false;
//   bool _hasInserted = false;

//   final SupabaseService _supabaseService = SupabaseService();

//   // Getters
//   List<dynamic> get previousProducts => _previousProducts;
//   List<bool> get responses => _responses;
//   int get answeredAnswers => _answeredAnswers;
//   int get correctAnswers => _correctAnswers;
//   int get pluHelperUsage => _pluHelperUsage;
//   double get score => _score;

//   void updateData({
//     required List<dynamic> products,
//     required List<bool> responses,
//     required int superKey,
//     required int duration,
//     required String trainingType,
//     required int pluHelperUsage,
//     required bool shouldInsert,
//   }) {
//     _previousProducts = products;
//     _responses = responses;
//     this.superKey = superKey;
//     this.duration = duration;
//     this.trainingType = trainingType;
//     _pluHelperUsage = pluHelperUsage;

//     if (shouldInsert != _shouldInsert && shouldInsert == true) {
//       _hasInserted = false;
//     }

//     _shouldInsert = shouldInsert;

//     _answeredAnswers = _previousProducts.length;
//     _correctAnswers = _responses.where((response) => response == true).length;
//     _score = double.parse(_score.toStringAsFixed(2));

//     _calculateScore();

//     if (_shouldInsert && !_hasInserted) {
//       insertHistoryInSupabase();
//     }

//     notifyListeners();
//   }

//   void _calculateScore() {
//     if (_answeredAnswers > 0) {
//       _score = (_correctAnswers / _answeredAnswers) * 100;
//     } else {
//       _score = 0.0;
//     }
//   }

//   Future<void> insertHistoryInSupabase() async {
//     try {
//       await _supabaseService.insertHistory(
//         superKey,
//         _score,
//         _answeredAnswers,
//         _correctAnswers,
//         _pluHelperUsage,
//         trainingType,
//         duration,
//       );
//       _logger.d('History successfully inserted into Supabase.');
//       _hasInserted = true;
//     } catch (e) {
//       _logger.e('Error inserting history into Supabase: $e');
//     }
//   }

//   void resetInsertFlag() {
//     _hasInserted = false;
//   }
// }

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
  bool _hasInserted = false;

  final SupabaseService _supabaseService = SupabaseService();

  // Getters
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

    // Solo si cambia el valor de shouldInsert
    if (shouldInsert != _shouldInsert) {
      _shouldInsert = shouldInsert;
      if (_shouldInsert) {
        // Si shouldInsert es true, reiniciamos el flag de inserción
        _hasInserted = false;
      }
    }

    // Calcular respuestas y puntaje
    _answeredAnswers = _previousProducts.length;
    _correctAnswers = _responses.where((response) => response == true).length;
    _calculateScore();

    // Si shouldInsert es true, pero no se ha insertado todavía
    if (_shouldInsert && !_hasInserted) {
      insertHistoryInSupabase();
    }

    notifyListeners();
  }

  void _calculateScore() {
    if (_answeredAnswers > 0) {
      _score = (_correctAnswers / _answeredAnswers) * 100;
    } else {
      _score = 0.0;
    }
    _score = double.parse(_score.toStringAsFixed(2)); // Asegurar redondeo
  }

  Future<void> insertHistoryInSupabase() async {
    try {
      // Hacemos la inserción en la tabla solo si aún no se ha hecho
      if (!_hasInserted) {
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
        _hasInserted = false; // Asegurar que solo se inserte una vez
      }
    } catch (e) {
      _logger.e('Error inserting history into Supabase: $e');
    }
  }

  void resetInsertFlag() {
    _hasInserted = false; // Permitir que se inserte nuevamente si es necesario
  }
}
