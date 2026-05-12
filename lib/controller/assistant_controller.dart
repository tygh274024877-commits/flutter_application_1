import 'package:get/get.dart';

class AiAssistantController extends GetxController {
  void openGeminiChat() {
    Get.toNamed("/gemini_chat");
  }

  void openTranslator() {
    Get.toNamed("/translator_ai");
  }
}
