// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SideBarViewModel extends ChangeNotifier {
//   int _selectedIndex = 0;
//   bool _isOpenSideBar = true;
//   bool _isInitialized = false;

//   int get selectedIndex => _selectedIndex;
//   bool get isOpenSideBar => _isOpenSideBar;
//   bool get isInitialized => _isInitialized;

//   SideBarViewModel() {
//     _initialize();
//   }

//   Future<void> _initialize() async {
//     await _loadPreferences();
//     _isInitialized = true;
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

class SideBarViewModel extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _isOpenSideBar = true;
  bool _isInitialized = false;

  int get selectedIndex => _selectedIndex;
  bool get isOpenSideBar => _isOpenSideBar;
  bool get isInitialized => _isInitialized;

  SideBarViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadPreferences();
    _isInitialized = true;
    notifyListeners(); // Notifica a la UI que los datos están cargados
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
