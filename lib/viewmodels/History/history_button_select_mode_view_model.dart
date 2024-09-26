import 'package:flutter/material.dart';

class HistoryButtonSelectModeViewModel extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  Future<void> selectIndex(int index) async {
    _selectedIndex = index;
    notifyListeners();
  }
}
