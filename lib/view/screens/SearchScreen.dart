import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controller/search_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart'; // تأكدي من مسار ملف الألوان لديك
import 'package:flutter_application_1/core/theme/app_shadows.dart'; // تأكدي من مسار ملف الظلال لديك

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // تعريف الكونترولر
    final GlobalSearchController controller = Get.put(GlobalSearchController());

    return Scaffold(
      backgroundColor: AppColors.background, // استخدام الخلفية الكريمية
      body: SafeArea(
        child: Column(
          children: [
            // 1. شريط البحث
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Hero(
                tag: "search_bar_hero",
                child: Material(
                  color: Colors.transparent,
                  child: TextField(
                    autofocus: true,
                    onChanged: (val) => controller.onSearchChanged(val),
                    decoration: InputDecoration(
                      hintText: "ابحث عن فنادق، مطاعم، معالم...",
                      hintStyle: TextStyle(color: AppColors.hintGrey),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.primary,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 2. النتائج
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          _buildCategorySection("الفنادق", controller.hotels),
                          _buildCategorySection(
                            "المطاعم",
                            controller.restaurants,
                          ),
                          _buildCategorySection(
                            "المعالم الأثرية",
                            controller.landmarks,
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String title, RxList list) {
    if (list.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlack,
            ),
          ),
        ),
        ...list.map(
          (item) => Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(20),
              boxShadow: AppShadows.neumorphicShadow,
              border: Border.all(color: AppColors.lightGolden, width: 1.5),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              title: Text(
                item.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.darkBlack,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  item.location,
                  style: TextStyle(
                    color: AppColors.darkBlack.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ),
              trailing: const Icon(
                Icons.arrow_back_ios, // السهم الموجه لليمين (للعربية)
                size: 16,
                color: AppColors.lightGolden,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
