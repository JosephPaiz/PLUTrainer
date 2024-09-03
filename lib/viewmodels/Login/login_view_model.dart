import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plu_trainer/services/supabase_service.dart';

class LoginViewModel extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> verifySuperkey(int superkey, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final isValid = await _supabaseService.checkSuperkey(superkey);
      if (isValid) {
        // Guardar la superkey en SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('superkey', superkey);

        // Navegar a la pantalla de inicio
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
    Navigator.pushReplacementNamed(context, '/');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('superkey');
  }
}
