import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/color/constants.dart';

class AppShadows {
  // دمجنا الثابت الذهبي الفخم هنا ليكون متاحاً لكل الكروت في التطبيق
  static const Color golden = Color(0xFFC5A358);

  static List<BoxShadow> neumorphicShadow = [
    BoxShadow(
      color: AppColors.background.withOpacity(0.5),
      blurRadius: 3,
      spreadRadius: 1,
      offset: const Offset(2, 0),
    ),
    BoxShadow(
      color: AppColors.BurntBrown.withOpacity(0.2),
      offset: const Offset(-2.5, 1),
      blurRadius: 1,
      spreadRadius: 1,
    ),
    BoxShadow(
      color: AppColors.BurntBrown.withOpacity(0.2),
      offset: const Offset(-7, 3),
      blurRadius: 10,
      spreadRadius: 3,
    ),
  ];
}
