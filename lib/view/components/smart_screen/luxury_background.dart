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
