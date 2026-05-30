import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AccountSecurityController extends GetxController {
  final box = GetStorage();

  late TextEditingController emailController;
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  var isOldPasswordVisible = false.obs;
  var isNewPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController(text: box.read('user_email') ?? "");
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void updateSecurity() {
    if (oldPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        "warning_title".tr, // ترجمة كلمة تنبيه
        "fill_all_fields_msg".tr, // ترجمة الرسالة
        backgroundColor: Color(0xFFD2775B),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar(
        "error_title".tr,
        "passwords_not_match_msg".tr,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    box.write('user_email', emailController.text);

    Get.snackbar(
      "updated_title".tr, // ترجمة تم التحديث
      "update_success_msg".tr, // ترجمة رسالة النجاح
      backgroundColor: const Color(0xFFD2775B),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    );

    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed('/login');
    });
  }

  void toggleOldPasswordVisibility() => isOldPasswordVisible.toggle();
  void toggleNewPasswordVisibility() => isNewPasswordVisible.toggle();
  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.toggle();

  @override
  void onClose() {
    emailController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
