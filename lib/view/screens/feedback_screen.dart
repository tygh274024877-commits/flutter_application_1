import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/feedback_controller.dart';
import 'package:flutter_application_1/controller/rating_controller.dart';
import 'package:flutter_application_1/view/components/Feedback/feedback_field.dart';
import 'package:get/get.dart';
import '../../core/color/constants.dart';
import '../components/support_screen/animated_writing_icon.dart';
import '../components/Feedback/feedback_comment_card.dart';

class FeedbackScreen extends GetView<FeedbackController> {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // حقن واستدعاء الـ RatingController ليكون جاهزاً في الصفحة
    final RatingController ratingController = Get.put(RatingController());

    // هذا الجزء لفتح الدايلوج تلقائياً أول ما تفتح الصفحة (إذا رغبتِ بذلك بناءً على الشرط المخزن)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.hasCommented.value) {
        ratingController.showRatingDialog(context);
      }
    });

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

          // 💡 الدمج والتعديل هنا في حقل الإدخال وزر الإرسال
          FeedbackInputField(
            controller: controller.commentController,
            onSend: () {
              if (controller.commentController.text.isNotEmpty) {
                // 1. عند الضغط على السهم، يفتح دايلوج النجوم ليختار المستخدم تقييمه أولاً
                ratingController.showRatingDialog(context);
              } else {
                // إشعار سريع إذا حاول الإرسال والحقل فارغ
                Get.snackbar(
                  "تنبيه".tr,
                  "شاركنا تجربتك في TripMate...".tr,
                  backgroundColor: AppColors.primary.withOpacity(0.8),
                  colorText: Colors.white,
                );
              }
            },
          ),

          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
                itemCount: controller.comments.length,
                itemBuilder: (context, index) {
                  // 💡 التعديل هنا: نمرر غرض الـ CommentModel بالكامل للـ Card ليقوم برسم الاسم والنجوم
                  return FeedbackCommentCard(
                    comment: controller
                        .comments[index], // أصبح يمرر الـ Object المدموج
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
