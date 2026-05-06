import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/assistant_controller.dart';
import '../components/shared/custom_widgets.dart'; // لاستدعاء الهيدر القديم

class AssistantScreen extends GetView<AssistantController> {
  const AssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // حقن الكنترولر الخاص بهذه الصفحة
    Get.put(AssistantController());

    return Scaffold(
      backgroundColor: Colors.transparent, // مهمة لتظهر خلفية التطبيق الأساسية
      body: Column(
        children: [
          const TopHeaderActions(), // الهيدر البرتقالي الخاص بكِ
          Expanded(
            child: Center(
              child: Obx(
                () => Text(
                  controller.status.value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => controller.askAI(),
            child: const Text("اسأل الذكاء الاصطناعي"),
          ),
          const SizedBox(height: 100), // مساحة لكي لا يغطي البار السفلي المحتوى
        ],
      ),
    );
  }
}
