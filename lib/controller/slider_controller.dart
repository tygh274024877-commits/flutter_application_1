import 'package:flutter_application_1/models/landMark_model.dart';
import 'package:get/get.dart';

class SliderController extends GetxController {
  // نستخدم getter لجلب البيانات المترجمة في كل مرة
  List<Landmark> get sliderLandmarks => LandmarkData.sliderLandmarks;

  var currentIndex = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }
}
