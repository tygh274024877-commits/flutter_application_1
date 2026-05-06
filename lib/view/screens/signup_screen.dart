import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/signup_controller.dart';
import '../../core/color/constants.dart';
import '../components/shared/TextField_login.dart';
import '../components/shared/button_login.dart';
import '../components/shared/custom_widgets.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: controller.signupFormKey,
              child: Column(
                children: [
                  const TopHeaderActions(),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "Trip",
                          style: TextStyle(color: Color(0xFFD2775B)),
                        ),
                        TextSpan(
                          text: "Mate",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Image.asset("assets/images/signup.png", height: 130),
                  Text(
                    "create_acc".tr,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "join_us".tr,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  TextFieldLogin(
                    label: "full_name".tr,
                    icon: Icons.person_outline,
                    controller: controller.fullNameController,
                  ),
                  const SizedBox(height: 15),
                  TextFieldLogin(
                    label: "email".tr,
                    icon: Icons.email_outlined,
                    controller: controller.emailController,
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => TextFieldLogin(
                      label: "pass".tr,
                      icon: Icons.lock_outline,
                      isPassword: true,
                      obscureText: controller.isPasswordVisible.value,
                      controller: controller.passwordController,
                      onIconTap: () => controller.togglePassword(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => TextFieldLogin(
                      label: "confirm_pass".tr,
                      icon: Icons.lock_reset,
                      isPassword: true,
                      obscureText: controller.isConfirmVisible.value,
                      controller: controller.confirmPasswordController,
                      onIconTap: () => controller.toggleConfirm(),
                    ),
                  ),
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.agreeToTerms.value,
                          activeColor: const Color(0xFFD2775B),
                          onChanged: (val) =>
                              controller.agreeToTerms.value = val!,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "terms".tr,
                          style: const TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonLogin(
                      text: "signup_btn".tr,
                      onPressed: () => controller.signUp(),
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
