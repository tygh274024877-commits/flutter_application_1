import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/components/support_screen/support_selection_sheet.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/color/constants.dart';

class SupportController extends GetxController {
  // أوقات العمل
  final int startHour = 9;
  final int endHour = 22;

  // أرقام التواصل
  final String phone1 = "0994483677";
  final String phone2 = "0935728767";

  // فحص إذا كان الوقت الحالي ضمن دوام الفريق
  bool isWorkTime() {
    int currentHour = DateTime.now().hour;
    return currentHour >= startHour && currentHour < endHour;
  }

  // دالة الاتصال المباشر للطوارئ (لا تخضع لشروط وقت العمل)
  Future<void> makeDirectCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showErrorSnack("error_title".tr, "app_open_error_msg".tr);
    }
  }

  // دالة تشغيل الروابط (للشكاوى والواتساب فقط)
  Future<void> launchAction(String url) async {
    if (!isWorkTime()) {
      _showErrorSnack("work_time_sorry_title".tr, "work_time_sorry_msg".tr);
      return;
    }
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication)) {
      _showErrorSnack("error_title".tr, "app_open_error_msg".tr);
    }
  }

  // عرض تنبيه ملون بستايل التطبيق مع الإيموجيات ⚠️ ⏱️
  void _showErrorSnack(String title, String msg) {
    Get.snackbar(
      "⚠️ $title",
      "$msg ⏱️",
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(15),
    );
  }

  // خيارات الواتساب
  void showWhatsAppOptions() {
    _openSheet("whatsapp_sheet_title".tr, Icons.chat_outlined, [
      {
        "label": "${"first_number".tr} ($phone1)",
        "value": "whatsapp://send?phone=+963${phone1.substring(1)}",
      },
      {
        "label": "${"second_number".tr} ($phone2)",
        "value": "whatsapp://send?phone=+963${phone2.substring(1)}",
      },
    ]);
  }

  // خيارات الاتصال المباشر
  void showPhoneOptions() {
    _openSheet("phone_sheet_title".tr, Icons.phone_android_outlined, [
      {
        "label": "${"first_number".tr} ($phone1)",
        "value": "tel:+963${phone1.substring(1)}",
      },
      {
        "label": "${"second_number".tr} ($phone2)",
        "value": "tel:+963${phone2.substring(1)}",
      },
    ]);
  }

  // معالجة وإرسال الشكاوى
  void showComplaintOptions(String complaintText) {
    if (complaintText.trim().isEmpty) {
      _showErrorSnack("warning_title".tr, "complaint_empty_msg".tr);
      return;
    }
    _openSheet("complaint_sheet_title".tr, Icons.send_rounded, [
      {
        "label": "${"first_number".tr} ($phone1)",
        "value":
            "whatsapp://send?phone=+963${phone1.substring(1)}&text=${Uri.encodeComponent(complaintText)}",
      },
      {
        "label": "${"second_number".tr} ($phone2)",
        "value":
            "whatsapp://send?phone=+963${phone2.substring(1)}&text=${Uri.encodeComponent(complaintText)}",
      },
    ]);
  }

  // دالة خاصة لفتح الـ BottomSheet لتقليل تكرار الكود
  void _openSheet(
    String title,
    IconData icon,
    List<Map<String, String>> options,
  ) {
    Get.bottomSheet(
      SupportSelectionSheet(
        title: title,
        icon: icon,
        options: options,
        onActionSelected: (value) => launchAction(value),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }
}
