import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_application_1/controller/weather_controller.dart';
import 'package:flutter_application_1/view/components/smart_screen/luxury_background.dart';
import 'package:flutter_application_1/view/components/weather/weather_forecast_widgets.dart';
import 'package:flutter_application_1/view/components/weather/weather_header.dart';
import '../../core/color/constants.dart';
import 'package:flutter_application_1/view/components/weather/daily_forecast_widget.dart';

class WeatherScreen extends GetView<WeatherController> {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // حقن الكونترولر
    Get.lazyPut(() => WeatherController());

    return Scaffold(
      backgroundColor: AppColors.background,
      // زر العودة للموقع الحالي عند البحث يدوياً
      floatingActionButton: Obx(
        () => controller.isManualSearch.value
            ? FloatingActionButton.extended(
                onPressed: () => controller.determinePositionAndFetchWeather(),
                backgroundColor: AppColors.primary,
                icon: const Icon(Icons.my_location, color: Colors.white),
                label: Text(
                  "my_location".tr,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).animate().scale(duration: const Duration(milliseconds: 300))
            : const SizedBox.shrink(),
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          if (controller.isManualSearch.value) {
            await controller.fetchWeatherByCityName(controller.cityName.value);
          } else {
            await controller.determinePositionAndFetchWeather();
          }
        },
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          return Stack(
            children: [
              LuxuryBackground(primaryColor: AppColors.primary),
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    WeatherHeader(controller: controller),
                    const SizedBox(height: 25),
                    _buildSectionTitle("hourly_forecast".tr),
                    HourlyForecastWidget(controller: controller),
                    const SizedBox(height: 25),
                    _buildSectionTitle("daily_forecast".tr),
                    DailyForecastWidget(controller: controller),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
      child: Align(
        // ثابت دائماً من جهة اليسار
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.BurntBrown,
            fontFamily: 'Cairo',
          ),
        ),
      ),
    );
  }
}
