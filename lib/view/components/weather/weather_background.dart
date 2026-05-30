import 'dart:math';
import 'package:flutter/material.dart';

class LuxuryBackground extends StatelessWidget {
  final Color primaryColor;

  const LuxuryBackground({Key? key, required this.primaryColor})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            top: -60,
            left: -60,
            child: CircleAvatar(
              radius: 150,
              backgroundColor: primaryColor.withOpacity(0.02),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -50,
            child: CircleAvatar(
              radius: 120,
              backgroundColor: primaryColor.withOpacity(0.02),
            ),
          ),
        ],
      ),
    );
  }
}

class RainPainter extends CustomPainter {
  const RainPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final random = Random();

    for (int i = 0; i < 35; i++) {
      double startX = random.nextDouble() * size.width;
      double startY = random.nextDouble() * size.height;
      double dropLength = 15 + random.nextDouble() * 15;

      canvas.drawLine(
        Offset(startX, startY),
        Offset(startX + 3, startY + dropLength),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
