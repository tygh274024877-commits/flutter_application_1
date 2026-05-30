import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/controller/weather_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:flutter_application_1/core/theme/app_shadows.dart';
import 'package:get/get.dart'; // تأكدي من استيراد Get

class DailyForecastWidget extends StatelessWidget {
  final WeatherController controller;

  const DailyForecastWidget({Key? key, required this.controller})
    : super(key: key);

  String _getDayName(String dateStr) {
    // الحصول على كود اللغة الحالي ديناميكياً
    String langCode = Get.locale?.languageCode ?? 'ar';
    try {
      DateTime parsedDate = DateTime.parse(dateStr);
      return DateFormat('EEEE', langCode).format(parsedDate);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // تغليف بـ Obx للتحديث التلقائي عند جلب بيانات جديدة
      child: Obx(
        () => Column(
          children: List.generate(controller.forecastList.length, (index) {
            var day = controller.forecastList[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppShadows.golden.withOpacity(0.4),
                  width: 0.8,
                ),
                boxShadow: AppShadows.neumorphicShadow,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 90,
                    child: Text(
                      _getDayName(day['date'] ?? ""),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.BurntBrown,
                        fontSize: 14,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Image.network(
                        "https:${day['day']?['condition']?['icon'] ?? ''}",
                        width: 35,
                        height: 35,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.wb_cloudy, size: 20),
                      ),
                      const SizedBox(width: 8),
                      // ملاحظة: حالة الطقس هنا تأتي من الـ API مباشرة بلغة التطبيق
                      // لأننا قمنا بتحديد lang في الـ API Call بالـ Controller
                      Text(
                        day['day']?['condition']?['text'] ?? "",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${(day['day']?['maxtemp_c'] ?? 0).round()}° / ${(day['day']?['mintemp_c'] ?? 0).round()}°",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
