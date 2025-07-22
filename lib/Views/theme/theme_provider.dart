import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late Color _primaryColor;

  ThemeProvider() {
    _primaryColor = Colors.blue; // default
    loadTheme();
  }

  Color get primaryColor => _primaryColor;

  ThemeData get themeData => ThemeData(
    primaryColor: _primaryColor,
    colorScheme: ColorScheme.fromSeed(seedColor: _primaryColor),
    useMaterial3: true,
  );

  void changeColor(Color color) {
    _primaryColor = color;
    saveTheme(color);
    notifyListeners();
  }

  Future<void> saveTheme(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('theme_color', color.value);
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    int? colorValue = prefs.getInt('theme_color');
    if (colorValue != null) {
      _primaryColor = Color(colorValue);
      notifyListeners();
    }
  }
}
