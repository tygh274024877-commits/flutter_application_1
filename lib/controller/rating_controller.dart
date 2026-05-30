import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'rating_dialog_component.dart';
import 'feedback_controller.dart'; // 👈 استيراد الـ FeedbackController للربط

class RatingController extends GetxController {
  var selectedRating = 0.obs;
  var animatedStarIndex = (-1).obs;

  static const Color customOrange = Color(0xFFD2775B);
  static const Color earthyBrown = Color(0xFF795548);

  // دالة تشغيل وإظهار النافذة المنفصلة تلقائياً
  void showRatingDialog(BuildContext context) {
    selectedRating.value = 0;
    animatedStarIndex.value = -1;

    Get.dialog(
      RatingDialogComponent(controller: this),
      barrierDismissible: false,
    );
  }

  // دالة معالجة الأنميشن والضغط على النجمة
  void handleStarTap(int index, int starValue) async {
    selectedRating.value = starValue;
    animatedStarIndex.value = index;
    await Future.delayed(const Duration(milliseconds: 250));
    animatedStarIndex.value = -1;
  }

  // دالة تأكيد التقييم وربطه بالتعليق ليكون جاهزاً للـ API
  void submitRating(BuildContext context) {
    if (selectedRating.value == 0) {
      Get.snackbar(
        "warning_title".tr,
        "select_stars_warning".tr,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    Get.back(); // إغلاق نافذة الدايلوج

    // 💡 الربط الذكي: بنجيب الـ FeedbackController وبنخليه يحتفظ بالنجوم أو يرسلها فوراً
    final FeedbackController feedbackController =
        Get.find<FeedbackController>();

    // هنا نمرر السياق، والنجوم المحددة، واسم المستخدم (مؤقتاً اسمكِ Ghazal حتى تجهيز السيرفر)
    feedbackController.handleSendComment(
      context,
      selectedRating.value,
      "Ghazal",
    );

    // إرسال الإشعار المخصص مع الإيموجيات الأصلية الخاصة بكِ بناءً على النجوم
    if (selectedRating.value >= 4) {
      Get.snackbar(
        "${"rating_success_high_title".tr} ",
        "${"rating_success_high_msg".tr} 🥰",
        snackPosition: SnackPosition.TOP,
        backgroundColor: customOrange.withOpacity(0.9),
        colorText: Colors.white,
        icon: const Icon(Icons.star_rounded, color: Colors.white),
      );
    } else {
      Get.snackbar(
        "${"rating_success_low_title".tr} 🥺",
        "${"rating_success_low_msg".tr} ❤️",
        snackPosition: SnackPosition.TOP,
        backgroundColor: earthyBrown.withOpacity(0.9),
        colorText: Colors.white,
        icon: const Icon(Icons.star_half_rounded, color: Colors.white),
      );
    }
  }
}
