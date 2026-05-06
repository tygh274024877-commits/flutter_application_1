import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/controller/serviceitems_controller.dart';

import 'package:flutter_application_1/core/color/constants.dart';
import 'package:get/state_manager.dart';

class ServiceItemsScreen extends GetView<ServiceitemController> {
  const ServiceItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(
        () => GridView.builder(
          itemCount: controller.controller.currentItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final item = controller.controller.currentItems[index];
            return Container(
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 25),
              padding: EdgeInsets.symmetric(vertical: 20),
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
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      color: Colors.black54,
                      child: Text(
                        item['locationName'],
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          item['description'],
                          maxLines: 2, // 👈 عرض سطرين فقط لتوفير المساحة
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
