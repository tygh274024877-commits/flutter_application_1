import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/color/constants.dart';
import '../../controller/support_controller.dart';
import 'package:flutter_application_1/models/faq_model.dart';

class FAQScreen extends GetView<SupportController> {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = FAQModel.faqList;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "الأسئلة الشائعة".tr, // 👈 إضافة الترجمة هنا
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
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: AppColors.primary.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                iconColor: AppColors.primary,
                collapsedIconColor: AppColors.earthyBrown,
                title: Text(
                  faqs[index].question.tr, // 👈 ترجمة السؤال الداخلي
                  style: const TextStyle(
                    color: AppColors.darkBrown,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 15,
                    ),
                    child: Text(
                      faqs[index].answer.tr, // 👈 ترجمة الجواب الداخلي
                      style: const TextStyle(
                        color: AppColors.earthyBrown,
                        height: 1.5,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
