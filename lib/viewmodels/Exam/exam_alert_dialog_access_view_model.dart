import 'package:flutter/material.dart';
import 'package:plu_trainer/services/supabase_service.dart';

class ExamAlertDialogAccessViewModel extends ChangeNotifier {
  final TextEditingController superkeyController = TextEditingController();
  final SupabaseService _supabaseService;
  String message = '';
  int authorizedSuperkey = 0;
  bool hasPermission = false;
  bool isLoading = false;

  ExamAlertDialogAccessViewModel({SupabaseService? supabaseService})
      : _supabaseService = supabaseService ?? SupabaseService();

  Future<void> verifySuperkey() async {
    final superkey = int.tryParse(superkeyController.text);
    if (superkey == null) {
      message = 'Por favor, ingresa un número válido.';
      notifyListeners();
      return;
    }

    try {
      isLoading = true;
      notifyListeners();

      hasPermission = await _supabaseService.hasPermissions(superkey);

      if (hasPermission) {
        authorizedSuperkey = superkey;
        message = 'Superclave válida. Puedes continuar.';
      } else {
        authorizedSuperkey = 0;
        message = 'Superclave no válida. Inténtalo de nuevo.';
      }
    } catch (e) {
      message = 'Error al verificar la superclave. Inténtalo más tarde.';
      hasPermission = false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void resetState() {
    superkeyController.clear();
    message = '';
    hasPermission = false;
    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    superkeyController.dispose();
    super.dispose();
  }
}
