import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/color/constants.dart';

class AppShadows {
  static List<BoxShadow> neumorphicShadow = [
    BoxShadow(
      color: AppColors.background.withOpacity(0.5),
      blurRadius: 3,
      spreadRadius: 1,
      offset: Offset(2, 0),
    ),
    BoxShadow(
      color: AppColors.BurntBrown.withOpacity(0.2),
      offset: Offset(-2.5, 1),
      blurRadius: 1,
      spreadRadius: 1,
    ),
    BoxShadow(
      color: AppColors.BurntBrown.withOpacity(0.2),
      offset: Offset(-7, 3),
      blurRadius: 10,
      spreadRadius: 3,
    ),
  ];
}
