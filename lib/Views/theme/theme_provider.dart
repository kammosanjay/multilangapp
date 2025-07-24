import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_localization_app/constant/appColor.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late Color _primaryColor;

  ThemeProvider() {
    _primaryColor = AppColor.primaryColor; // default
    loadTheme();
  }

  Color get primaryColor => _primaryColor;
  static const List<Color> colors = [
    Color(0xFFE3BA72),
    Color(0xFF028900),
    Color(0xFFABCA99),
    Color(0xFFCF202F),
    Color(0xFF465923),
    Color(0xFF595123),
    Color(0xFF91482F),
    Color(0xFFFFBD23),
    Color(0xFF03BFFF),
    Color(0xFF636D86),
    Color(0xFFAAE5A4),
    Color(0xFFF08819),
    Color(0xFFF8F8F8),
    Color(0xFF5C6B5A),
    Color(0xFF6C4A4A),
    Color(0xFFD8A7A7),
    Color(0xFF9C7F75),
    Color(0xFFA2A77F),
    Color(0xFF49505A),
    Color(0xFFA9C2B5),
    Color(0xFFA8B1A4),
    Color(0xFFA2B1BD),
    Color(0xFF5D4954),
    Color(0xFF6F6F6F),
    Color(0xFFA8A9AD),
    Color(0xFFF1ECE6),
    Color(0xFF8A7E74),
    Color(0xFFD4C1A3),
    Color(0xFF133337),
    Color(0xFF3D4E57),
    Color(0xFF674C0E),
    Color(0xFF6A000E),
    Color(0xFFFFA500),
    Color(0xFF6E5132),
    Color(0xFFD4914C),
  ];
  // Define the theme data based on the primary color
  ThemeData get themeData => ThemeData(
    primaryColor: _primaryColor,
    colorScheme: ColorScheme.fromSeed(seedColor: _primaryColor),
    useMaterial3: true,
    appBarTheme: AppBarTheme(backgroundColor: _primaryColor),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.poppins(
        color: Colors.black,

        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
  // Define dark and light themes based on the primary color
  ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: _primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(backgroundColor: _primaryColor, centerTitle: true),
    scaffoldBackgroundColor: Colors.black,
  );
  ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: _primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(backgroundColor: _primaryColor, centerTitle: true),
    scaffoldBackgroundColor: Colors.white,
  );
  ThemeMode get themeMode {
    return _primaryColor.computeLuminance() > 0.5
        ? ThemeMode.light
        : ThemeMode.dark;
  }

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
