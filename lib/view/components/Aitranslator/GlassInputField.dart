import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/AiTransLator_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:get/get.dart';

class GlassInputField extends GetView<AiTranslatorController> {
  final String hint;
  final bool isResult;

  const GlassInputField({
    super.key,
    required this.hint,
    required this.isResult,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.glassWhite,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
      ),
      child: Obx(() {
        if (isResult) {
          return SingleChildScrollView(
            child: Text(
              controller.translatedText.value == "" ||
                      controller.translatedText.value == "الترجمة ستظهر هنا..."
                  ? hint
                  : controller.translatedText.value,
              style: const TextStyle(fontSize: 18, color: AppColors.BurntBrown),
            ),
          );
        } else {
          return TextField(
            maxLines: null,
            controller: TextEditingController.fromValue(
              TextEditingValue(
                text: controller.sourceText.value,
                selection: TextSelection.collapsed(
                  offset: controller.sourceText.value.length,
                ),
              ),
            ),
            onChanged: (val) => controller.sourceText.value = val,
            style: const TextStyle(fontSize: 18, color: AppColors.BurntBrown),
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              hintStyle: const TextStyle(color: AppColors.hintGrey),
            ),
          );
        }
      }),
    );
  }
}
