import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/color/constants.dart';

class ButtonLogin extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ButtonLogin({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        elevation: 2,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
