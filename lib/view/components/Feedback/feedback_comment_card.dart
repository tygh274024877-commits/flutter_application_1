import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/feedback/comment_model.dart';
import 'package:get/get.dart';

class FeedbackCommentCard extends StatelessWidget {
  final CommentModel comment;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  static const Color customOrange = Color(0xFFD2775B);
  static const Color earthyBrown = Color(0xFF795548);

  const FeedbackCommentCard({
    super.key,
    required this.comment,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Get.bottomSheet(
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.edit, color: customOrange),
                  title: Text(
                    "تعديل".tr,
                    style: const TextStyle(
                      color: earthyBrown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    onEdit();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete, color: customOrange),
                  title: Text(
                    "حذف".tr,
                    style: const TextStyle(
                      color: earthyBrown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    onDelete();
                  },
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // السطر العلوي: يحتوي على اسم المستخدم والنجوم
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // 👈 تعديل الكلمة هنا لتصبح spaceBetween
              children: [
                Text(
                  comment.userName,
                  style: const TextStyle(
                    // 👈 تأكدي من إغلاق القوس في نهاية الخصائص
                    color: FeedbackCommentCard
                        .earthyBrown, // 👈 استدعاء اللون من الكلاس الخاص به
                  ), // 👈 قوس إغلاق الـ TextStyle
                ), // 👈 قوس إغلاق الـ Text      // توليد النجوم تلقائياً بناءً على تقييم المستخدم المخزن في الموديل
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < comment.rating
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      color: customOrange,
                      size: 18,
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // نص التعليق
            Text(
              comment.commentText,
              style: TextStyle(
                color: earthyBrown.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
