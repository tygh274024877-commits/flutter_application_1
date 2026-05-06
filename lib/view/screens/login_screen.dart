import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/components/login_screen.dart/login_screen_widgets.dart';

import 'package:flutter_application_1/view/components/shared/TextField_login.dart';
import 'package:flutter_application_1/view/components/shared/button_login.dart';
import 'package:flutter_application_1/view/components/shared/custom_widgets.dart';

import 'package:get/get.dart';
import '../../controller/login_controller.dart';
import '../../core/color/constants.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          buildPositionedBracket(isLeft: true, topPercent: 0.24),
          buildPositionedBracket(isLeft: true, topPercent: 0.27),

          // الزخرفة اليمنى
          buildPositionedBracket(isLeft: false, topPercent: 0.24),
          buildPositionedBracket(isLeft: false, topPercent: 0.27),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: controller.loginFormKey,
                  child: Column(
                    children: [
                      const TopHeaderActions(),
                      const SizedBox(height: 20),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
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
                      const SizedBox(height: 25),
                      Image.asset('assets/images/login.png', height: 150),
                      const SizedBox(height: 25),
                      Text(
                        "welcome".tr,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "login_sub".tr,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFieldLogin(
                        label: "email".tr,
                        icon: Icons.email_outlined,
                        controller: controller.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "email_empty".tr;
                          }
                          return null;
                        },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "pass_empty".tr;
                            }
                            return null;
                          },
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Get.toNamed('/password'),
                          child: Text(
                            "forgot".tr,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ButtonLogin(
                          text: "login_btn".tr,
                          onPressed: () => controller.login(),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("signup_prompt".tr),
                          TextButton(
                            onPressed: () => Get.toNamed('/signup'),
                            child: Text(
                              "signup_link".tr,
                              style: const TextStyle(
                                color: Color(0xFFD2775B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
