import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:flutter_application_1/core/theme/app_shadows.dart';
import 'package:get/get.dart'; // 👈 إضافة الـ import لتفعيل الـ .tr

class FeedbackInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  static const Color customOrange = Color(0xFFD2775B);
  static const Color earthyBrown = Color(0xFF795548);

  const FeedbackInputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppShadows.neumorphicShadow,
        ),
        child: TextField(
          controller: controller,
          style: const TextStyle(color: earthyBrown),
          decoration: InputDecoration(
            hintText: "شاركنا تجربتك في TripMate...".tr, // 👈 إضافة الترجمة هنا
            hintStyle: TextStyle(color: earthyBrown.withOpacity(0.6)),
            contentPadding: const EdgeInsets.all(20),
            suffixIcon: IconButton(
              icon: const Icon(Icons.send_rounded, color: AppColors.primary),
              onPressed: onSend,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
