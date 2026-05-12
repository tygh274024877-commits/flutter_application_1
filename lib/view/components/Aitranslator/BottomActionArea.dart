import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/AiTransLator_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';

import 'package:get/get.dart';
import 'circleActionButton.dart';

class BottomActionArea extends GetView<AiTranslatorController> {
  const BottomActionArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleActionButton(
            icon: Icons.history,
            label: "History",
            onTap: () => _showHistorySheet(context),
          ),
          Obx(
            () => CircleActionButton(
              icon: controller.isListening.value ? Icons.graphic_eq : Icons.mic,
              label: "Voice",
              onTap: () => controller.toggleVoiceTranslation(),
              active: controller.isListening.value,
              isMain: true,
            ),
          ),
          CircleActionButton(
            icon: Icons.camera_alt,
            label: "Lens",
            onTap: () => controller.translateFromCamera(),
          ),
        ],
      ),
    );
  }

  void _showHistorySheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.hintGrey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recent History",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.BurntBrown,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_sweep_outlined,
                      color: Colors.redAccent,
                    ),
                    onPressed: () => controller.clearHistory(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.history.isEmpty) {
                  return const Center(
                    child: Text(
                      "Your history is empty",
                      style: TextStyle(color: AppColors.hintGrey),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: controller.history.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    final item = controller.history[index];

                    return Dismissible(
                      key: Key(item['time'] ?? index.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) =>
                          controller.deleteHistoryItem(index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(
                                0.08,
                              ), // لمسة خفيفة من لونك الأساسي
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['source'] ?? "",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Divider(
                                    height: 20,
                                    thickness: 0.5,
                                    color: AppColors.hintGrey.withOpacity(0.2),
                                  ),
                                  Text(
                                    item['target'] ?? "",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.BurntBrown,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                size: 20,
                                color: AppColors.hintGrey,
                              ),
                              onPressed: () =>
                                  controller.deleteHistoryItem(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
    );
  }
}
