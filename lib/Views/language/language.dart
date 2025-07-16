import 'package:flutter/widgets.dart';

class Language with ChangeNotifier {
  static const List<Map<String, dynamic>> languages = [
    {"name": "English", 'locale': 'en'},
    {'name': "Hindi", 'locale': 'hi'},
    {'name': "Spanish", 'locale': 'es'},
    {'name': "Bengali", 'locale': 'bn'},
    {'name': "Tamil", 'locale': 'ta'},
    {'name': "Telugu", 'locale': 'te'},
    {'name': "Marathi", 'locale': 'mr'},
    {'name': "Kannada", 'locale': 'kn'},
    {'name': "Assamese", 'locale': 'as'},
    {'name': "Urdu", 'locale': 'ur'}
  ];

  Locale selectectLocale = Locale('en');

  //

  void changeLanguage(String language) {
    selectectLocale = Locale(language);

    notifyListeners();
  }
}
