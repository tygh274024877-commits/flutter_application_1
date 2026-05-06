import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'profile_controller.dart'; // تأكدي من صحة المسار

class UserProfileController extends GetxController {
  final box = GetStorage();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController fatherNameController;
  late TextEditingController motherNameController;
  late TextEditingController idNumberController;
  late TextEditingController phoneController;

  @override
  void onInit() {
    super.onInit();
    // قراءة البيانات المحفوظة مسبقاً أو وضع قيم افتراضية
    nameController = TextEditingController(
      text: box.read('user_name') ?? "Ghazal",
    );
    emailController = TextEditingController(text: box.read('user_email') ?? "");
    fatherNameController = TextEditingController(
      text: box.read('father_name') ?? "",
    );
    motherNameController = TextEditingController(
      text: box.read('mother_name') ?? "",
    );
    idNumberController = TextEditingController(
      text: box.read('id_number') ?? "",
    );
    phoneController = TextEditingController(
      text: box.read('phone_number') ?? "",
    );
  }

  void saveProfile() {
    // 1. التحقق من أن جميع الحقول ممتلئة
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        fatherNameController.text.trim().isEmpty ||
        motherNameController.text.trim().isEmpty ||
        idNumberController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty) {
      Get.snackbar(
        "warning".tr,
        "fill_all_fields".tr,
        backgroundColor: const Color(0xFFD2775B), // لونك البرتقالي المميز
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // 2. حفظ البيانات في التخزين المحلي وفي الكنترولر الأساسي
    _saveAllData();

    // 3. إظهار رسالة نجاح مترجمة
    Get.snackbar(
      "success".tr,
      "update_success".tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFD2775B),
      colorText: Colors.white,
    );
  }

  void deleteProfileImage() {
    if (Get.isRegistered<ProfileController>()) {
      Get.find<ProfileController>().deleteImage();
    }
  }

  void _saveAllData() {
    // حفظ في GetStorage ليبقى الاسم محفوظاً حتى بعد إغلاق التطبيق
    box.write('user_name', nameController.text);
    box.write('user_email', emailController.text);
    box.write('father_name', fatherNameController.text);
    box.write('mother_name', motherNameController.text);
    box.write('id_number', idNumberController.text);
    box.write('phone_number', phoneController.text);

    // تحديث ProfileController فوراً لتغيير الاسم في الـ MenuScreen
    if (Get.isRegistered<ProfileController>()) {
      final profileCtrl = Get.find<ProfileController>();
      profileCtrl.userName.value = nameController.text; // تحديث الـ Observable
      profileCtrl.update(); // إشعار المستمعين
    }
  }

  @override
  void onClose() {
    // التخلص من الكنترولرات لتحرير الذاكرة
    nameController.dispose();
    emailController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    idNumberController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
