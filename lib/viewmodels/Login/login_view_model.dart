// import 'package:flutter/material.dart';
// // ignore: depend_on_referenced_packages
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:plu_trainer/services/supabase_service.dart';

// class LoginViewModel extends ChangeNotifier {
//   final SupabaseService _supabaseService = SupabaseService();
//   bool _isLoading = false;
//   String? _errorMessage;

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;

//   Future<void> verifySuperkey(int superkey, BuildContext context) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       final isValid = await _supabaseService.checkSuperkey(superkey);
//       if (isValid) {
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setInt('superkey', superkey);

//         // ignore: use_build_context_synchronously
//         Navigator.pushReplacementNamed(context, '/home');
//       } else {
//         _errorMessage = 'Superkey inválido';
//       }
//     } catch (e) {
//       _errorMessage = 'Error al verificar la superkey';
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> logout(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('superkey');
//     // ignore: use_build_context_synchronously
//     Navigator.pushReplacementNamed(context, '/');
//   }

//   Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.containsKey('superkey');
//   }
// }

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plu_trainer/services/supabase_service.dart';

class LoginViewModel extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  bool _isLoading = false;
  String? _errorMessage;
  int? _superkeyValue; // Nueva variable para almacenar la superkey

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int? get superkeyValue =>
      _superkeyValue; // Getter para acceder a superkeyValue

  Future<void> verifySuperkey(int superkey, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final isValid = await _supabaseService.checkSuperkey(superkey);
      if (isValid) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('superkey', superkey);
        _superkeyValue =
            superkey; // Asigna el valor de superkey a superkeyValue

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _errorMessage = 'Superkey inválido';
      }
    } catch (e) {
      _errorMessage = 'Error al verificar la superkey';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('superkey');
    _superkeyValue = null; // Restablece superkeyValue a null en el logout
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('superkey')) {
      _superkeyValue = prefs.getInt('superkey'); // Obtiene la superkey guardada
      return true;
    }
    return false;
  }
}
