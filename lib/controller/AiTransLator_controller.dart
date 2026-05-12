import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:flutter_application_1/models/TranslationHistoryService.dart';
import 'package:flutter_application_1/view/components/Aitranslator/InteractiveOcrScreen.dart';

import 'package:get/get.dart';
import 'package:translator/translator.dart' as google_translator;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class AiTranslatorController extends GetxController {
  final _historyService = TranslationHistoryService();
  final translator = google_translator.GoogleTranslator();
  final stt.SpeechToText speech = stt.SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  final ImagePicker _picker = ImagePicker();

  final sourceText = "".obs, translatedText = "الترجمة ستظهر هنا...".obs;
  final isLoading = false.obs, isListening = false.obs, isMuted = false.obs;
  final sourceLang = "English".obs, targetLang = "Arabic".obs;

  final recognizedBlocks = <TextBlock>[].obs;
  final imageFile = Rxn<File>(), imageSize = Size.zero.obs;
  final history = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _setupTts();
    _initHistory();
  }

  void _setupTts() async =>
      await flutterTts.setEngine("com.google.android.tts");
  void _initHistory() async =>
      history.assignAll(await _historyService.loadHistory());

  void addToHistory(String src, String tgt) async {
    if (src.isEmpty || tgt == "الترجمة ستظهر هنا...") return;
    history.insert(0, {
      'source': src,
      'target': tgt,
      'time': DateTime.now().toIso8601String(),
    });
    if (history.length > 50) history.removeLast();
    await _historyService.saveHistory(history);
  }

  void clearHistory() async {
    history.clear();
    await _historyService.clear();
  }

  void deleteHistoryItem(int i) async {
    history.removeAt(i);
    await _historyService.saveHistory(history);
  }

  Future<void> translate() async {
    if (sourceText.value.trim().isEmpty) return;
    try {
      isLoading.value = true;
      final res = await translator.translate(
        sourceText.value,
        from: sourceLang.value == "Arabic" ? "ar" : "en",
        to: targetLang.value == "Arabic" ? "ar" : "en",
      );
      translatedText.value = res.text;
      addToHistory(sourceText.value, translatedText.value);
    } catch (_) {
      translatedText.value = "مشكلة في الاتصال";
    } finally {
      isLoading.value = false;
    }
  }

  void speakResult() async {
    if (translatedText.value.isEmpty ||
        translatedText.value == "الترجمة ستظهر هنا...")
      return;
    await flutterTts.setLanguage(
      targetLang.value == "Arabic" ? "ar-SA" : "en-US",
    );
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(translatedText.value);
  }

  void toggleVoiceTranslation() async {
    if (isListening.value) {
      isListening.value = false;
      speech.stop();
      return;
    }
    if (await speech.initialize()) {
      isListening.value = true;
      speech.listen(
        localeId: sourceLang.value == "Arabic" ? "ar_SA" : "en_US",
        onResult: (val) async {
          sourceText.value = val.recognizedWords;
          if (val.finalResult) {
            isListening.value = false;
            if (sourceText.value.trim().isEmpty) {
              _showWarning("لم يتم التعرف على كلمات واضحة");
            } else {
              await translate();
              if (!isMuted.value) speakResult();
            }
          }
        },
      );
    }
  }

  // --- الكاميرا والـ OCR مع الإشعارات ---
  void translateFromCamera() async {
    final photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (photo == null) return;
    try {
      isLoading.value = true;
      imageFile.value = File(photo.path);
      final img = await decodeImageFromList(imageFile.value!.readAsBytesSync());
      imageSize.value = Size(img.width.toDouble(), img.height.toDouble());

      final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final recognizedText = await recognizer.processImage(
        InputImage.fromFilePath(photo.path),
      );

      // التحقق إذا كان النص موجوداً وصورته واضحة
      if (recognizedText.blocks.isEmpty) {
        _showWarning("الصورة غير واضحة أو لا تحتوي على نص");
      } else {
        recognizedBlocks.assignAll(recognizedText.blocks);
        Get.to(() => const InteractiveOcrScreen());
      }
      await recognizer.close();
    } catch (e) {
      _showWarning("فشل في معالجة الصورة");
    } finally {
      isLoading.value = false;
    }
  }

  // دالة مساعدة لعرض الإشعارات بستايلك الخاص
  void _showWarning(String message) {
    Get.snackbar(
      "تنبيه",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary.withOpacity(0.9),
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
      icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
    );
  }

  void swapLanguages() {
    final temp = sourceLang.value;
    sourceLang.value = targetLang.value;
    targetLang.value = temp;
    if (translatedText.value != "الترجمة ستظهر هنا...") {
      final oldSrc = sourceText.value;
      sourceText.value = translatedText.value;
      translatedText.value = oldSrc;
    }
  }

  void translateAll() {
    sourceText.value = recognizedBlocks.map((b) => b.text).join(' ');
    translate();
    Get.back();
  }

  void selectTextFromImage(String text) {
    sourceText.value = text.replaceAll('\n', ' ').trim();
    translate();
    Get.back();
  }
}
