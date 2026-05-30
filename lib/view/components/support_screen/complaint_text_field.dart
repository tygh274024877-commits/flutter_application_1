import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/color/constants.dart';

class ComplaintTextField extends StatelessWidget {
  final TextEditingController controller;
  const ComplaintTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: 6,
        style: const TextStyle(color: AppColors.darkBrown),
        decoration: InputDecoration(
          hintText: "complaint_hint".tr, // تعديل هنا
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
