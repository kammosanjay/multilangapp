import 'package:flutter/material.dart';
import 'package:multi_localization_app/MyPageRoute/route_provider.dart';
import 'package:multi_localization_app/Views/theme/theme_provider.dart';
import 'package:multi_localization_app/l10n/app_localizations.dart';
import 'package:multi_localization_app/utils/custom_widgets.dart';
import 'package:provider/provider.dart';

import '../../constant/appColor.dart';

class NeumorphicCircleButtonCheckIn extends StatefulWidget {
  // final bool isLogin;

  final bool isTaskCreated;

  const NeumorphicCircleButtonCheckIn({
    // required this.isLogin,
    required this.isTaskCreated,
  });

  @override
  _NeumorphicCircleButtonCheckInState createState() =>
      _NeumorphicCircleButtonCheckInState();
}

class _NeumorphicCircleButtonCheckInState
    extends State<NeumorphicCircleButtonCheckIn> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.green.withAlpha(50);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        // context.read<RouteProvider>().navigateTo('/CreateTasklist', context);
      },
      // onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          boxShadow: _isPressed
              ? [
                  // inner pressed effect
                  BoxShadow(
                    // color: Colors.black26,
                    color: Colors.red.withAlpha(70),
                    offset: Offset(20, 20),
                    blurRadius: 60,
                    spreadRadius: 10,
                  ),
                  BoxShadow(
                    // color: Colors.white.withOpacity(0.8),
                    color: Colors.amber.withAlpha(70),
                    offset: Offset(-20, -20),
                    blurRadius: 60,
                    spreadRadius: 10,
                  ),
                ]
              : [
                  // outer raised effect
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(4, 4),
                    blurRadius: 8,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.9),
                    offset: Offset(-4, -4),
                    blurRadius: 8,
                  ),
                ],
        ),
        child: CircleAvatar(
          radius: 50,
          backgroundColor: AppColor.primaryColor(context),
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return Text(
                "Check-In",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
