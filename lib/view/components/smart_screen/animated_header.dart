import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'robot/beautiful_robot.dart'; // استيراد كلاس الروبوت الجديد
import 'gemini_text.dart'; // استيراد كلاس النص الجديد

class AnimatedHeader extends StatelessWidget {
  final AnimationController animationController;
  final Color primaryColor;
  final Color backgroundColor;

  const AnimatedHeader({
    Key? key,
    required this.animationController,
    required this.primaryColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          // حسابات الزاوية والمدار الموسع (130 أفقي و 45 عمودي)
          double angle = animationController.value * 2 * math.pi;
          double gVerticalOffset = 4 * math.sin(angle * 5);

          double x = 130 * math.cos(angle);
          double y = 45 * math.sin(angle);

          double scale = 0.80 + (0.20 * math.sin(angle + math.pi / 2));
          bool isBehindG = math.sin(angle) < 0;
          double walkCycle = math.sin(angle * 6);

          // حساب حجم وظل الأرضية
          double shadowOpacity = 0.15 - (gVerticalOffset * 0.01);
          double shadowWidth = 60.0 - (gVerticalOffset * 2);

          // ويدجت الروبوت الجاهز والممرر له المتغيرات
          Widget robotWidget = BeautifulRobot(
            walkCycle: walkCycle,
            primaryColor: primaryColor,
            backgroundColor: backgroundColor,
          );

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 160,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // 1. الظل السفلي
                    Positioned(
                      bottom: 5,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 50),
                        width: shadowWidth.clamp(45.0, 75.0),
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                shadowOpacity.clamp(0.08, 0.22),
                              ),
                              blurRadius: 12,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 2. الروبوت في الخلف
                    if (isBehindG)
                      Transform.translate(
                        offset: Offset(x, y),
                        child: Transform.scale(
                          scale: scale,
                          child: Opacity(opacity: 0.4, child: robotWidget),
                        ),
                      ),

                    // 3. كلمة Gemini العائمة
                    GeminiText(
                      verticalOffset: gVerticalOffset,
                      primaryColor: primaryColor,
                    ),

                    // 4. الروبوت في الأمام
                    if (!isBehindG)
                      Transform.translate(
                        offset: Offset(x, y),
                        child: Transform.scale(
                          scale: scale,
                          child: Opacity(opacity: 1.0, child: robotWidget),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 4),

              // النص الفرعي الأنيق
              Text(
                "AI SMART CHAT",
                style: TextStyle(
                  color: primaryColor,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                  fontSize: 9.5,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
