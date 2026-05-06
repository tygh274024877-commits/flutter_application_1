import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/favorite_controller.dart';
import '../components/shared/custom_widgets.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FavoriteController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const TopHeaderActions(),
          const Text(
            "الأماكن المفضلة",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.favItems.length,
                itemBuilder: (context, index) => ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.red),
                  title: Text(controller.favItems[index]),
                ),
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
