import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/core/class/statusrequest.dart';
import 'package:flutter_application_1/models/signup_data.dart';
import 'package:flutter_application_1/controller/userprofile_controller.dart';

class SignupController extends GetxController {
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  SignupData signupData = SignupData(crud: Get.find());

  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  var isPasswordVisible = true.obs;
  var isConfirmVisible = true.obs;
  var agreeToTerms = false.obs;

  @override
  void onInit() {
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.onInit();
  }

  // --- دوال التحقق (Validator) ---

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return "الاسم مطلوب";
    if (RegExp(r'[^a-zA-Z\u0600-\u06FF\s]').hasMatch(value)) {
      return "لا يسمح باستخدام رموز أو شخطات";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "البريد الإلكتروني مطلوب";
    if (value.contains(' ')) return "لا يسمح بوجود مسافات في الإيميل";
    if (!GetUtils.isEmail(value)) return "صيغة البريد الإلكتروني غير صحيحة";
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return "رقم الهاتف مطلوب";
    if (value.length < 10) return "يجب ألا يقل عن 10 أرقام";
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "كلمة السر مطلوبة";
    if (value.length < 8) return "يجب ألا تقل عن 8 خانات";
    bool hasSymbol = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
    if (!hasSymbol) return "يجب أن تحتوي على رمز خاص (مثال: @, #, \$)";
    return null;
  }

  // --------------------------------

  void togglePassword() => isPasswordVisible.value = !isPasswordVisible.value;
  void toggleConfirm() => isConfirmVisible.value = !isConfirmVisible.value;

  signUp() async {
    // 1. التحقق من الحقول
    if (!signupFormKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("خطأ", "كلمات السر غير متطابقة");
      return;
    }

    if (!agreeToTerms.value) {
      Get.snackbar("تنبيه", "يجب الموافقة على الشروط");
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    // 2. إرسال البيانات للسيرفر
    var response = await signupData.postdata(
      fullNameController.text.trim(),
      emailController.text.trim(),
      passwordController.text,
      confirmPasswordController.text,
      phoneController.text.trim(),
    );

    print("SERVER RESPONSE: $response");

    // 3. معالجة الرد
    if (response != null &&
        response is Map &&
        response.containsKey('message')) {
      statusRequest = StatusRequest.success;

      if (Get.isRegistered<UserProfileController>()) {
        final profileCtrl = Get.find<UserProfileController>();
        profileCtrl.nameController.text = fullNameController.text.trim();
        profileCtrl.emailController.text = emailController.text.trim();
        profileCtrl.phoneController.text = phoneController.text.trim();
        profileCtrl.saveProfile();
      }

      Get.offAllNamed('/bottom');
    } else {
      statusRequest = StatusRequest.failure;
      String errorMessage = response.toString();

      if (errorMessage.contains("already registered")) {
        Get.snackbar(
          "تنبيه",
          "هذا الحساب موجود بالفعل، يرجى تسجيل الدخول",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "خطأ",
          "فشل التسجيل، يرجى المحاولة لاحقاً",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
    update();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
