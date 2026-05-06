import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

Widget goldBrackets({required bool isLeft}) {
  return Transform.rotate(
    angle: isLeft ? 0.8 : -0.8, // تدوير لليمين أو اليسار
    child: Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        // رسم خطين (Border) ليشكلوا الزاوية
        border: Border(
          top: BorderSide(color: AppColors.golden.withOpacity(0.6), width: 1.5),
          left: isLeft
              ? BorderSide.none
              : BorderSide(
                  color: AppColors.golden.withOpacity(0.6),
                  width: 1.5,
                ),
          right: isLeft
              ? BorderSide(color: AppColors.golden.withOpacity(0.6), width: 1.5)
              : BorderSide.none,
        ),
        // جعل الزاوية منحنية قليلاً لتشبه الصورة
        borderRadius: BorderRadius.only(
          topRight: isLeft ? Radius.circular(40) : Radius.zero,
          topLeft: isLeft ? Radius.zero : Radius.circular(40),
        ),
      ),
    ),
  );
}

Widget buildPositionedBracket({
  required double topPercent, // نسبة الارتفاع من الشاشة (مثلاً 0.2)
  required bool isLeft,
}) {
  // حساب الإزاحة الجانبية بناءً على عرض الشاشة من GetX
  // Get.width تغنيك عن MediaQuery
  double sideOffset = -(Get.width * 0.15);

  return Positioned(
    left: isLeft ? sideOffset : null,
    right: isLeft ? null : sideOffset,
    // Get.height تجلب ارتفاع الشاشة كاملاً
    top: Get.height * topPercent,
    child: goldBrackets(isLeft: isLeft),
  );
}
