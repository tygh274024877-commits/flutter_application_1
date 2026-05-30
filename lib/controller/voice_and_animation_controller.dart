import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_application_1/controller/ChatController.dart';

class VoiceAndAnimationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final TextEditingController textController = TextEditingController();
  late AnimationController animationController;
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;

  var isListening = false.obs;
  var isVoiceModeEnabled = true.obs;
  var soundLevel = 0.0.obs;
  int _lastMessageCount = 0;

  @override
  void onInit() {
    super.onInit();
    _speech = stt.SpeechToText();
    _initTts();

    // التيكر والأنيميشن مكانهما الطبيعي هنا
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat();

    // الوصول للـ ChatController لمراقبة الرسائل الجديدة ونطقها
    final chatController = Get.find<ChatController>();
    ever(chatController.messages, (List chatMessages) {
      if (isVoiceModeEnabled.value &&
          chatMessages.isNotEmpty &&
          chatMessages.length > _lastMessageCount) {
        final lastMessage = chatMessages.last;
        if (!lastMessage.isUser) {
          speak(lastMessage.text);
        }
      }
      _lastMessageCount = chatMessages.length;
    });
  }

  void _initTts() async {
    _flutterTts = FlutterTts();
    await _flutterTts.setLanguage("ar-XA");
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  void speak(String text) async {
    if (text.isNotEmpty) {
      await _flutterTts.speak(text);
    }
  }

  void stopSpeaking() async {
    await _flutterTts.stop();
  }

  void toggleVoiceMode() {
    isVoiceModeEnabled.value = !isVoiceModeEnabled.value;
    if (!isVoiceModeEnabled.value) _flutterTts.stop();
  }

  void listen() async {
    if (!isListening.value) {
      await _flutterTts.stop();
      bool available = await _speech.initialize(
        onStatus: (val) =>
            val == 'notListening' ? isListening.value = false : null,
        onError: (val) => isListening.value = false,
      );

      if (available) {
        isListening.value = true;
        _speech.listen(
          onResult: (val) => textController.text = val.recognizedWords,
          onSoundLevelChange: (level) => soundLevel.value = level,
        );
      }
    } else {
      _speech.stop();
      isListening.value = false;
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    textController.dispose();
    _flutterTts.stop();
    super.onClose();
  }
}
