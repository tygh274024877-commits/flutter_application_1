import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/components/emergency_screen.dart';
import 'package:get/get.dart';
import '../../core/color/constants.dart';
import '../../models/menuItem.dart';
import '../components/shared/golden_widgets.dart';
import '../../core/localization/changelocal.dart';
import '../../controller/profile_controller.dart';
import 'weather_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    LocaleController localeController = Get.find();

    return Scaffold(
      backgroundColor: AppColors.waveGreen,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: AppLogo(height: 130),
            ),
            const SizedBox(height: 20),
            Obx(
              () => GoldenGradientWrapper(
                child: Text(
                  "${"welcome".tr}, ${profileController.userName.value.capitalizeFirst}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                // قمنا بتغيير الـ itemCount ليكون +2 (واحد للطقس وواحد للطوارئ)
                itemCount: menuItems.length + 2,
                itemBuilder: (context, index) {
                  // 1. عنصر الطقس
                  if (index == menuItems.length) {
                    return ListTile(
                      onTap: () => Get.to(
                        () => const WeatherScreen(),
                        transition: Transition.fadeIn,
                        duration: const Duration(milliseconds: 400),
                      ),
                      leading: const GoldenGradientWrapper(
                        child: Icon(
                          Icons.wb_sunny_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      title: Text(
                        'weather_status'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    );
                  }

                  // 2. عنصر خدمات الطوارئ
                  if (index == menuItems.length + 1) {
                    return ListTile(
                      onTap: () => Get.bottomSheet(
                        const EmergencyScreen(),
                        backgroundColor: Colors.transparent,
                      ),
                      leading: const GoldenGradientWrapper(
                        child: Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      title: Text(
                        'emergency_services'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    );
                  }

                  // 3. باقي عناصر القائمة الأساسية
                  final item = menuItems[index];
                  return ListTile(
                    onTap: () {
                      if (item.isLogout)
                        _showLogoutDialog();
                      else if (item.title == "language")
                        _showLanguageBottomSheet(context, localeController);
                      else
                        Get.toNamed(item.route);
                    },
                    leading: GoldenGradientWrapper(
                      child: Icon(item.icon, color: Colors.white, size: 28),
                    ),
                    title: Text(
                      item.title.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageBottomSheet(
    BuildContext context,
    LocaleController controller,
  ) {
    /* ... */
  }
  void _showLogoutDialog() {
    /* ... */
  }
}
