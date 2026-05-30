import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 1. الموديل (Favorite Model)
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

// 2. الكنترولر (Favorite Controller)
class FavoriteController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController rotationController;
  late AnimationController pulseController;
  late Animation<double> pulseAnimation;

  // قائمة بيانات وهمية كثيرة لاختبار السكرول
  var favorites = <FavoriteModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    // إنشاء 15 كرت وهمي
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

// 3. الشاشة الرئيسية (Favorite Screen)
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  // تعريف الألوان كمتغيرات ثابتة لسهولة الاستخدام
  static const Color burntBrown = Color(0xFF65554E);
  static const Color goldenColor = Color(0xFFC5A358);
  static const Color bgColor = Color(0xFFF9F6F2); // لون خلفية هادئ

  @override
  Widget build(BuildContext context) {
    final FavoriteController controller = Get.put(FavoriteController());
    final List<String> travelItems = [
      "🏛️",
      "🌊",
      "🌳",
      "🏨",
      "🚕",
      "✈️",
      "🏰",
      "🏔️",
    ];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // الهيدر مع الأنيميشن
            Container(
              width: double.infinity,
              height: 280,
              color: Colors.transparent,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedBuilder(
                    animation: controller.rotationController,
                    builder: (context, child) {
                      final double progress =
                          controller.rotationController.value;
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          _buildGlowBase(
                            animationValue: progress,
                            baseColor: const Color(0xFFD2775B).withOpacity(0.2),
                            maxScale: 2.0,
                          ),
                          ...travelItems.asMap().entries.map((entry) {
                            return _buildArtifactInTrail(
                              progress: progress,
                              index: entry.key,
                              icon: entry.value,
                              totalItems: travelItems.length,
                            );
                          }).toList(),
                        ],
                      );
                    },
                  ),
                  ScaleTransition(
                    scale: controller.pulseAnimation,
                    child: const Icon(
                      Icons.favorite,
                      color: Color(0xFFE5C78B),
                      size: 80,
                      shadows: [Shadow(color: goldenColor, blurRadius: 15)],
                    ),
                  ),
                ],
              ),
            ),

            // العنوان
            const Text(
              "MY FAVORITES",
              style: TextStyle(
                color: burntBrown,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Divider(color: burntBrown.withOpacity(0.2), thickness: 1),
            ),

            // قائمة الكروت الكبيرة مع سكرول
            Expanded(
              child: Obx(
                () => ListView.builder(
                  physics: const BouncingScrollPhysics(), // سكرول ناعم
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: controller.favorites.length,
                  itemBuilder: (context, index) {
                    final item = controller.favorites[index];
                    return _buildLargeFavoriteCard(item, controller);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ويدجيت الكرت الكبير
  Widget _buildLargeFavoriteCard(
    FavoriteModel item,
    FavoriteController controller,
  ) {
    return Container(
      height: 120, // تكبير ارتفاع الكرت
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: goldenColor, width: 1.5), // إطار ذهبي
        boxShadow: [
          BoxShadow(
            color: burntBrown.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 8), // ظل بني
          ),
        ],
      ),
      child: Row(
        children: [
          // الصورة
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(item.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // المعلومات
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: burntBrown,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: burntBrown.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // زر الحذف (القلب)
          IconButton(
            icon: const Icon(Icons.favorite, color: goldenColor, size: 30),
            onPressed: () {
              controller.removeFromFavorites(item.id);
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  // دالة العناصر الدوارة
  Widget _buildArtifactInTrail({
    required double progress,
    required int index,
    required String icon,
    required int totalItems,
  }) {
    final double anglePosition = (index * 2 * math.pi / totalItems);
    const double dynamicRadius = 100.0;
    final double currentAngle = (progress * 2 * math.pi) + anglePosition;

    return Transform.translate(
      offset: Offset(
        dynamicRadius * math.cos(currentAngle),
        dynamicRadius * math.sin(currentAngle),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFD2775B).withOpacity(0.2),
        ),
        child: Text(icon, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  // دالة توهج القاعدة
  Widget _buildGlowBase({
    required double animationValue,
    required Color baseColor,
    required double maxScale,
  }) {
    return Opacity(
      opacity: (1.0 - animationValue).clamp(0.0, 1.0),
      child: Transform.scale(
        scale: 1.0 + (animationValue * (maxScale - 1.0)),
        child: Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [baseColor, baseColor.withOpacity(0.0)],
            ),
          ),
        ),
      ),
    );
  }
}
