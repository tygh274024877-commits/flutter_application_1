import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/components/shared/custom_widgets.dart';
import 'package:get/get.dart';
import '../../controller/password_controller.dart';
import '../../core/color/constants.dart';
import '../components/shared/TextField_login.dart';
import '../components/shared/button_login.dart';

class PasswordScreen extends GetView<PasswordController> {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: controller.passwordFormKey,
              child: Column(
                children: [
                  const TopHeaderActions(),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "Trip",
                          style: TextStyle(color: Color(0xFFD2775B)),
                        ),
                        TextSpan(
                          text: "Mate",
                          style: TextStyle(color: Color(0xFF65554E)),
                        ),
                      ],
                    ),
                  ),
                  Image.asset('assets/images/password.png', height: 170),
                  Text(
                    "reset_title".tr,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFieldLogin(
                    label: "email".tr,
                    icon: Icons.email_outlined,
                    controller: controller.emailController,
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => TextFieldLogin(
                      label: "new_pass".tr,
                      icon: Icons.lock_outline,
                      isPassword: true,
                      obscureText: controller.isNewPasswordVisible.value,
                      controller: controller.newPasswordController,
                      onIconTap: () => controller.toggleNewPassword(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => TextFieldLogin(
                      label: "confirm_pass".tr,
                      icon: Icons.lock_reset,
                      isPassword: true,
                      obscureText: controller.isConfirmPasswordVisible.value,
                      controller: controller.confirmPasswordController,
                      onIconTap: () => controller.toggleConfirmPassword(),
                    ),
                  ),
                  const SizedBox(height: 35),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonLogin(
                      text: "done_btn".tr,
                      onPressed: () => controller.resetPassword(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
