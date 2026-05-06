import 'package:flutter_application_1/core/animations/splashAnimations.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late SplashAnimations anims;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();

    // إعداد وقت الأنميشن
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );

    // ربط ملف الأنميشن
    anims = SplashAnimations(animationController);

    // بدء الحركة
    animationController.forward();

    // تحديث الواجهة عند كل حركة
    animationController.addListener(() => update());

    // فحص الحالة والانتقال بعد انتهاء الأنميشن
    Future.delayed(const Duration(seconds: 7), () {
      checkLoginStatus();
    });
  }

  void checkLoginStatus() {
    // قراءة القيمة المخزنة (نور خزنتها في GetStorage)
    bool isLoggedIn = storage.read("isLoggedIn") ?? false;

    if (isLoggedIn) {
      // ✅ إذا كان مسجل دخول، نذهب للغلاف الأساسي (الذي يحتوي على الـ BottomBar والـ Drawer)
      Get.offAllNamed('/bottom');
    } else {
      // ✅ إذا لم يكن مسجلاً، نذهب لصفحة الـ Login
      Get.offAllNamed('/login');
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
