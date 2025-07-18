// route_provider.dart
import 'package:flutter/material.dart';

class RouteProvider with ChangeNotifier {
  String _currentRoute = '/';

  String get currentRoute => _currentRoute;

  navigateTo(String routeName, BuildContext context) {
    _currentRoute = routeName;
    notifyListeners();
    Navigator.pushNamed(context, routeName);
  }

  void navigateReplace(String routeName, BuildContext context) {
    _currentRoute = routeName;
    notifyListeners();
    Navigator.pushReplacementNamed(context, routeName);
  }

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
