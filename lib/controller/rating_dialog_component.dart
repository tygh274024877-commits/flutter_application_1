import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'rating_controller.dart';

class RatingDialogComponent extends StatelessWidget {
  final RatingController controller;

  const RatingDialogComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "rating_question".tr,
              style: const TextStyle(
                color: RatingController.earthyBrown,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              "rating_subtitle".tr,
              style: const TextStyle(
                color: RatingController.earthyBrown,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),

            // صف النجوم بالأنيميشن المزدوج
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  int starValue = index + 1;
                  bool isSelected =
                      starValue <= controller.selectedRating.value;
                  bool isClicked = controller.animatedStarIndex.value == index;

                  double scale = isClicked ? 1.4 : (isSelected ? 1.1 : 1.0);
                  double turns = isClicked ? 1.0 : 0.0;

                  return GestureDetector(
                    onTap: () => controller.handleStarTap(index, starValue),
                    child: AnimatedRotation(
                      turns: turns,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutBack,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        transform: Matrix4.identity()..scale(scale),
                        transformAlignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          isSelected
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          size: 44,
                          color: RatingController.customOrange,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 30),

            // أزرار التحكم بالدايلوج
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    "cancel".tr,
                    style: const TextStyle(
                      color: RatingController.earthyBrown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RatingController.customOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                  ),
                  // 💡 تعديل: مررنا الـ context هنا
                  onPressed: () => controller.submitRating(context),
                  child: Text(
                    "send".tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
