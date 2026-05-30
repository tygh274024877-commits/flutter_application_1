import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/ChatDrawerController.dart';
import 'package:flutter_application_1/core/theme/app_shadows.dart';
import 'package:flutter_application_1/view/components/smart_screen/smart_meneu.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

// استيراد ملف الكنترولرات
import 'package:flutter_application_1/controller/ChatController.dart';
import 'package:flutter_application_1/controller/chat_history_controller.dart';

// 👇 استيراد ملف الظلال والألوان الخاص بك لاستخدام AppShadows
import 'package:flutter_application_1/core/color/constants.dart';

class CustomDrawer extends StatelessWidget {
  final Widget child;

  const CustomDrawer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // حقن الكنترولرات اللازمة عند بناء الـ Drawer
    final ChatDrawerController drawerController = Get.put(
      ChatDrawerController(),
    );
    final ChatHistoryController historyController = Get.put(
      ChatHistoryController(),
    );
    final ChatController chatController = Get.find<ChatController>();

    return ZoomDrawer(
      controller: drawerController.zoomDrawerController,
      mainScreen: child,
      menuScreen: const MenuScreen(),
      // حركة المائل الاحترافية للـ ZoomDrawer وإعداداته
      isRtl: true,
      borderRadius: 40.0,
      angle: -8.0,
      slideWidth: MediaQuery.of(context).size.width * 0.70,
      menuBackgroundColor: const Color(0xFFFFFAF5), // الخلفية الكريمية الدافئة
      mainScreenTapClose: true,
      boxShadow: AppShadows.neumorphicShadow,
    );
  }
}
