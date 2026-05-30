import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/ChatDrawerController.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controller/ChatController.dart';
import 'package:flutter_application_1/controller/voice_and_animation_controller.dart';

import 'package:flutter_application_1/view/components/smart_screen/animated_header.dart';
import 'package:flutter_application_1/view/components/smart_screen/chat_input_section.dart';
import 'package:flutter_application_1/view/components/smart_screen/custom_drawer.dart';
import 'package:flutter_application_1/view/components/smart_screen/vpn_dialog.dart';
import 'package:flutter_application_1/view/components/smart_screen/top_action_bar.dart';
import 'package:flutter_application_1/view/components/smart_screen/luxury_background.dart';
import 'package:flutter_application_1/view/components/smart_screen/chat_messages_list.dart';

class SmartChatScreen extends GetView<ChatController> {
  const SmartChatScreen({Key? key}) : super(key: key);

  static const Color primaryColor = Color(0xFFD2775B);
  static const Color backgroundColor = Color(0xFFFFFAF5);

  @override
  Widget build(BuildContext context) {
    // التأكد من حقن الكنترولرات بالذاكرة
    if (!Get.isRegistered<ChatController>()) Get.put(ChatController());
    // حقن كنترولر الصوت الجديد
    final voiceCtrl = Get.put(VoiceAndAnimationController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showVPNDialog(context, backgroundColor, primaryColor);
    });

    return CustomDrawer(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            const LuxuryBackground(primaryColor: primaryColor),
            SafeArea(
              child: Column(
                children: [
                  // 1. شريط التحكم العلوي (يتحكم به كُنترولر الصوت)
                  Obx(
                    () => TopActionBar(
                      primaryColor: primaryColor,
                      isVoiceModeEnabled: voiceCtrl.isVoiceModeEnabled.value,
                      onMenuTap: () =>
                          Get.find<ChatDrawerController>().toggle(),
                      onVoiceToggleTap: () => voiceCtrl.toggleVoiceMode(),
                    ),
                  ),

                  // 2. الهيدر المتحرك (يأخذ الأنيميشن من كُنترولر الصوت)
                  AnimatedHeader(
                    animationController: voiceCtrl.animationController,
                    primaryColor: primaryColor,
                    backgroundColor: backgroundColor,
                  ),

                  // 3. قائمة الرسائل (تتبع الكنترولر الأساسي للشات)
                  ChatMessagesList(
                    controller: controller,
                    primaryColor: primaryColor,
                  ),

                  // 4. حقل الإدخال (يأخذ البيانات ويعطي الأوامر للكنترولرين معاً)
                  Obx(
                    () => ChatInputSection(
                      controller: controller,
                      textController: voiceCtrl.textController,
                      isListening: voiceCtrl.isListening.value,
                      soundLevel: voiceCtrl.soundLevel.value,
                      primaryColor: primaryColor,
                      backgroundColor: backgroundColor,
                      onListenTap: () => voiceCtrl.listen(),
                      onSendTap: () {
                        voiceCtrl
                            .stopSpeaking(); // إيقاف الصوت فوراً عند الإرسال
                        controller.handleSendMessage(
                          voiceCtrl.textController.text,
                        );
                        voiceCtrl.textController.clear(); // مسح الحقل
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
