import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/feedback_controller.dart';
import 'package:flutter_application_1/controller/rating_controller.dart'; // 👈 استيراد كنترولر التقييم الجديد
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:flutter_application_1/view/components/Feedback/feedback_field.dart';
import 'package:flutter_application_1/view/components/support_screen/animated_writing_icon.dart';
import 'package:flutter_application_1/view/components/Feedback/feedback_comment_card.dart';
import 'package:get/get.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // حقن الكنترولرات واستدعائها داخل الصفحة
    final FeedbackController controller = Get.put(FeedbackController());
    final RatingController ratingController = Get.put(
      RatingController(),
    ); // 👈 حقن الـ RatingController هنا

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "آراء المستخدمين".tr,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const StrongAnimatedWritingIcon(),
          const SizedBox(height: 10),

          // حقل الإدخال مربوط بالكنترولر
          FeedbackInputField(
            controller: controller.commentController,
            onSend: () {
              // 💡 الحل هنا: عند الضغط على السهم نتحقق إذا الحقل ليس فارغاً ثم نفتح دايلوج النجوم
              if (controller.commentController.text.trim().isNotEmpty) {
                ratingController.showRatingDialog(context);
              } else {
                Get.snackbar(
                  "تنبيه".tr,
                  "شاركنا تجربتك في TripMate...".tr,
                  backgroundColor: AppColors.primary.withOpacity(0.8),
                  colorText: Colors.white,
                );
              }
            },
          ),

          // قائمة التعليقات محاطة بـ Obx لتحديث الشاشة فوراً عند أي تغيير
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                itemCount: controller.comments.length,
                itemBuilder: (context, index) {
                  return FeedbackCommentCard(
                    comment: controller.comments[index],
                    onEdit: () => controller.editComment(index),
                    onDelete: () => controller.deleteComment(index),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
