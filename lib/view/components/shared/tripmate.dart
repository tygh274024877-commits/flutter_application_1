import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/color/constants.dart';

class TripMate extends StatelessWidget {
  const TripMate({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
        children: [
          TextSpan(
            text: "Trip",
            style: TextStyle(color: AppColors.primary),
          ),
          TextSpan(
            text: "Mate",
            style: TextStyle(color: AppColors.BurntBrown),
          ),
        ],
      ),
    );
  }
}
