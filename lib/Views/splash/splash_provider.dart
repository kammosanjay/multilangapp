import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_localization_app/Views/home/home.dart';

class SplashProvider with ChangeNotifier {
  Future<void> initializeApp(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 600));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyHome()),
    );

    notifyListeners();
  }
}
