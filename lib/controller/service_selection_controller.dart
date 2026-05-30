import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/controller/slider_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:flutter_application_1/models/detaileds_srvices.dart';
import 'package:flutter_application_1/models/landMark_model.dart';
import 'package:flutter_application_1/models/show_cites.dart';
import 'package:flutter_application_1/models/tripservices_Traslition.dart';
import 'package:get/get.dart';

class ServicesselectController extends GetxController {
  final SliderController sliderController = Get.find<SliderController>();
  final List<LandmarkModel> exploreList = LandmarkData.exploreList;
  final List<ServiceModel> servicesList = ServiceModel.servicesList;
  var selectedCity = "All".obs;
  var currentItems = <Map<String, dynamic>>[].obs;
  late int activeServiceId;
  // تابع لتحديث القيمة
  void changeCity(String cityName) {
    selectedCity.value = cityName;
  }

  void loaditemsbyservice(int serviceID) {
    activeServiceId = serviceID;
    var serviceData = detailedData[serviceID];

    if (serviceData != null) {
      if (selectedCity.value == "All") {
        List<Map<String, dynamic>> allItems = [];
        serviceData.forEach((cityName, itemList) {
          allItems.addAll(
            itemList,
          ); // ✅ التصحيح: إضافة القائمة القادمة من الـ Map
        });
        currentItems.assignAll(allItems);
      } else {
        var cityData = serviceData[selectedCity.value];
        currentItems.assignAll(cityData ?? []);
      }
    }
  }

  void showCityPicker() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "choose_city_title".tr,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.BurntBrown,
                ),
              ),
              const Divider(color: AppColors.BurntBrown),
              ListTile(
                leading: const Icon(Icons.map, color: AppColors.BurntBrown),
                title: Text(
                  "all_cities_label".tr,
                  style: TextStyle(color: AppColors.BurntBrown),
                ),
                onTap: () {
                  changeCity("All");
                  Get.back();
                },
              ),
              ...syrianCities.map(
                (city) => ListTile(
                  leading: const Icon(
                    Icons.location_city_rounded,
                    color: AppColors.BurntBrown,
                  ),
                  title: Text(
                    city.tr,
                    style: TextStyle(color: AppColors.BurntBrown),
                  ),
                  onTap: () {
                    changeCity(city); // تحديث المتغير بالمحافظة المختارة
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

var currentIndex = 0.obs;
// دالة تحديث الاندكس للسلايدر
void updateIndex(int index) {
  currentIndex.value = index;
}
