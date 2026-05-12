import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/assistant_controller.dart';
import 'package:flutter_application_1/view/components/assistnt_screen/floatingrobot.dart';
import 'package:flutter_application_1/view/components/assistnt_screen/smartcardaction.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

import 'package:flutter_application_1/view/components/shared/waveheader.dart';

class AppColors {
  static const Color background = Color(0xFFFFFAF5);
  static const Color primary = Color(0xFFD2775B);
  static const Color golden = Color(0xFFC5A358);
  static const Color darkBrown = Color(0xFF503530);
  static const Color waveGreen = Color(0xFFB8D8BA);
  static const Color waveGold = Color(0xFFE6C98A);
}

class AiAssistantHomeScreen extends StatelessWidget {
  const AiAssistantHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // استدعاء الكنترولر المعرف مسبقاً في الـ AppBinding
    final AiAssistantController controller = Get.find<AiAssistantController>();

    return Scaffold(
      body: Stack(
        children: [
          // 1. الخلفية التموحية
          Positioned.fill(
            child: AnimatedMeshGradient(
              colors: [
                AppColors.background,
                AppColors.waveGreen.withOpacity(0.75),
                AppColors.waveGold.withOpacity(0.65),
                AppColors.background,
              ],
              options: AnimatedMeshGradientOptions(speed: 0.03, amplitude: 35),
            ),
          ),

          const Positioned(top: 0, left: 0, right: 0, child: WaveHeader()),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 160),
                Expanded(
                  child: AnimationLimiter(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          const FloatingRobotWithSmartHi(),
                          const SizedBox(height: 30),
                          const Text(
                            "TripMate AI",
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBrown,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const Text(
                            "Your personal travel guide",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          const SizedBox(height: 45),

                          ...AnimationConfiguration.toStaggeredList(
                            duration: const Duration(milliseconds: 1000),
                            childAnimationBuilder: (widget) => SlideAnimation(
                              verticalOffset: 120.0,
                              child: FadeInAnimation(child: widget),
                            ),
                            children: [
                              // زر الشات الذكي
                              SmartCardAction(
                                title: "Smart AI Chat",
                                subtitle: "Start a conversation",
                                icon: Icons.auto_awesome_rounded,
                                onTap: () => controller.openGeminiChat(),
                              ),
                              const SizedBox(height: 20),

                              SmartCardAction(
                                title: "AI Translator",
                                subtitle: "Voice & Text",
                                icon: Icons.translate_rounded,
                                onTap: () => controller.openTranslator(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
