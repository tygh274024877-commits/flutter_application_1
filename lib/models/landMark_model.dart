import 'package:get/get.dart';

// الكلاسات كما هي لديكِ
class Landmark {
  final String description;
  final String imagePath;
  Landmark({required this.description, required this.imagePath});
}

class LandmarkModel {
  final int id;
  final String name;
  final String imagePath;
  final String description;
  final String fullDetail;

  LandmarkModel({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.description,
    required this.fullDetail,
  });
}

class LandmarkData {
  // تحويل القائمة الأولى إلى Getter لضمان تحديث الترجمة فوراً
  static List<Landmark> get sliderLandmarks => [
    Landmark(
      description: "slider_desc_1".tr,
      imagePath: "assets/images/aleppo.png",
    ),
    Landmark(
      description: "slider_desc_2".tr,
      imagePath: "assets/images/damas.png",
    ),
    Landmark(
      description: "slider_desc_3".tr,
      imagePath: "assets/images/mashqeta.jpg",
    ),
  ];

  // تحويل القائمة الثانية إلى Getter لضمان تحديث الترجمة فوراً
  static List<LandmarkModel> get exploreList => [
    LandmarkModel(
      id: 1,
      name: "aleppo_citadel_name".tr,
      imagePath: "assets/images/aleppo_castle.png",
      description: "aleppo_citadel_desc".tr,
      fullDetail: "aleppo_citadel_detail".tr,
    ),
    LandmarkModel(
      id: 2,
      name: "palmyra_name".tr,
      imagePath: "assets/images/aleppo_castle.png",
      description: "palmyra_desc".tr,
      fullDetail: "palmyra_detail".tr,
    ),
    LandmarkModel(
      id: 3,
      name: "umayyad_mosque_name".tr,
      imagePath: "assets/images/aleppo_castle.png",
      description: "umayyad_mosque_desc".tr,
      fullDetail: "umayyad_mosque_detail".tr,
    ),
    LandmarkModel(
      id: 4,
      name: "krak_des_chevaliers_name".tr,
      imagePath: "assets/images/aleppo_castle.png",
      description: "krak_des_chevaliers_desc".tr,
      fullDetail: "krak_des_chevaliers_detail".tr,
    ),
  ];
}
