import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/screens/AiTranslatorScreen.dart';
import 'package:flutter_application_1/view/screens/account_security_view.dart';
import 'package:flutter_application_1/view/screens/bottom_screen.dart';
import 'package:flutter_application_1/view/screens/login_screen.dart';
import 'package:flutter_application_1/view/screens/main_wapper.dart';
import 'package:flutter_application_1/view/screens/service_items_screen.dart';
import 'package:flutter_application_1/view/screens/servises_selection_screen.dart';
import 'package:flutter_application_1/view/screens/userprofile_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // إضافة المكتبة
import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';
import 'core/binding/app_binding.dart';
import 'view/screens/splash_screen.dart';
import 'view/screens/signup_screen.dart';
import 'view/screens/password_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // غزل، هذا السطر هو المسؤول عن تفعيل الحفظ الدائم في جهازك
  await GetStorage.init();

  LocaleController controller = Get.put(LocaleController());
  await controller.checkInitialLang();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TripMate',
      translations: MyTranslation(),
      locale: Get.find<LocaleController>().language,
      fallbackLocale: const Locale("en"),
      initialBinding: AppBinding(),
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignupScreen()),
        GetPage(name: '/password', page: () => const PasswordScreen()),
        GetPage(name: '/bottom', page: () => const MainScreen()),
        GetPage(name: '/home', page: () => const MainWrapper()),
        GetPage(name: '/user_profile', page: () => const UserProfileScreen()),
        GetPage(name: '/security', page: () => const AccountSecurityView()),
        GetPage(name: "/servicesselect", page: () => const ServiceSelection()),
        GetPage(
          name: "/serviceitemsscreen",
          page: () => const ServiceItemsScreen(),
        ),
        GetPage(name: "/translator_ai", page: () => AiTranslatorScreen()),
        //GetPage(name: "/gemini_chat", page: () => const GeminiChatScreen()),
      ],
    );
  }
}
