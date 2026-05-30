import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'profile_controller.dart';

class UserProfileController extends GetxController {
  final box = GetStorage();

  // تعريف الكنترولرات
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController fatherNameController;
  late TextEditingController motherNameController;
  late TextEditingController idNumberController;
  late TextEditingController phoneController;

  @override
  void onInit() {
    super.onInit();
    // جلب البيانات من الذاكرة أو تعيين قيمة افتراضية
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

  // الدالة الأساسية لحفظ البروفايل
  void saveProfile() {
    // 1. التحقق من أن جميع الحقول ممتلئة (شرطكِ)
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        fatherNameController.text.trim().isEmpty ||
        motherNameController.text.trim().isEmpty ||
        idNumberController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty) {
      Get.snackbar(
        "warning".tr,
        "fill_all_fields".tr,
        backgroundColor: const Color(0xFFD2775B), // البرتقالي المعتمد
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // 2. تنفيذ عملية الحفظ
    _saveAllData();

    // 3. إظهار رسالة النجاح
    Get.snackbar(
      "success".tr,
      "update_success".tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFD2775B),
      colorText: Colors.white,
    );
  }

  // دالة الحفظ الفعلية
  void _saveAllData() {
    box.write('user_name', nameController.text);
    box.write('user_email', emailController.text);
    box.write('father_name', fatherNameController.text);
    box.write('mother_name', motherNameController.text);
    box.write('id_number', idNumberController.text);
    box.write('phone_number', phoneController.text);

    // تحديث البيانات في الـ ProfileController ليظهر الاسم في القائمة الجانبية فوراً
    if (Get.isRegistered<ProfileController>()) {
      final profileCtrl = Get.find<ProfileController>();
      profileCtrl.userName.value = nameController.text;
      profileCtrl.update();
    }
  }

  // حذف صورة البروفايل
  void deleteProfileImage() {
    if (Get.isRegistered<ProfileController>()) {
      Get.find<ProfileController>().deleteImage();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    idNumberController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
