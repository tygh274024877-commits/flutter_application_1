import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/controller/weather_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:flutter_application_1/core/theme/app_shadows.dart';
import 'package:get/get.dart'; // تأكدي من استيراد Get

class HourlyForecastWidget extends StatelessWidget {
  final WeatherController controller;

  const HourlyForecastWidget({Key? key, required this.controller})
    : super(key: key);

  String _formatHour(String timeStr) {
    // الحصول على كود اللغة الحالي ديناميكياً
    String langCode = Get.locale?.languageCode ?? 'ar';
    try {
      DateTime parsedTime = DateTime.parse(timeStr);
      return DateFormat('hh:mm a', langCode).format(parsedTime);
    } catch (e) {
      if (timeStr.length > 11) return timeStr.substring(11, 16);
      return timeStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      // تغليف القائمة بـ Obx لتتحدث عند تغير بيانات الطقس
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemCount: controller.hourlyList.length > 24
              ? 24
              : controller.hourlyList.length,
          itemBuilder: (context, index) {
            var hour = controller.hourlyList[index];
            return Container(
              width: 90,
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppShadows.golden.withOpacity(0.4),
                  width: 0.8,
                ),
                boxShadow: AppShadows.neumorphicShadow,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _formatHour(hour['time'].toString()),
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.BurntBrown,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Image.network(
                    "https:${hour['condition']?['icon'] ?? ''}",
                    width: 35,
                    height: 35,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.wb_cloudy, size: 20),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${(hour['temp_c'] ?? 0).round()}°",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
