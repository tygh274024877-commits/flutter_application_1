import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/feedback/comment_model.dart';
import 'package:flutter_application_1/models/feedback/feedback_data_source.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FeedbackController extends GetxController {
  final TextEditingController commentController = TextEditingController();
  final _storage = GetStorage();

  // القائمة تستقبل كائنات CommentModel
  var comments = <CommentModel>[
    CommentModel(
      userName: "Ghazal",
      commentText: "default_comment_1".tr,
      rating: 5,
    ),
    CommentModel(
      userName: "Marwa",
      commentText: "default_comment_2".tr,
      rating: 4,
    ),
  ].obs;

  var hasCommented = false.obs;
  var isLoading =
      false.obs; // 💡 متغير التحميل لإعطاء طابع حقيقي واحترافي للمشروع

  static const Color customOrange = Color(0xFFD2775B);
  static const Color earthyBrown = Color(0xFF795548);

  @override
  void onInit() {
    super.onInit();
    hasCommented.value = _storage.read('has_commented') ?? false;
  }

  // 💡 الدالة المدموجة باحترافية لتتصل بالـ Data Source الـ Static (نوع الطلب POST)
  void handleSendComment(
    BuildContext context,
    int rating,
    String userName,
  ) async {
    if (commentController.text.trim().isNotEmpty) {
      try {
        isLoading.value = true; // تشغيل مؤشر التحميل

        // 1. وضع البيانات في قالب الموديل تبعكِ
        CommentModel newComment = CommentModel(
          userName: userName,
          commentText: commentController.text.trim(),
          rating: rating,
        );

        // 2. إرسال الكائن فوراً للدالة الـ Static في الداتا سورس
        bool isSuccess = await FeedbackDataSource.sendCommentToServer(
          newComment,
        );

        if (isSuccess) {
          // 3. إذا رجع نجاح (وهو رح يرجع نجاح وهمي هلق)، منضيف الكرت للشاشة فوراً
          comments.insert(0, newComment);

          commentController.clear();
          FocusScope.of(context).unfocus();

          _storage.write('has_commented', true);
          hasCommented.value = true;

          // إشعار النجاح اللطيف والأصلي تبعكِ 🎉
          Get.snackbar(
            "${"comment_success_title".tr} ",
            "${"comment_success_msg".tr} ",
            snackPosition: SnackPosition.TOP,
            backgroundColor: customOrange.withOpacity(0.9),
            colorText: Colors.white,
            margin: const EdgeInsets.all(15),
            borderRadius: 15,
            duration: const Duration(seconds: 3),
            icon: const Icon(Icons.favorite_rounded, color: Colors.white),
          );
        }
      } catch (e) {
        // إشعار خطأ احتياطي في حال حدوث أي مشكلة بالسيرفر مستقبلاً
        Get.snackbar(
          "خطأ".tr,
          "تعذر إرسال التعليق، يرجى المحاولة لاحقاً".tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false; // إيقاف مؤشر التحميل دائماً بالنهاية
      }
    }
  }

  void deleteComment(int index) {
    Get.defaultDialog(
      title: "delete_comment_title".tr,
      titleStyle: const TextStyle(
        color: earthyBrown,
        fontWeight: FontWeight.bold,
      ),
      middleText: "delete_comment_confirm".tr,
      middleTextStyle: const TextStyle(color: earthyBrown),
      textConfirm: "delete_btn".tr,
      textCancel: "cancel".tr,
      cancelTextColor: earthyBrown,
      confirmTextColor: Colors.white,
      buttonColor: customOrange,
      onConfirm: () {
        comments.removeAt(index);
        Get.back();
      },
    );
  }

  void editComment(int index) {
    commentController.text = comments[index].commentText; // تعديل النص فقط
    Get.defaultDialog(
      title: "edit_comment_title".tr,
      titleStyle: const TextStyle(
        color: earthyBrown,
        fontWeight: FontWeight.bold,
      ),
      content: TextField(
        controller: commentController,
        style: const TextStyle(color: earthyBrown),
      ),
      textConfirm: "save_btn".tr,
      buttonColor: customOrange,
      confirmTextColor: Colors.white,
      onConfirm: () {
        // تحديث النص مع الحفاظ على الاسم والنجوم القديمة
        comments[index] = CommentModel(
          userName: comments[index].userName,
          commentText: commentController.text,
          rating: comments[index].rating,
        );
        commentController.clear();
        Get.back();
      },
    );
  }

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }
}
