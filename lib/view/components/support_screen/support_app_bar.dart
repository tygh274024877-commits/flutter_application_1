import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/color/constants.dart';

class SupportAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SupportAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "help".tr, // تعديل هنا لقراءة المساعدة والدعم
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.primary,
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Get.back(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
