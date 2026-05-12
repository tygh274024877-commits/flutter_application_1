import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslationHistoryService {
  static const String _key = 'translation_history';

  // تحميل البيانات
  Future<List<Map<String, String>>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    String? historyString = prefs.getString(_key);
    if (historyString != null) {
      List<dynamic> decodedData = jsonDecode(historyString);
      return decodedData.map((e) => Map<String, String>.from(e)).toList();
    }
    return [];
  }

  // حفظ القائمة بالكامل
  Future<void> saveHistory(List<Map<String, String>> history) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(history));
  }

  // مسح السجل
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
