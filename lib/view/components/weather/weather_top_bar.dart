import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/weather_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:get/get.dart';

class WeatherTopBar extends StatelessWidget {
  final WeatherController controller;
  const WeatherTopBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // نستخدم Directionality لفرض اتجاه RTL للقائمة العلوية
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 28),
            onPressed: () => _showSearchDialog(context),
          ),
          Expanded(
            child: Obx(
              () => Text(
                controller.cityName.value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white, size: 28),
            onSelected: (String city) =>
                controller.fetchWeatherByCityName(city),
            itemBuilder: (context) => controller.translatedGovernorates
                .map(
                  (city) => PopupMenuItem(
                    value: city,
                    child: Text(
                      city,
                      style: const TextStyle(fontFamily: 'Cairo'),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    final governorates = controller.translatedGovernorates;
    String selectedGov = governorates.isNotEmpty ? governorates.first : "";

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Directionality(
            // فرض اتجاه RTL داخل نافذة الحوار أيضاً
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Text(
                "choose_city_title".tr,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  color: AppColors.BurntBrown,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: governorates.contains(selectedGov)
                        ? selectedGov
                        : governorates.first,
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    iconEnabledColor: AppColors.BurntBrown,
                    style: const TextStyle(
                      color: AppColors.BurntBrown,
                      fontFamily: 'Cairo',
                      fontSize: 16,
                    ),
                    items: governorates
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                    onChanged: (v) => setState(() => selectedGov = v!),
                    underline: Container(
                      height: 2,
                      color: AppColors.BurntBrown,
                    ),
                  ),
                  TextField(
                    controller: controller.searchController,
                    textAlign: TextAlign
                        .start, // استخدام start يجعله ذكياً (يمين في العربي، يسار في الإنجليزي)
                    textDirection: TextDirection
                        .rtl, // لفرض أن النص المكتوب داخل الـ TextField يبدأ من اليمين دائماً
                    decoration: InputDecoration(
                      hintText: "enter_text_hint".tr,
                      hintStyle: const TextStyle(
                        fontFamily: 'Cairo',
                        color: Colors.grey, // لون الـ Hint
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.BurntBrown),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.BurntBrown,
                          width: 2.0,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    controller.fetchWeatherByCityAndArea(
                      selectedGov,
                      controller.searchController.text,
                    );
                    Navigator.pop(context);
                  },
                  child: Text(
                    "save".tr,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
