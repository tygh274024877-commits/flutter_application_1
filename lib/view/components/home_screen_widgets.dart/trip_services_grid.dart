import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_shadows.dart';
import 'package:flutter_application_1/models/tripservices_Traslition.dart';
import 'package:get/get.dart';

class TripServicesSection extends StatelessWidget {
  const TripServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 180, // الارتفاع الذي ناسب تصميمك
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          return buildServiceCard(
            title: Services[index].title,
            imagePath: Services[index].imagepath,
            routepage: Services[index].routepage,
          );
        }, childCount: Services.length),
      ),
    );
  }
}

Widget buildServiceCard({
  required String title,
  required String imagePath,
  required String routepage,
}) {
  return InkWell(
    onTap: () {
      Get.toNamed(routepage);
    },
    child: Stack(
      children: [
        // 1. الصورة تأخذ حجم الكرت كامل
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: AppShadows.neumorphicShadow,
            border: Border.all(width: 3, color: Colors.white.withOpacity(0.9)),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover, // لتغطية الكرت بالكامل
            ),
          ),
        ),

        // 2. النص فوق الصورة في الأسفل (بدون أي خلفية سوداء)
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
            child: Text(
              title.tr,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 17, // الحجم الذي وجدناه ممتازاً
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333), // لون داكن واضح مثل الصورة
                height: 1.1,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
