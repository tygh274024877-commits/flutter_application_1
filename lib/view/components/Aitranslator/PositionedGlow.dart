import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/color/constants.dart';

class PositionedGlow extends StatelessWidget {
  final double? top, right, bottom, left;
  final double opacity;

  const PositionedGlow({
    super.key,
    this.top,
    this.right,
    this.bottom,
    this.left,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      child: Container(
        width: 380,
        height: 380,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppColors.primary.withOpacity(opacity),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
