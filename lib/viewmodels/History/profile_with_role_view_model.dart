import 'package:flutter/material.dart';
import 'package:plu_trainer/services/supabase_service.dart';
import 'package:plu_trainer/models/profileWithRoles_model.dart';

class ProfileWithRoleViewModel extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  List<ProfileWithRoles> _profilesWithRoles = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ProfileWithRoles> get profilesWithRoles => _profilesWithRoles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProfilesWithRoles() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _supabaseService.getProfilesWithRoles();
      if (response.isEmpty) {
        _errorMessage = 'No se encontraron datos.';
      } else {
        _profilesWithRoles = _parseProfilesWithRoles(response);
      }
    } catch (e) {
      _errorMessage = 'Error fetching data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<ProfileWithRoles> _parseProfilesWithRoles(
      List<Map<String, dynamic>> data) {
    Map<int, ProfileWithRoles> resultMap = {};

    for (var item in data) {
      final profile = Profile.fromMap(item);
      final role = Role.fromMap(item);

      if (!resultMap.containsKey(profile.superkey)) {
        resultMap[profile.superkey] =
            ProfileWithRoles(profile: profile, roles: []);
      }

      resultMap[profile.superkey]?.roles.add(role);
    }

    return resultMap.values.toList();
  }
}
