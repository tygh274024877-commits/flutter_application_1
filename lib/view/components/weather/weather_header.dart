import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // تأكد من استيراد Get
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:flutter_application_1/controller/weather_controller.dart';
import 'weather_background.dart';
import 'weather_top_bar.dart';
import 'weather_main_info.dart';

class WeatherHeader extends StatelessWidget {
  final WeatherController controller;

  const WeatherHeader({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تحديد اللغة الحالية
    String lang = Get.locale?.languageCode ?? 'en';

    List<Color> glassColors = [
      AppColors.primary.withOpacity(0.95),
      AppColors.primary.withOpacity(0.85),
    ];

    if (controller.isNight.value) {
      glassColors = [
        AppColors.primary.withOpacity(0.85),
        AppColors.BurntBrown.withOpacity(0.90),
      ];
    } else if (controller.isRaining.value) {
      glassColors = [
        AppColors.primary.withOpacity(0.85),
        AppColors.BurntBrown.withOpacity(0.80),
      ];
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.BurntBrown.withOpacity(0.38),
            blurRadius: 25,
            spreadRadius: 4,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          if (controller.isRaining.value)
            Positioned.fill(
              child: const CustomPaint(painter: RainPainter())
                  .animate(onPlay: (c) => c.repeat())
                  .custom(
                    duration: const Duration(seconds: 1),
                    builder: (context, value, child) =>
                        const CustomPaint(painter: RainPainter()),
                  ),
            ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.fromLTRB(16, 45, 16, 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: glassColors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  WeatherTopBar(controller: controller),
                  const SizedBox(height: 5),
                  // عرض التاريخ ديناميكياً حسب اللغة
                  Text(
                    DateFormat('EEEE, d MMMM', lang).format(DateTime.now()),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 15,
                      fontFamily: lang == 'ar' ? 'Cairo' : 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 25),
                  WeatherMainInfo(controller: controller),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSmallDetail(
                        Icons.air,
                        "${controller.windSpeed.value} ${'km_h'.tr}",
                        "wind".tr,
                      ),
                      _buildSmallDetail(
                        Icons.water_drop,
                        "${controller.humidity.value}%",
                        "humidity".tr,
                      ),
                      _buildSmallDetail(
                        Icons.wb_sunny_outlined,
                        "low".tr,
                        "uv_index".tr,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallDetail(IconData icon, String value, String label) {
    String lang = Get.locale?.languageCode ?? 'en';
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 21),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white60,
            fontSize: 11,
            fontFamily: lang == 'ar' ? 'Cairo' : 'Poppins',
          ),
        ),
      ],
    );
  }
}
