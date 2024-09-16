// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:plu_trainer/services/supabase_service.dart';
// import 'package:plu_trainer/models/profile_model.dart';

// class SideBarViewModel extends ChangeNotifier {
//   int _selectedIndex = 0;
//   bool _isOpenSideBar = true;
//   bool _isInitialized = false;
//   String? _profileName; // Para almacenar el nombre del perfil.

//   final SupabaseService _supabaseService = SupabaseService();

//   int get selectedIndex => _selectedIndex;
//   bool get isOpenSideBar => _isOpenSideBar;
//   bool get isInitialized => _isInitialized;
//   String? get profileName => _profileName;

//   Future<void> initialize(int superkey) async {
//     await _loadPreferences();
//     await _loadProfileName(superkey);
//     _isInitialized = true;
//     notifyListeners();
//   }

//   Future<void> _loadProfileName(int superkey) async {
//     try {
//       ProfileModel? profile =
//           await _supabaseService.fetchProfileBySuperkey(superkey);

//       if (profile != null) {
//         _profileName = profile.name;
//       } else {
//         _profileName = 'Profile not found';
//       }
//     } catch (e) {
//       _profileName = 'Error loading profile: $e';
//       print('Error loading profile: $e');
//     }

//     notifyListeners();
//   }

//   Future<void> selectIndex(int index) async {
//     _selectedIndex = index;
//     await _savePreferences();
//     notifyListeners();
//   }

//   Future<void> contractSideBar() async {
//     _isOpenSideBar = !_isOpenSideBar;
//     await _savePreferences();
//     notifyListeners();
//   }

//   Future<void> _savePreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('selectedIndex', _selectedIndex);
//     await prefs.setBool('isOpenSideBar', _isOpenSideBar);
//   }

//   Future<void> _loadPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     _isOpenSideBar = prefs.getBool('isOpenSideBar') ?? true;
//     _selectedIndex = prefs.getInt('selectedIndex') ?? 0;
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plu_trainer/services/supabase_service.dart';
import 'package:plu_trainer/models/profile_model.dart';

class SideBarViewModel extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _isOpenSideBar = true;
  bool _isInitialized = false;
  String? _profileName; // Para almacenar el nombre del perfil.
  String? _errorMessage; // Mensaje de error si algo falla.

  final SupabaseService _supabaseService = SupabaseService();

  int get selectedIndex => _selectedIndex;
  bool get isOpenSideBar => _isOpenSideBar;
  bool get isInitialized => _isInitialized;
  String? get profileName => _profileName;
  String? get errorMessage => _errorMessage;

  Future<void> initialize(int superkey) async {
    try {
      await _loadPreferences();
      await _loadProfileName(superkey);
      _isInitialized = true;
    } catch (e) {
      _errorMessage = 'Error initializing sidebar: $e';
    }
    notifyListeners();
  }

  Future<void> _loadProfileName(int superkey) async {
    try {
      ProfileModel? profile =
          await _supabaseService.fetchProfileBySuperkey(superkey);

      if (profile != null) {
        _profileName = profile.name;
      } else {
        _profileName = 'Profile not found';
      }
    } catch (e) {
      _profileName = 'Error loading profile: $e';
      print('Error loading profile: $e');
    }

    notifyListeners();
  }

  Future<void> selectIndex(int index) async {
    _selectedIndex = index;
    await _savePreferences();
    notifyListeners();
  }

  Future<void> contractSideBar() async {
    _isOpenSideBar = !_isOpenSideBar;
    await _savePreferences();
    notifyListeners();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedIndex', _selectedIndex);
    await prefs.setBool('isOpenSideBar', _isOpenSideBar);
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isOpenSideBar = prefs.getBool('isOpenSideBar') ?? true;
    _selectedIndex = prefs.getInt('selectedIndex') ?? 0;
  }
}
