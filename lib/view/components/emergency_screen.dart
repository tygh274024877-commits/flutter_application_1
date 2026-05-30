import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/support_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:get/get.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SupportController controller = Get.find<SupportController>();

    // نستخدم مفاتيح الترجمة هنا
    final List<Map<String, String>> emergencyNumbers = [
      {"name": "ambulance".tr, "number": "110"},
      {"name": "rescue".tr, "number": "112"},
      {"name": "fire_department".tr, "number": "113"},
      {"name": "traffic_police".tr, "number": "115"},
      {"name": "civil_defense".tr, "number": "117"},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "emergency_services".tr,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "syria_emergency_note".tr,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontFamily: 'Cairo',
            ),
          ),
          const Divider(),
          ...emergencyNumbers
              .map(
                (item) => ListTile(
                  leading: const Icon(
                    Icons.phone_in_talk,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    "${item['name']}: ${item['number']}",
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () => controller.makeDirectCall(item['number']!),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
