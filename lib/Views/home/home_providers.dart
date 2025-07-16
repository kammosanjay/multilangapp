import 'package:flutter/material.dart';

class HomeProviders with ChangeNotifier {
  int _counter = 0;
  String _name = "sdfsfsd";
  int get counter => _counter;
  String get name => _name;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void decrementCounter() {
    if (_counter > 0) {
      _counter--;
      notifyListeners();
    }
  }

  String changeName(String newName) {
    if (newName.isNotEmpty) {
      _name = newName;
      notifyListeners();
    }
    return _name;
  }
}
