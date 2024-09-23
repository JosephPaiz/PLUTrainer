import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plu_trainer/services/supabase_service.dart';

class LoginViewModel extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  bool _isLoading = false;
  String? _errorMessage;
  int? _superkeyValue;
  bool _isAuthorized = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int? get superkeyValue => _superkeyValue;
  bool get isAuthorized => _isAuthorized;

  Future<void> verifySuperkey(int superkey, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final isValid = await _supabaseService.checkSuperkey(superkey);
      if (isValid) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('superkey', superkey);
        _superkeyValue = superkey;

        _isAuthorized =
            await _supabaseService.isUserInRole(superkey, [1, 2, 4]);

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
    _superkeyValue = null;
    _isAuthorized = false;
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('superkey')) {
      _superkeyValue = prefs.getInt('superkey');
      _isAuthorized =
          await _supabaseService.isUserInRole(_superkeyValue!, [1, 2, 4]);
      return true;
    }
    return false;
  }
}
