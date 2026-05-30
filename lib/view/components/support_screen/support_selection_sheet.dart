import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:get/get.dart';

class SupportSelectionSheet extends StatelessWidget {
  final String title;
  final List<Map<String, String>> options;
  final IconData icon;
  final Function(String) onActionSelected;

  const SupportSelectionSheet({
    super.key,
    required this.title,
    required this.options,
    required this.icon,
    required this.onActionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBrown,
            ),
          ),
          const SizedBox(height: 20),
          ...options.map(
            (opt) => ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Icon(icon, color: AppColors.primary, size: 20),
              ),
              title: Text(
                opt['label']!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {
                Get.back();
                onActionSelected(opt['value']!);
              },
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
