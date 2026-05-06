import 'package:flutter_application_1/controller/mainwapper_controller.dart';
import 'package:flutter_application_1/controller/slider_controller.dart';
import 'package:flutter_application_1/models/landMark_model.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  final SliderController sliderController = Get.find<SliderController>();
  final MainWrapperController mainWrapperController =
      Get.find<MainWrapperController>();
  final List<LandmarkModel> exploreList = LandmarkData.exploreList;

  void openMenu() {
    mainWrapperController.zoomDrawerController.toggle?.call();
  }

  var currentIndex = 0.obs;
  // دالة تحديث الاندكس للسلايدر
  void updateIndex(int index) {
    currentIndex.value = index;
  }
}
