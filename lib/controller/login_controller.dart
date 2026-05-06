import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controller/userprofile_controller.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = true.obs;

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() {
    if (loginFormKey.currentState!.validate()) {
      final box = GetStorage();

      box.write('user_email', emailController.text.trim());

      // 2. تمرير الإيميل لكنترولر البروفايل لضمان المزامنة الفورية
      if (Get.isRegistered<UserProfileController>()) {
        Get.find<UserProfileController>().emailController.text = emailController
            .text
            .trim();
      }

      // الانتقال للواجهة الرئيسية ومسح صفحات اللوكن من الذاكرة
      Get.offAllNamed('/bottom');
    } else {
      print("Validation Failed");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
