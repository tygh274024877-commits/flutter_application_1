import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/serviceitems_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:get/get.dart'; // 👈 تعديل الـ import ليشمل كافة خصائص GetX ومنها .tr

class ServiceItemsScreen extends GetView<ServiceitemController> {
  const ServiceItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(
        () => GridView.builder(
          itemCount: controller.controller.currentItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final item = controller.controller.currentItems[index];
            return Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/damas.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      color: Colors.black54,
                      child: Text(
                        "${item['locationName']}".tr, // 👈 إضافة الترجمة
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item['name']}".tr, // 👈 إضافة الترجمة
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${item['description']}".tr, // 👈 إضافة الترجمة
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
