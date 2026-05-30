import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/account_security_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:flutter_application_1/view/components/shared/golden_widgets.dart';
import 'package:flutter_application_1/view/components/shared/waveheader.dart';
import 'package:get/get.dart';

import '../components/shared/TextField_login.dart';
import '../components/shared/button_login.dart';

class AccountSecurityView extends GetView<AccountSecurityController> {
  const AccountSecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                const WaveHeader(),
                Positioned(
                  top: 50,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black87,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),
                Positioned(
                  bottom: -45,
                  left: 0,
                  right: 0,
                  child: Center(child: _buildSecurityHeader()),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Text(
                    "security_settings".tr,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFieldLogin(
                    label: "email_address".tr,
                    icon: Icons.email,
                    controller: controller.emailController,
                  ),
                  const SizedBox(height: 15),
                  TextFieldLogin(
                    label: "old_password".tr,
                    icon: Icons.lock_outline,
                    controller: controller.oldPasswordController,
                  ),
                  const SizedBox(height: 15),
                  TextFieldLogin(
                    label: "new_password".tr,
                    icon: Icons.vpn_key_rounded,
                    controller: controller.newPasswordController,
                  ),
                  const SizedBox(height: 15),
                  TextFieldLogin(
                    label: "confirm_new_password".tr,
                    icon: Icons.check_circle_outline,
                    controller: controller.confirmPasswordController,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonLogin(
                      text: "confirm_update".tr,
                      onPressed: () => controller.updateSecurity(),
                    ),
                  ),

                  // --- إضافة الروابط في الأسفل ---
                  const SizedBox(height: 20),

                  // 1. رابط هل نسيت كلمة السر؟
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Get.toNamed('/password'),
                      child: Text(
                        "did_you_forget_password".tr,
                        style: const TextStyle(
                          color: AppColors.golden,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 2. رابط إنشاء حساب جديد
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Get.toNamed('/signup'),
                      child: Text(
                        "create_new_account".tr,
                        style: const TextStyle(
                          color: AppColors.golden,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityHeader() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [AppColors.golden, AppColors.lightGolden, AppColors.golden],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
          shape: BoxShape.circle,
        ),
        child: const GoldenGradientWrapper(
          child: Icon(Icons.shield_outlined, size: 50, color: Colors.white),
        ),
      ),
    );
  }
}
