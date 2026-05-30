import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordController extends GetxController {
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  var isNewPasswordVisible = true.obs;
  var isConfirmPasswordVisible = true.obs;

  @override
  void onInit() {
    emailController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.onInit();
  }

  void toggleNewPassword() =>
      isNewPasswordVisible.value = !isNewPasswordVisible.value;
  void toggleConfirmPassword() =>
      isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;

  void resetPassword() {
    if (passwordFormKey.currentState!.validate()) {
      if (newPasswordController.text != confirmPasswordController.text) {
        Get.snackbar(
          "error".tr,
          "error_match".tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white.withOpacity(0.9),
          colorText: Colors.black,
          margin: const EdgeInsets.all(15),
          duration: const Duration(seconds: 3),
        );
        return;
      }
      Get.offAllNamed('/bottom');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
