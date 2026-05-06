import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/navigation_controllers.dart';
import 'package:flutter_application_1/view/screens/main_wapper.dart';
import 'package:get/get.dart';

import '../../core/color/constants.dart';
import '../../core/theme/app_shadows.dart';
import 'profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());

    return GetBuilder<NavigationController>(
      builder: (controller) {
        return Directionality(
          // الحفاظ على الاتجاه من اليسار دائماً كما طلبتِ
          textDirection: TextDirection.ltr,
          child: Scaffold(
            backgroundColor: AppColors.background,
            body: IndexedStack(
              index: controller.currentIndex,
              children: [
                const MainWrapper(),
                Center(
                  child: Text("ai_screen".tr), // ترجمة النص
                ),
                Center(
                  child: Text("favorites".tr), // ترجمة النص
                ),
                const ProfileScreen(),
              ],
            ),
            bottomNavigationBar: _buildBottomNav(controller),
          ),
        );
      },
    );
  }

  Widget _buildBottomNav(NavigationController controller) {
    const Color brandOrange = Color(0xFFD2775B);

    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        boxShadow: AppShadows.neumorphicShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navIcon(
            Icons.home_outlined,
            "home_label".tr,
            0,
            controller,
            brandOrange,
          ),
          _navIcon(
            Icons.psychology_outlined,
            "ai_label".tr,
            1,
            controller,
            brandOrange,
          ),
          _navIcon(
            Icons.favorite_border,
            "fav_label".tr,
            2,
            controller,
            brandOrange,
          ),
          _navIcon(
            Icons.person,
            "profile_label".tr,
            3,
            controller,
            brandOrange,
          ),
        ],
      ),
    );
  }

  Widget _navIcon(
    IconData icon,
    String label,
    int index,
    NavigationController controller,
    Color activeColor,
  ) {
    bool isActive = controller.currentIndex == index;
    return GestureDetector(
      onTap: () => controller.changePage(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isActive ? 30 : 28,
            color: isActive ? activeColor : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? activeColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
