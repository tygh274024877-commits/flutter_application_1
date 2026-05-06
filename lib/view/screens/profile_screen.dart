import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/view/components/shared/waveheader.dart';
import '../../controller/profile_controller.dart';
import '../../core/color/constants.dart';
import '../../core/theme/app_shadows.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                const WaveHeader(),
                Positioned(
                  bottom: -60,
                  child: Obx(() => _buildProfileImage(context)),
                ),
              ],
            ),
            const SizedBox(height: 75),
            Obx(
              () => GestureDetector(
                onTap: () => _showEditNameDialog(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.userName.value,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.edit, size: 18, color: Colors.grey),
                  ],
                ),
              ),
            ),
            Text(
              "welcome_user".tr,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                letterSpacing: 1.2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _sectionHeader("acc_details"),
                  const SizedBox(height: 15),
                  _menuCard([
                    _menuItem(
                      Icons.person_outline,
                      "profile_info".tr,
                      AppColors.primary,
                      () => Get.toNamed('/user_profile'),
                    ),
                    _menuItem(
                      Icons.security_outlined,
                      "acc_security".tr,
                      AppColors.primary,
                      () => Get.toNamed('/security'),
                    ),
                    _menuItem(
                      Icons.notifications_none_outlined,
                      "notifications".tr,
                      AppColors.primary,
                      () {},
                    ),
                  ]),
                  const SizedBox(height: 25),
                  _sectionHeader("settings_support"),
                  const SizedBox(height: 15),
                  _menuCard([
                    _menuItem(
                      Icons.payment_outlined,
                      "payment".tr,
                      AppColors.primary,
                      () {},
                    ),
                    _menuItem(
                      Icons.help_outline,
                      "help".tr,
                      AppColors.primary,
                      () {},
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    final imagePath = controller.profileImagePath.value;
    return GestureDetector(
      onTap: () => _showImageSourceOptions(context),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [AppColors.golden, AppColors.lightGolden, AppColors.golden],
          ),
        ),
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.background,
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: imagePath.isEmpty
                ? ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        AppColors.golden,
                        AppColors.lightGolden,
                        AppColors.golden,
                      ],
                    ).createShader(bounds),
                    blendMode: BlendMode.srcIn,
                    child: const Icon(Icons.person, size: 85),
                  )
                : Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                    key: ValueKey(imagePath),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _menuItem(
    IconData icon,
    String title,
    Color iconColor,
    VoidCallback onTap,
  ) => ListTile(
    onTap: onTap,
    leading: Icon(icon, color: iconColor),
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    ),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
  );

  Widget _sectionHeader(String titleKey) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Text(
      titleKey.tr,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF444444),
      ),
    ),
  );

  Widget _menuCard(List<Widget> children) => Container(
    decoration: BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(25),
      boxShadow: AppShadows.neumorphicShadow,
    ),
    child: Column(children: children),
  );

  void _showImageSourceOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "change_photo".tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.primary),
              title: Text("camera".tr),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: AppColors.primary,
              ),
              title: Text("gallery".tr),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditNameDialog(BuildContext context) {
    String tempName = controller.userName.value;
    Get.defaultDialog(
      title: "edit_name".tr,
      backgroundColor: AppColors.background,
      content: TextField(
        onChanged: (value) => tempName = value,
        decoration: InputDecoration(hintText: "enter_name".tr),
      ),
      textConfirm: "save".tr,
      confirmTextColor: Colors.white,
      buttonColor: AppColors.primary,
      onConfirm: () {
        if (tempName.trim().isNotEmpty) controller.updateName(tempName);
        Get.back();
      },
    );
  }
}
