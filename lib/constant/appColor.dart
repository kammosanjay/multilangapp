import 'package:flutter/material.dart';

// class AppColor {
//   static const Color primaryColor = Color.fromARGB(255, 136, 208, 241);
//   static const Color secondaryColor = Color(0xFF03DAC6);
//   static const Color backgroundColor = Color(0xFFFFFFFF);
//   static const Color textColor = Colors.black45;
//   static const Color errorColor = Color(0xFFB00020);
//   static const Color buttonColor = Color(0xFF6200EE);
//   static  Color headingColor = Colors.grey.shade900;
// }

class AppColor {
  // Dynamic primary color from theme
  static Color primaryColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  static Color backgroundColor(BuildContext context) =>
      Theme.of(context).scaffoldBackgroundColor;

  static Color textColor(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;

  static Color errorColor(BuildContext context) =>
      Theme.of(context).colorScheme.error;

  static Color headingColor(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall?.color ?? Colors.black;

  static Color buttonColor(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;
}
