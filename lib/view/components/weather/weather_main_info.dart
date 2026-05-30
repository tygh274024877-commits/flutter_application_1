import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/controller/weather_controller.dart';
import 'package:get/get.dart'; // تأكدي من استيراد Get

class WeatherMainInfo extends StatelessWidget {
  final WeatherController controller;

  const WeatherMainInfo({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // الحصول على اللغة الحالية للتحكم بتنسيق الوقت
    String langCode = Get.locale?.languageCode ?? 'ar';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عمود الوقت والـ Icon المباشر
        Transform.translate(
          offset: const Offset(0, -12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StreamBuilder<DateTime>(
                stream: Stream.periodic(
                  const Duration(seconds: 1),
                  (_) => DateTime.now(),
                ),
                builder: (context, snapshot) {
                  final now = snapshot.data ?? DateTime.now();
                  return Text(
                    DateFormat('hh:mm a', langCode).format(now),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Obx(
                () => controller.iconUrl.value.isNotEmpty
                    ? Image.network(
                            controller.iconUrl.value,
                            width: controller.isNight.value ? 120 : 95,
                            height: controller.isNight.value ? 120 : 95,
                            fit: BoxFit.contain,
                          )
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .moveY(
                            begin: -6,
                            end: 6,
                            duration: const Duration(seconds: 2),
                            curve: Curves.easeInOut,
                          )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
        // عمود درجات الحرارة الحالي
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                "${controller.temperature.value}°C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 54,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Obx(
              () => Text(
                controller.weatherCondition.value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
            const SizedBox(height: 5),
            Obx(
              () => Text(
                "${'feels_like'.tr} ${controller.feelsLike.value}°",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 13,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
