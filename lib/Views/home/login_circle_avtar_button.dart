import 'package:flutter/material.dart';
import 'dart:math';

import 'package:multi_localization_app/constant/appColor.dart';

class AnimatedCircleButton extends StatefulWidget {
  @override
  _AnimatedCircleButtonState createState() => _AnimatedCircleButtonState();
}

class _AnimatedCircleButtonState extends State<AnimatedCircleButton>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  bool isLogin = true;
  bool isAnimating = true;

  @override
  void initState() {
    super.initState();

    // Rotation controller (on tap)
    _rotationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Pulse controller (runs automatically)
    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // loop animation
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _determinePosition() {
    _rotationController.forward(from: 0).whenComplete(() {
      setState(() {
        isLogin = !isLogin;
        isAnimating = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _determinePosition,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Flashing pulse animation behind the button
          AnimatedBuilder(
            animation: _pulseController,
            builder: (_, __) {
              return Container(
                width: 100 + _pulseController.value * 10,
                height: 100 + _pulseController.value * 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.withOpacity(1 - _pulseController.value),
                ),
              );
            },
          ),

          // Rotating Circle Avatar on tap
          AnimatedBuilder(
            animation: _pulseController,
            builder: (_, __) {
              return Transform.scale(
                scale: 1 + (_pulseController.value * 0.2),
                child: Container(
                  width: 120,
                  height: 120,
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundColor: isLogin
                        ? AppColor.primaryColor
                        : Colors.green.withOpacity(0.5),
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   color: Colors.green.withOpacity(1 - _pulseController.value),
                    // ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Text(
                        isLogin ? 'Login' : 'Logout',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
