import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  var isPasswordVisible = true.obs;
  var isConfirmVisible = true.obs;
  var agreeToTerms = false.obs;

  @override
  void onInit() {
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.onInit();
  }

  void togglePassword() => isPasswordVisible.value = !isPasswordVisible.value;
  void toggleConfirm() => isConfirmVisible.value = !isConfirmVisible.value;

  void signUp() {
    if (signupFormKey.currentState!.validate()) {
      // 1. ترجمة تنبيه الموافقة على الشروط
      if (!agreeToTerms.value) {
        Get.snackbar(
          "warning".tr,
          "accept_terms_msg".tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return;
      }

      // 2. ترجمة تنبيه تطابق كلمات المرور
      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar(
          "error".tr,
          "error_match".tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white.withOpacity(0.9),
          colorText: Colors.black,
        );
        return;
      }
      Get.offAllNamed('/home');
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
