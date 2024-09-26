import 'package:flutter/material.dart';
import 'package:plu_trainer/models/exam_history_model.dart';
import 'package:plu_trainer/services/supabase_service.dart';

class ExamHistoryViewModel extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  bool _isLoading = false;
  String? _errorMessage;
  List<ExamHistoryModel> _historyList = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<ExamHistoryModel> get historyList => _historyList;

  Future<void> fetchExamHistory(int superkey) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final historyData =
          await _supabaseService.fetchExamHistoryBySuperkey(superkey);

      if (historyData.isNotEmpty) {
        _historyList = historyData;
      } else {
        final profileData =
            await _supabaseService.fetchProfileBySuperkey(superkey);
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
