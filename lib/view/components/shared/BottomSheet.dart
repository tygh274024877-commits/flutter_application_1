import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/support_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:get/get.dart';

class SelectionBottomSheet extends GetView<SupportController> {
  final String title;
  final Function(String) onSelect;

  const SelectionBottomSheet({
    super.key,
    required this.title,
    required this.onSelect,
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
          // الخط الرمادي الصغير فوق
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

          // الرقم الأول
          _buildOptionTile(context, controller.phone1),

          const SizedBox(height: 10),

          // الرقم الثاني
          _buildOptionTile(context, controller.phone2),

          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildOptionTile(BuildContext context, String phone) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Color(0xFFFDF5F2), // لون فاتح من هويتك
        child: Icon(Icons.phone_android_outlined, color: AppColors.primary),
      ),
      title: Text(
        "رقم التواصل ($phone)",
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      onTap: () {
        Get.back(); // إغلاق الشيت
        onSelect(phone); // تنفيذ الأكشن (سواء واتساب أو اتصال)
      },
    );
  }
}
