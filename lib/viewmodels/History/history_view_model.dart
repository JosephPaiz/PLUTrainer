import 'package:flutter/material.dart';
import 'package:plu_trainer/models/history_model.dart'; // Modelo de historial
import 'package:plu_trainer/services/supabase_service.dart'; // Servicio

class HistoryViewModel extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  bool _isLoading = false;
  String? _errorMessage;
  String? _profileName;
  List<HistoryModel> _historyList = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get profileName => _profileName;
  List<HistoryModel> get historyList => _historyList;

  // Método para obtener el nombre del perfil y el historial de la superkey
  // Future<void> fetchProfileAndHistory(int superkey) async {
  //   _isLoading = true;
  //   _errorMessage = null;
  //   notifyListeners();

  //   try {
  //     final historyData =
  //         await _supabaseService.fetchHistoryBySuperkey(superkey);
  //     if (historyData.isNotEmpty) {
  //       _historyList = historyData;
  //       _profileName =
  //           historyData.first.profileName; // Asigna el nombre del perfil
  //     } else {
  //       _historyList = [];
  //       _profileName = 'No history available';
  //     }
  //   } catch (e) {
  //     _errorMessage = 'Error fetching history: $e';
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
  Future<void> fetchProfileAndHistory(int superkey) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Llamar al servicio que devuelve tanto el perfil como el historial
      final historyData =
          await _supabaseService.fetchHistoryBySuperkey(superkey);

      // Si el historial no está vacío, actualizamos la lista de historial
      if (historyData.isNotEmpty) {
        _historyList = historyData;
        _profileName =
            historyData.first.profileName; // Asigna el nombre del perfil
      } else {
        // Si no hay historial, aseguramos que se muestre el nombre del perfil
        final profileData =
            await _supabaseService.fetchProfileBySuperkey(superkey);
        _profileName = profileData?.name ??
            'Unknown'; // Asigna el nombre del perfil si está disponible
        _historyList = []; // Vaciamos la lista de historial si no hay historial
      }
    } catch (e) {
      _errorMessage = 'Error fetching history: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
