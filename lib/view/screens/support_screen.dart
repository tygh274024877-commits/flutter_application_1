import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../core/color/constants.dart';
import '../../controller/support_controller.dart';
import '../components/support_screen/animated_support_bulb.dart';
import '../components/support_screen/support_cards_grid.dart';
import '../components/support_screen/support_header_title.dart';
import '../components/support_screen/support_app_bar.dart';

class SupportScreen extends GetView<SupportController> {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // تم حذف سطر Get.put ليعتمد بالكامل على الـ Binding المركزي والنظيف

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SupportAppBar(),
      body: AnimationLimiter(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),

              // استدعاء اللمبة
              AnimatedSupportBulb(),

              const SizedBox(height: 20),
              const SupportHeaderTitle(),
              const SizedBox(height: 40),

              // استدعاء شبكة الكروت وتمرير الـ controller الافتراضي للـ GetView
              SupportCardsGrid(controller: controller),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
