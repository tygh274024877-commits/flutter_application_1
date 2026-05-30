import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../../core/color/constants.dart';

class SupportHeaderTitle extends StatelessWidget {
  const SupportHeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 1000),
      child: FadeInAnimation(
        child: Text(
          "support_header".tr, // تعديل هنا
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),
      ),
    );
  }
}
