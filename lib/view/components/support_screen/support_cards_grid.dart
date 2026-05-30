import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/support_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:flutter_application_1/core/theme/app_shadows.dart';
import 'package:flutter_application_1/view/components/support_screen/support_card.dart';
import 'package:flutter_application_1/view/screens/complaint_screen.dart';
import 'package:flutter_application_1/view/screens/faq_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SupportCardsGrid extends StatelessWidget {
  final SupportController controller;

  const SupportCardsGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 1200),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 80.0,
                child: FadeInAnimation(child: widget),
              ),
              children: [
                SupportCard(
                  title: "faq_card".tr, // تعديل هنا
                  icon: Icons.quiz_outlined,
                  onTap: () => Get.to(() => const FAQScreen()),
                ),
                SupportCard(
                  title: "complaints_card".tr, // تعديل هنا
                  icon: Icons.report_problem_outlined,
                  onTap: () => Get.to(() => ComplaintScreen()),
                ),
                SupportCard(
                  title: "whatsapp_card".tr, // تعديل هنا
                  icon: Icons.chat_bubble_outline_rounded,
                  onTap: () => controller.showWhatsAppOptions(),
                ),
                SupportCard(
                  title: "phone_card".tr, // تعديل هنا
                  icon: Icons.phone_in_talk_outlined,
                  onTap: () => controller.showPhoneOptions(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // الكرت الخامس - مستطيل عرضي
          AnimationConfiguration.staggeredList(
            position: 4,
            duration: const Duration(milliseconds: 1200),
            child: SlideAnimation(
              horizontalOffset: 80.0,
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () => Get.toNamed('/feedback'),
                  child: Container(
                    width: double.infinity,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: AppShadows.neumorphicShadow,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.rate_review_outlined,
                          size: 35,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          "user_reviews".tr, // تعديل هنا
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
