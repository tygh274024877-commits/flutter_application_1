import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/models/chat_model.dart';

class ChatHistoryController extends GetxController {
  var chatHistory = <ChatSessionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistoryFromPrefs();
  }

  // حفظ التاريخ بالكامل في الذاكرة الدائمة
  Future<void> saveHistoryToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonStringList = chatHistory
        .map((session) => jsonEncode(session.toJson()))
        .toList();
    await prefs.setStringList('gemini_chat_history', jsonStringList);
  }

  // استرجاع التاريخ عند فتح التطبيق
  Future<void> loadHistoryFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList('gemini_chat_history');

    if (jsonStringList != null) {
      var loadedSessions = jsonStringList.map((str) {
        return ChatSessionModel.fromJson(jsonDecode(str));
      }).toList();
      chatHistory.assignAll(loadedSessions);
    }
  }

  // إضافة أو تحديث جلسة محادثة
  void updateOrCreateSession({
    required String sessionId,
    required String firstText,
    required List<ChatModel> currentMessages,
  }) {
    int index = chatHistory.indexWhere((session) => session.id == sessionId);

    if (index == -1) {
      String autoTitle = firstText.trim().isNotEmpty
          ? (firstText.length > 25
                ? '${firstText.substring(0, 25)}...'
                : firstText)
          : "محادثة صور";

      chatHistory.insert(
        0,
        ChatSessionModel(
          id: sessionId,
          title: autoTitle,
          messages: List.from(currentMessages),
        ),
      );
    } else {
      chatHistory[index].messages = List.from(currentMessages);
    }
    saveHistoryToPrefs();
  }

  // حذف جلسة
  void deleteChatSession(String sessionId) {
    chatHistory.removeWhere((session) => session.id == sessionId);
    saveHistoryToPrefs();
  }
}
