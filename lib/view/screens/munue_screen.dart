import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/color/constants.dart';
import '../../models/menuItem.dart';
import '../components/shared/golden_widgets.dart';
import '../../core/localization/changelocal.dart';
import '../../controller/profile_controller.dart'; // تأكدي من صحة المسار لديكِ

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ربط الشاشة بكنترولر البروفايل الموجود مسبقاً في الذاكرة
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
            // استخدام Obx لمراقبة تغير الاسم فوراً عند حفظ التعديلات
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
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return ListTile(
                    onTap: () {
                      if (item.isLogout) {
                        _showLogoutDialog();
                      } else if (item.title == "language") {
                        _showLanguageBottomSheet(context, localeController);
                      } else {
                        Get.toNamed(item.route);
                      }
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

  // دالة عرض خيارات تغيير اللغة
  void _showLanguageBottomSheet(
    BuildContext context,
    LocaleController controller,
  ) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "language".tr,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.language, color: AppColors.primary),
              title: const Text(
                "العربية",
                style: TextStyle(fontFamily: 'Cairo'),
              ),
              onTap: () {
                controller.changeLang("ar");
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.language, color: AppColors.primary),
              title: const Text(
                "English",
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              onTap: () {
                controller.changeLang("en");
                Get.back();
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // دالة تأكيد تسجيل الخروج
  void _showLogoutDialog() {
    Get.defaultDialog(
      title: "logout_title".tr,
      middleText: "logout_msg".tr,
      textConfirm: "yes".tr,
      textCancel: "no".tr,
      confirmTextColor: Colors.white,
      buttonColor: AppColors.primary,
      onConfirm: () => Get.offAllNamed('/login'),
    );
  }
}
