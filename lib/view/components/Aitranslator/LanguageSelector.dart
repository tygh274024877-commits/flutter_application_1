import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/AiTransLator_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:get/get.dart';

class LanguageSelector extends GetView<AiTranslatorController> {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => Text(
            controller
                .sourceLang
                .value
                .tr, // 👈 ترجمة اسم اللغة القادمة من الكنترولر
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.BurntBrown,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.swap_horiz,
            color: AppColors.primary,
            size: 28,
          ),
          onPressed: () => controller.swapLanguages(),
        ),
        Obx(
          () => Text(
            controller
                .targetLang
                .value
                .tr, // 👈 ترجمة اسم اللغة القادمة من الكنترولر
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.BurntBrown,
            ),
          ),
        ),
      ],
    );
  }
}
