import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/navigation_controllers.dart';
import 'package:flutter_application_1/view/screens/assistant_screen.dart';
import 'package:flutter_application_1/view/screens/main_wapper.dart';
import 'package:get/get.dart';

import '../../core/color/constants.dart' hide AppColors;
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
          textDirection: TextDirection.ltr,
          child: Scaffold(
            backgroundColor: AppColors.background,
            body: IndexedStack(
              index: controller.currentIndex,
              children: [
                /// Home
                const MainWrapper(),

                /// AI Assistant Screen
                const AiAssistantHomeScreen(),

                /// Favorites
                Center(child: Text("favorites".tr)),

                /// Profile
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
      height: 80,
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
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: EdgeInsets.all(isActive ? 8 : 0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? activeColor.withOpacity(0.15)
                  : Colors.transparent,
            ),
            child: Icon(
              icon,
              size: isActive ? 28 : 26,
              color: isActive ? activeColor : Colors.grey,
            ),
          ),

          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? activeColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
