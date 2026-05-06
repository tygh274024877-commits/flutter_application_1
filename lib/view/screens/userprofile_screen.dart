import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/view/components/shared/waveheader.dart';
import '../../controller/userprofile_controller.dart';
import '../../controller/profile_controller.dart';
import '../../core/color/constants.dart';
import '../components/shared/button_login.dart';
import '../components/shared/build_profile_fields.dart'; // استدعاء الملف الجديد

class UserProfileScreen extends GetView<UserProfileController> {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mainProfileController = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                const WaveHeader(),
                Positioned(
                  top: 50,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      mainProfileController.refreshData();
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: const Offset(0, -45),
              child: Obx(
                () => _buildAvatarWithDelete(context, mainProfileController),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  // هنا الاستدعاء السحري الذي طلبته مروة
                  BuildProfileFields(controller: controller),

                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonLogin(
                      text: "save_changes".tr,
                      onPressed: () => controller.saveProfile(),
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

  // تابع بناء الأفاتار (الذي يحتوي على الذهبي وحذف الصورة)
  Widget _buildAvatarWithDelete(
    BuildContext context,
    ProfileController mainController,
  ) {
    final imagePath = mainController.profileImagePath.value;
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () => _showOptions(context, mainController),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.golden,
                  AppColors.lightGolden,
                  AppColors.golden,
                ],
              ),
            ),
            child: Container(
              width: 110,
              height: 110,
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
                        child: const Icon(Icons.person, size: 75),
                      )
                    : Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                        key: ValueKey(imagePath),
                      ),
              ),
            ),
          ),
        ),
        if (imagePath.isNotEmpty)
          Positioned(
            right: 0,
            bottom: 5,
            child: GestureDetector(
              onTap: () => controller.deleteProfileImage(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 233, 230, 230),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.delete_rounded,
                  color: AppColors.background,
                  size: 22,
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _showOptions(BuildContext context, ProfileController mainController) {
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
              leading: const Icon(Icons.camera_alt, color: Color(0xFFD2775B)),
              title: Text("camera".tr),
              onTap: () {
                Get.back();
                mainController.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: Color(0xFFD2775B),
              ),
              title: Text("gallery".tr),
              onTap: () {
                Get.back();
                mainController.pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
