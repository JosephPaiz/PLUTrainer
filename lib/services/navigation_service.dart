import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationService {
  static Future<void> navigateTo(BuildContext context, String routeName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastRoute', routeName);
    Navigator.pushNamed(context, routeName);
  }

  static Future<void> navigateToAndReplace(
      BuildContext context, String routeName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastRoute', routeName);
    Navigator.pushReplacementNamed(context, routeName);
  }
}
