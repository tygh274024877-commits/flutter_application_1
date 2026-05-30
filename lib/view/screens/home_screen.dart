import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/home_controller.dart';
import 'package:flutter_application_1/controller/mainwapper_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:flutter_application_1/core/theme/app_shadows.dart';
import 'package:flutter_application_1/view/components/home_screen_widgets.dart/trip_services_grid.dart';
import 'package:flutter_application_1/view/components/shared/waveheader.dart';
import 'package:flutter_application_1/view/components/shared/custom_search_bar.dart';
import 'package:flutter_application_1/view/components/shared/experience_syria_slider.dart';
import 'package:flutter_application_1/view/components/shared/golden_widgets.dart';
import 'package:flutter_application_1/view/screens/SearchScreen.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key}); // إضافة الـ Key للكونستركتور

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. الهيدر والسيرش بار
          SliverToBoxAdapter(
            child: SizedBox(
              height: 230,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const WaveHeader(),
                  Positioned(
                    top: 30,
                    // استخدمنا start لضمان توافقها مع اليمين واليسار تلقائياً
                    left: 10,
                    child: GoldenGradientWrapper(
                      child: IconButton(
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: Colors.white,
                          size: 35,
                        ),
                        onPressed: () {
                          MainWrapperController.instance.toggleDrawer();
                        },
                      ),
                    ),
                  ),
                  // ... داخل الـ Stack في الـ HomeScreen
                  Positioned(
                    top: 160,
                    right: 30,
                    left: 30,
                    // هذا هو المكان الجديد للـ CustomSearchBar المدموجة
                    child: CustomSearchBar(
                      onTap: () => Get.toNamed('/search'),
                      text: "search_hint".tr,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. قسم الخدمات (TripServicesSection)
          const TripServicesSection(),

          // 3. قسم السلايدر والوجهات المميزة
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 10),
                ExperienceSyriaSlider(
                  sliderData: controller.sliderController.sliderLandmarks,
                  showText: true,
                  controller: controller,
                ),
                const SizedBox(height: 20),
                _buildSectionHeader("featured_dest"), // نمرر المفتاح هنا
                // قائمة الوجهات
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.exploreList.length,
                    itemBuilder: (context, index) {
                      final destination = controller.exploreList[index];
                      return _buildDestinationCard(destination);
                    },
                  ),
                ),
              ],
            ),
          ),

          const SliverPadding(padding: EdgeInsets.only(bottom: 120)),
        ],
      ),
    );
  }

  // دالة مساعدة لبناء رأس القسم (Header) مترجم
  Widget _buildSectionHeader(String titleKey) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleKey.tr, // مترجم
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Poppins",
              color: AppColors.black.withOpacity(0.7),
              fontWeight: FontWeight.w700,
            ),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "see_all".tr, // مترجم
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationCard(dynamic destination) {
    return Container(
      width: 140,
      margin: const EdgeInsetsDirectional.only(
        end: 15,
        bottom: 15,
        top: 5,
      ), // محاذاة مرنة
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.neumorphicShadow,
        color: AppColors.background,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                destination.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              destination
                  .name, // هذا الاسم عادة يأتي من الموديل (يحتاج ترجمة داخل الموديل إذا أردت)
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
