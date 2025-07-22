import 'package:flutter/material.dart';
import 'package:multi_localization_app/l10n/app_localizations.dart';
import 'package:multi_localization_app/utils/custom_widgets.dart';

import '../../constant/appColor.dart';

class NeumorphicCircleButton extends StatefulWidget {
  final bool isLogin;
  final VoidCallback onTap;
  final bool isTaskCreated;

  const NeumorphicCircleButton({
    required this.isLogin,
    required this.onTap,
    required this.isTaskCreated,
  });

  @override
  _NeumorphicCircleButtonState createState() => _NeumorphicCircleButtonState();
}

class _NeumorphicCircleButtonState extends State<NeumorphicCircleButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isLogin
        ? AppColor.primaryColor
        : Colors.green.withAlpha(50);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
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
        child: widget.isTaskCreated
            ? CircleAvatar(
                radius: 50,
                backgroundColor: AppColor.secondaryColor,
                child: Text(
                  "Check-In",
                  // widget.isLogin
                  //     ? AppLocalizations.of(context)!.login
                  //     : AppLocalizations.of(context)!.logout,
                  style: MyCustomWidgets.textstyle(
                    textColor: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : CircleAvatar(
                radius: 50,
                backgroundColor: AppColor.secondaryColor,
                child: Text(
                  widget.isLogin
                      ? AppLocalizations.of(context)!.login
                      : AppLocalizations.of(context)!.logout,
                  style: MyCustomWidgets.textstyle(
                    textColor: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
      ),
    );
  }
}
