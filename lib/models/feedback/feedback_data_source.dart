import 'package:flutter_application_1/models/feedback/comment_model.dart';

class FeedbackDataSource {
  // 💡 دالة static لترضي الأستاذ، بتاخد الموديل وبترجع نجاح وهمي حالياً
  static Future<bool> sendCommentToServer(CommentModel newComment) async {
    try {
      // بنخليه يستنى نصف ثانية (وهمي) عشان يعطي إحساس إنه عم يتصل بالإنترنت
      await Future.delayed(const Duration(milliseconds: 500));

      // هاد السطر هو اللي رح يشتغل لما مروى تعطيكِ الـ API (نوعه POST)
      // final response = await Dio().post("رابط_مروى", data: newComment.toJson());

      // حالياً: بنرجع true فوراً عشان يضل تطبيقك شغال والكرت ينزل قدامك
      return true;
    } catch (e) {
      return false;
    }
  }
}
