import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/color/constants.dart';

class SubmitComplaintButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SubmitComplaintButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.send_rounded, color: Colors.white),
        label: Text(
          "send_complaint".tr, // تعديل هنا
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 2,
        ),
      ),
    );
  }
}
