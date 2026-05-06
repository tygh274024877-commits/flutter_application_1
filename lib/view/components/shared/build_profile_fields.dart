import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/userprofile_controller.dart';
import 'package:get/get.dart';
import 'TextField_login.dart'; // استدعاء ملف التكست فيلد الأساسي

class BuildProfileFields extends StatelessWidget {
  final UserProfileController controller;

  const BuildProfileFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldLogin(
          label: "full_name".tr,
          icon: Icons.person,
          controller: controller.nameController,
        ),
        const SizedBox(height: 15),
        TextFieldLogin(
          label: "email_addr".tr,
          icon: Icons.email,
          controller: controller.emailController,
        ),
        const SizedBox(height: 15),
        TextFieldLogin(
          label: "father_name".tr,
          icon: Icons.person_outline,
          controller: controller.fatherNameController,
        ),
        const SizedBox(height: 15),
        TextFieldLogin(
          label: "mother_name".tr,
          icon: Icons.person_2_outlined,
          controller: controller.motherNameController,
        ),
        const SizedBox(height: 15),
        TextFieldLogin(
          label: "id_passport".tr,
          icon: Icons.badge,
          controller: controller.idNumberController,
        ),
        const SizedBox(height: 15),
        TextFieldLogin(
          label: "phone_number".tr,
          icon: Icons.phone,
          controller: controller.phoneController,
        ),
      ],
    );
  }
}
