import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/slider_controller.dart';
import 'package:flutter_application_1/core/theme/app_shadows.dart';
import 'package:flutter_application_1/core/animations/splashAnimations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
//import 'package:http/http.dart';

class ExperienceSyriaSlider extends StatelessWidget {
  final bool showText;
  final List<dynamic> sliderData;
  final dynamic controller;
  const ExperienceSyriaSlider({
    super.key,
    this.showText = true,
    required this.sliderData,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // استدعاء الكنترولر (تأكدي أنه initialized في الـ Binding)
    final SliderController controller = Get.find<SliderController>();

    return CarouselSlider(
      options: CarouselOptions(
        // تحويل الارتفاع لنسبة (مثلاً 18% من طول الشاشة بدلاً من 150 ثابتة)
        height: Get.height * 0.18,
        enlargeCenterPage: true,
        autoPlay: true,
        viewportFraction: 0.8,
        clipBehavior: Clip.none,
        onPageChanged: (index, reason) => controller.updateIndex(index),
      ),
      items: sliderData.map((landmark) {
        return Stack(
          children: [
            // 1. الصورة
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(landmark.imagePath),
                  fit: BoxFit.cover,
                ),
                boxShadow: AppShadows.neumorphicShadow,
              ),
            ),

            // 2. تدرج لوني
            if (showText) ...[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, // التدرج يبدأ من الأعلى
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                  ),
                ),
              ),

              // 3. النص المتحرك بنسب مرنة
              Positioned(
                // وضع النص بناءً على نسبة من الارتفاع والعرض
                bottom: Get.height * 0.02, // بدلاً من 15
                left: Get.width * 0.05, // بدلاً من 20
                right: Get.width * 0.05, // أضفنا Right لضمان عدم خروج النص
                child: Obx(
                  () => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          final customAnimation =
                              SplashAnimations.createOffsetAnimation(
                                controller: animation,
                                begin: const Offset(
                                  0.0,
                                  0.2,
                                ), // تحريك بسيط من الأسفل للأعلى
                                end: Offset.zero,
                                start: 0,
                                endInterval: 1.0,
                                curve: Curves.easeInOut,
                              );
                          return SlideTransition(
                            position: customAnimation,
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                    child: Container(
                      key: ValueKey<int>(controller.currentIndex.value),
                      // تغليف النص بـ FittedBox لحمايته من الـ Overflow في الموبايلات الصغيرة
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller
                              .sliderLandmarks[controller.currentIndex.value]
                              .description
                              .tr,
                          style: TextStyle(
                            color: Colors.white,
                            // حجم الخط كنسبة من عرض الشاشة ليبقى متناسقاً
                            fontSize: Get.width * 0.045,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      }).toList(),
    );
  }
}
