import 'package:get/get.dart';

class AssistantController extends GetxController {

  var status = "أنا مساعدك الذكي، كيف يمكنني مساعدتك؟".obs;

  void askAI() {
    status.value = "جاري التفكير في إجابة...";
  }
}
