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

  Future<void> fetchProfileAndHistory(int superkey) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final historyData =
          await _supabaseService.fetchHistoryBySuperkey(superkey);

      if (historyData.isNotEmpty) {
        _historyList = historyData;
        _profileName = historyData.first.profileName;
      } else {
        final profileData =
            await _supabaseService.fetchProfileBySuperkey(superkey);
        _profileName = profileData?.name ?? 'Unknown';
        _historyList = [];
      }
    } catch (e) {
      _errorMessage = 'Error fetching history: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
