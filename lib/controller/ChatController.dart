import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_application_1/models/chat_model.dart';
import 'package:flutter_application_1/controller/chat_history_controller.dart';

class ChatController extends GetxController {
  var messages = <ChatModel>[].obs;
  var isLoading = false.obs;
  var selectedImagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();

  String currentSessionId = '';

  // الاعتمادية على كنترولر الأرشيف
  final ChatHistoryController _historyController = Get.put(
    ChatHistoryController(),
  );

  @override
  void onInit() {
    super.onInit();
    startNewChat();
  }

  void startNewChat() {
    messages.clear();
    currentSessionId = DateTime.now().millisecondsSinceEpoch.toString();
    clearSelectedImage();
  }

  void loadChatSession(ChatSessionModel session) {
    currentSessionId = session.id;
    messages.assignAll(session.messages);
  }

  void deleteChatSession(String sessionId) {
    _historyController.deleteChatSession(sessionId);
    if (currentSessionId == sessionId) {
      startNewChat();
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 70,
      );
      if (image != null) {
        selectedImagePath.value = image.path;
      }
    } catch (e) {
      print("❌ فشل التقاط الصورة: $e");
    }
  }

  void clearSelectedImage() {
    selectedImagePath.value = '';
  }

  void handleSendMessage(String userText) async {
    if (userText.trim().isEmpty && selectedImagePath.value.isEmpty) return;
    if (isLoading.value) return;

    String imagePathToSend = selectedImagePath.value;
    clearSelectedImage();

    final newUserMessage = ChatModel(text: userText, isUser: true);
    messages.add(newUserMessage);
    isLoading.value = true;

    // تحديث الأرشيف عبر كنترولر الأرشيف المخصص
    _historyController.updateOrCreateSession(
      sessionId: currentSessionId,
      firstText: userText,
      currentMessages: messages,
    );

    try {
      const apiKeyEnv = String.fromEnvironment('GEMINI_API_KEY');
      final model = GenerativeModel(
        model: 'gemini-2.5-flash',
        apiKey: apiKeyEnv,
      );

      List<Part> parts = [];

      if (imagePathToSend.isNotEmpty) {
        final File imageFile = File(imagePathToSend);
        if (await imageFile.exists()) {
          final bytes = await imageFile.readAsBytes();
          String mimeType = imagePathToSend.endsWith('.png')
              ? 'image/png'
              : 'image/jpeg';
          parts.add(DataPart(mimeType, bytes));
        }
      }

      if (userText.trim().isNotEmpty) {
        parts.add(TextPart(userText));
      } else if (imagePathToSend.isNotEmpty) {
        parts.add(
          TextPart("اشرح لي هذه الصورة أو أخبرني ماذا يوجد فيها بالتفصيل."),
        );
      }

      final response = await model.generateContent([Content.multi(parts)]);

      if (response.text != null) {
        final newBotMessage = ChatModel(text: response.text!, isUser: false);
        messages.add(newBotMessage);

        // حفظ رد البوت النهائي في الأرشيف
        _historyController.updateOrCreateSession(
          sessionId: currentSessionId,
          firstText: userText,
          currentMessages: messages,
        );
      }
    } catch (e) {
      messages.add(ChatModel(text: 'تنبيه: ${e.toString()}', isUser: false));
    } finally {
      isLoading.value = false;
    }
  }
}
