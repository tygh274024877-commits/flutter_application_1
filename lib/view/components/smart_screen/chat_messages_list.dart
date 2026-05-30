import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controller/ChatController.dart';
import 'package:flutter_application_1/view/components/smart_screen/chat_bubble.dart';

class ChatMessagesList extends StatelessWidget {
  final ChatController controller;
  final Color primaryColor;

  const ChatMessagesList({
    Key? key,
    required this.controller,
    required this.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          // التعديل 1: جعل القائمة تبدأ من الأسفل لراحة المستخدم أثناء التمرير
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: controller.messages.length,
          itemBuilder: (context, index) {
            // التعديل 2: قلب الـ index ليعرض الرسائل بترتيبها الزمني الصحيح مع الـ reverse
            final reversedIndex = controller.messages.length - 1 - index;

            return ChatBubble(
              message: controller.messages[reversedIndex],
              primaryColor: primaryColor,
            );
          },
        ),
      ),
    );
  }
}
