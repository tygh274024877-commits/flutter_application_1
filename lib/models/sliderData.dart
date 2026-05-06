import 'package:get/get.dart';

class Landmark {
  final String description; // وصف الجمالية
  final String imagePath;

  Landmark({required this.description, required this.imagePath});
}

class LandmarkData {
  static List<Landmark> sliderLandmarks = [
    Landmark(
      description: "aleppo_slider_desc".tr, // ترجمة: "حجارة تروي ألف قصة"
      imagePath: "assets/images/aleppo.png",
    ),
    Landmark(
      description: "damas_slider_desc".tr, // ترجمة: "صوت التاريخ في أقدم عاصمة"
      imagePath: "assets/images/damas.png",
    ),
    Landmark(
      description: "mashqeta_slider_desc"
          .tr, // ترجمة: "حيث تعانق الغابات زُرقة البحيرات"
      imagePath: "assets/images/mashqeta.jpg",
    ),
  ];
}
