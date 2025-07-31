import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:multi_localization_app/constant/appColor.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late Color _primaryColor;
  ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider() {
    _primaryColor = AppColor.primaryColor;
    loadTheme();
  }

  Color get primaryColor => _primaryColor;
  ThemeMode get themeMode => _themeMode;

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

  ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(backgroundColor: _primaryColor, centerTitle: true),
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
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
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  /// Update theme mode (light/dark/system)
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    saveThemeMode(mode);
    notifyListeners();
  }

  /// Change primary color
  void changeColor(Color color) {
    _primaryColor = color;
    saveThemeColor(color);
    notifyListeners();
  }

  /// Save selected color
  Future<void> saveThemeColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('theme_color', color.value);
  }

  /// Save selected theme mode
  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme_mode', mode.toString().split('.').last);
  }

  /// Load saved theme and color
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    // Load color
    int? colorValue = prefs.getInt('theme_color');
    if (colorValue != null) {
      _primaryColor = Color(colorValue);
    }

    // Load theme mode
    String? modeString = prefs.getString('theme_mode');
    if (modeString != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (e) => e.toString().split('.').last == modeString,
        orElse: () => ThemeMode.system,
      );
    }

    notifyListeners();
  }
}
