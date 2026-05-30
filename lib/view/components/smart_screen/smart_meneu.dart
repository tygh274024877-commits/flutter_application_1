import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/ChatDrawerController.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controller/ChatController.dart';
import 'package:flutter_application_1/controller/chat_history_controller.dart';

import 'package:flutter_application_1/core/color/constants.dart';
import 'package:flutter_application_1/view/components/shared/golden_widgets.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatDrawerController drawerController =
        Get.find<ChatDrawerController>();
    final ChatController chatController = Get.find<ChatController>();
    final ChatHistoryController historyController =
        Get.find<ChatHistoryController>();

    return Scaffold(
      backgroundColor: AppColors.waveGreen,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),

            // 1. 👇 زر "محادثة جديدة" مع تدرج لوني وظل نيومورفيكي أعمق
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  chatController.startNewChat();
                  drawerController.toggle();
                },
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    // 👇 تدرج لوني على الحاوية
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.1),
                        AppColors.waveGreen.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: AppColors.golden.withOpacity(0.4),
                      width: 1,
                    ),
                    // 👇 أعمق Neumorphic Shadows
                    boxShadow: [
                      // الظل الفاتح اللامع العلوي
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        offset: const Offset(-3, -3),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                      // الظل الداكن السفلي
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(3, 3),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GoldenGradientWrapper(
                        child: const Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'محادثة جديدة',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
              child: Text(
                'المحادثات الأخيرة',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 13,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 2. 👇 خلفية القائمة مع تدرج لوني لتأثير الظل
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  // 👇 تدرج لوني على خلفية ListView
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent, // منطقة أكثر قتامة في الأعلى
                      AppColors.waveGreen.withOpacity(
                        0.2,
                      ), // منطقة أفتح في الأسفل
                    ],
                  ),
                ),
                child: Obx(
                  () => ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: historyController.chatHistory.length,
                    itemBuilder: (context, index) {
                      final chatSession = historyController.chatHistory[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        child: ListTile(
                          dense: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          horizontalTitleGap: 5,
                          leading: GoldenGradientWrapper(
                            child: const Icon(
                              Icons.chat_bubble_outline_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          title: Text(
                            chatSession.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.white38,
                              size: 18,
                            ),
                            onPressed: () {
                              chatController.deleteChatSession(chatSession.id);
                            },
                          ),
                          onTap: () {
                            chatController.loadChatSession(chatSession);
                            drawerController.toggle();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            Divider(
              color: Colors.white.withOpacity(0.1),
              height: 20,
              thickness: 1,
            ),

            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 5,
              ),
              leading: GoldenGradientWrapper(
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              title: const Text(
                'إغلاق القائمة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Cairo',
                ),
              ),
              onTap: () => drawerController.toggle(),
            ),
          ],
        ),
      ),
    );
  }
}
