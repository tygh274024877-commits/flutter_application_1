import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/components/support_screen/complaint_text_field.dart';
import 'package:flutter_application_1/view/components/support_screen/submit_complaint_button.dart';
import 'package:get/get.dart';
import '../../core/color/constants.dart';
import '../../controller/support_controller.dart';

class ComplaintScreen extends GetView<SupportController> {
  ComplaintScreen({super.key});

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "تقديم شكوى".tr, // 👈 إضافة الترجمة
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "نحن هنا لنسمعك..".tr, // 👈 إضافة الترجمة
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBrown,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "يرجى شرح المشكلة التي واجهتها وسيقوم فريق TripMate بمتابعتها فوراً عبر اختيار أحد أرقامنا."
                  .tr, // 👈 إضافة الترجمة
              style: const TextStyle(color: Colors.grey, height: 1.4),
            ),
            const SizedBox(height: 30),

            ComplaintTextField(controller: _textController),

            const SizedBox(height: 30),

            SubmitComplaintButton(
              onPressed: () =>
                  controller.showComplaintOptions(_textController.text),
            ),

            const SizedBox(height: 25),

            Center(
              child: TextButton.icon(
                onPressed: () => controller.showPhoneOptions(),
                icon: const Icon(
                  Icons.phone_in_talk_outlined,
                  color: AppColors.earthyBrown,
                ),
                label: Text(
                  "أو تفضل بالاتصال بنا مباشرة".tr, // 👈 إضافة الترجمة
                  style: const TextStyle(
                    color: AppColors.earthyBrown,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
