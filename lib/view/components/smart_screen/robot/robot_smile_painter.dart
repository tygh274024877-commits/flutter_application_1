import 'package:flutter/material.dart';

class RobotSmilePainter extends CustomPainter {
  final Color color;
  RobotSmilePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, 1);
    path.quadraticBezierTo(size.width / 2, size.height + 1, size.width, 1);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
