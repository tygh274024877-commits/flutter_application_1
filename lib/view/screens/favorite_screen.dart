import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:flutter_application_1/controller/favorite_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavoriteController controller = Get.put(FavoriteController());
    controller.startAnimation();

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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // --- الهيدر (Stack) ---
            Container(
              width: double.infinity,
              height: 250,
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
                  GetBuilder<FavoriteController>(
                    builder: (controller) => ScaleTransition(
                      scale: controller.pulseAnimation,
                      child: const Icon(
                        Icons.favorite,
                        color: Color(0xFFE5C78B),
                        size: 70,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- العنوان والفاصل ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Favorites",
                style: TextStyle(
                  color: AppColors.BurntBrown,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Divider(
                color: AppColors.BurntBrown.withOpacity(0.15),
                thickness: 1.2,
              ),
            ),

            // --- القائمة (ListView) ---
            Expanded(
              child: Obx(
                () => ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  itemCount: controller.favorites.length,
                  itemBuilder: (context, index) {
                    return FavoriteCard(item: controller.favorites[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // الدوال المساعدة للهيدر
  Widget _buildArtifactInTrail({
    required double progress,
    required int index,
    required String icon,
    required int totalItems,
  }) {
    final double anglePosition = (index * 2 * math.pi / totalItems);
    const double dynamicRadius = 90.0;
    final double currentAngle = (progress * 2 * math.pi) + anglePosition;

    return Transform.translate(
      offset: Offset(
        dynamicRadius * math.cos(currentAngle),
        dynamicRadius * math.sin(currentAngle),
      ),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFD2775B).withOpacity(0.3),
        ),
        child: Text(icon, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget _buildGlowBase({
    required double animationValue,
    required Color baseColor,
    required double maxScale,
  }) {
    final double opacity = (1.0 - animationValue).clamp(0.0, 1.0);
    final double scale = 1.0 + (animationValue * (maxScale - 1.0));
    return Opacity(
      opacity: opacity,
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: 120,
          height: 120,
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

// --- ويدجيت الكرت المطوّر (بدون Overflow) ---
class FavoriteCard extends StatelessWidget {
  final dynamic item;
  final FavoriteController controller = Get.find();

  FavoriteCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFC5A358), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.BurntBrown.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            print("Going to details: ${item.title}");
          },
          child: Row(
            children: [
              Container(
                width: 110,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: const Icon(Icons.image, color: Colors.grey),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.BurntBrown,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "اضغط للتفاصيل",
                        style: TextStyle(
                          color: AppColors.BurntBrown.withOpacity(0.5),
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite, color: Color(0xFFC5A358)),
                onPressed: () => controller.removeFromFavorites(item.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
