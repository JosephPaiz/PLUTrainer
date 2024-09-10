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

//   final SupabaseService _supabaseService = SupabaseService();

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

//     if (shouldInsert && !_shouldInsert) {
//       _shouldInsert = true;
//       _calculateAndInsertData();
//     } else {
//       _shouldInsert = false;
//     }

//     notifyListeners();
//   }

//   Future<void> _calculateAndInsertData() async {
//     _answeredAnswers = _previousProducts.length;
//     _correctAnswers = _responses.where((response) => response == true).length;
//     _calculateScore();

//     if (_answeredAnswers > 0 && _correctAnswers >= 0) {
//       await insertHistoryInSupabase();
//     } else {
//       _logger.e('Data is incomplete or incorrect, skipping insertion.');
//     }
//   }

//   void _calculateScore() {
//     if (_answeredAnswers > 0) {
//       _score = (_correctAnswers / _answeredAnswers) * 100;
//     } else {
//       _score = 0.0;
//     }
//     _score = double.parse(_score.toStringAsFixed(2));
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
//     } catch (e) {
//       _logger.e('Error inserting history into Supabase: $e');
//     }
//   }
// }

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
//   bool _hasInserted =
//       false; // Nueva variable para controlar si ya se ha insertado

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

//     // Si debe insertar y no se ha insertado todavía
//     if (shouldInsert && !_shouldInsert && !_hasInserted) {
//       _shouldInsert = true;
//       _logger.d('Setting _shouldInsert to true');
//       _calculateAndInsertData();
//     }

//     notifyListeners();
//   }

//   Future<void> _calculateAndInsertData() async {
//     _answeredAnswers = _previousProducts.length;
//     _correctAnswers = _responses.where((response) => response == true).length;
//     _calculateScore();

//     // Verifica si los datos son válidos antes de intentar insertar
//     if (_answeredAnswers > 0 && _correctAnswers >= 0) {
//       _logger.d('Data is valid, proceeding with insert');
//       await insertHistoryInSupabase();
//     } else {
//       _logger.e('Data is incomplete or incorrect, skipping insertion.');
//     }
//   }

//   void _calculateScore() {
//     if (_answeredAnswers > 0) {
//       _score = (_correctAnswers / _answeredAnswers) * 100;
//     } else {
//       _score = 0.0;
//     }
//     _score = double.parse(_score.toStringAsFixed(2));
//     _logger.d('Score calculated: $_score');
//   }

//   Future<void> insertHistoryInSupabase() async {
//     try {
//       // Solo inserta si no se ha insertado ya
//       if (!_hasInserted) {
//         await _supabaseService.insertHistory(
//           superKey,
//           _score,
//           _answeredAnswers,
//           _correctAnswers,
//           _pluHelperUsage,
//           trainingType,
//           duration,
//         );
//         _logger.d('History successfully inserted into Supabase.');

//         _hasInserted = true; // Marca como que ya se ha insertado.
//         _shouldInsert =
//             false; // Resetea la variable para prevenir inserciones adicionales.
//       } else {
//         _logger.w('Skipping insert, as history has already been inserted.');
//       }
//     } catch (e) {
//       _logger.e('Error inserting history into Supabase: $e');
//     }
//   }

//   void resetInsertFlag() {
//     _hasInserted = false; // Permite que se inserte nuevamente si es necesario
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
  bool _hasInserted = false; // Control de inserción única

  final SupabaseService _supabaseService = SupabaseService();

  // Getters
  List<dynamic> get previousProducts => _previousProducts;
  List<bool> get responses => _responses;
  int get answeredAnswers => _answeredAnswers;
  int get correctAnswers => _correctAnswers;
  int get pluHelperUsage => _pluHelperUsage;
  double get score => _score;
  bool get shouldInsert => _shouldInsert;

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
    _shouldInsert = shouldInsert;

    // Solo proceder con la inserción si shouldInsert es true
    if (_shouldInsert && !_hasInserted) {
      _calculateAndInsertData();
    }

    notifyListeners();
  }

  Future<void> _calculateAndInsertData() async {
    _answeredAnswers = _previousProducts.length;
    _correctAnswers = _responses.where((response) => response == true).length;
    _calculateScore();

    // Verifica si los datos son válidos antes de intentar insertar
    if (_answeredAnswers > 0 && _correctAnswers >= 0) {
      _logger.d('Data is valid, proceeding with insert');
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
    _logger.d('Score calculated: $_score');
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

      // Marca como insertado para evitar inserciones adicionales
      _hasInserted = true;
      // Cambia el estado de shouldInsert a false para que no se vuelva a insertar
      _shouldInsert = false;
    } catch (e) {
      _logger.e('Error inserting history into Supabase: $e');
    }
  }

  // Método para reiniciar los valores a su estado inicial
  void resetData() {
    _previousProducts = [];
    _responses = [];
    superKey = 0;
    _answeredAnswers = 0;
    _correctAnswers = 0;
    _pluHelperUsage = 0;
    trainingType = '';
    duration = 0;
    _score = 0.0;
    _hasInserted = false; // Permite que se vuelva a insertar si es necesario
    _shouldInsert = false;
    notifyListeners();
  }
}
