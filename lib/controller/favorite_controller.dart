import 'package:get/get.dart';
import 'package:flutter/material.dart';

// الموديل (تأكدي من وجوده في ملف الموديل أو ضعي الكلاس هنا)
class FavoriteModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  FavoriteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class FavoriteController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController rotationController;
  late AnimationController pulseController;
  late Animation<double> pulseAnimation;

  // القائمة التي سنستخدمها في الشاشة (ملاحظة: جعلتها كبيرة لاختبار السكرول)
  var favorites = <FavoriteModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    // تعبئة البيانات الوهمية
    favorites.addAll(
      List.generate(
        15,
        (index) => FavoriteModel(
          id: index,
          title: "وجهة سياحية مميزة ${index + 1}",
          description:
              "هذا النص تجريبي لوصف المكان والخدمات المتاحة في هذه الرحلة الرائعة.",
          imageUrl: "https://picsum.photos/id/${index + 10}/200/200",
        ),
      ),
    );

    // إعدادات الأنيميشن للهيدر
    rotationController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    pulseController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: pulseController, curve: Curves.easeInOut),
    );

    startAnimation();
  }

  void startAnimation() {
    if (!rotationController.isAnimating) rotationController.repeat();
    if (!pulseController.isAnimating) pulseController.repeat(reverse: true);
  }

  // الدالة التي تحذف العنصر عند الضغط على القلب
  void removeFromFavorites(int id) {
    favorites.removeWhere((element) => element.id == id);
  }

  @override
  void onClose() {
    rotationController.dispose();
    pulseController.dispose();
    super.onClose();
  }
}
