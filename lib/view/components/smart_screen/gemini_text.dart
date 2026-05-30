import 'package:flutter/material.dart';

class GeminiText extends StatelessWidget {
  final double verticalOffset;
  final Color primaryColor;

  const GeminiText({
    Key? key,
    required this.verticalOffset,
    required this.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, verticalOffset),
      child: Text(
        'Gemini',
        style: TextStyle(
          fontSize: 42, // الحجم المصغر الذكي لمنع التداخل
          fontWeight: FontWeight.w900,
          color: primaryColor,
          fontFamily: 'Serif',
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}
