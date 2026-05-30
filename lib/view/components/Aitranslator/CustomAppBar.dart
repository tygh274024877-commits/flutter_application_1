import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/AiTransLator_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:get/get.dart';

class CustomAppBar extends GetView<AiTranslatorController> {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.BurntBrown),
            onPressed: () => Get.back(),
          ),
          Text(
            "ai_translator_title".tr, // 👈 تم تحويل النص إلى مفتاح مترجم
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.BurntBrown,
            ),
          ),
          Obx(
            () => IconButton(
              icon: Icon(
                controller.isMuted.value ? Icons.volume_off : Icons.volume_up,
                color: AppColors.primary,
              ),
              onPressed: () =>
                  controller.isMuted.value = !controller.isMuted.value,
            ),
          ),
        ],
      ),
    );
  }
}
