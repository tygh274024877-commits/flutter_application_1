import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/screens/PaymentScreen.dart';
import 'package:flutter_application_1/view/screens/SearchScreen.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';

// --- استيراد الـ 22 سكرين بالكامل من مجلد screens الخاص بكِ ---
import 'package:flutter_application_1/view/screens/splash_screen.dart';
import 'package:flutter_application_1/view/screens/login_screen.dart';
import 'package:flutter_application_1/view/screens/signup_screen.dart';
import 'package:flutter_application_1/view/screens/password_screen.dart';
import 'package:flutter_application_1/view/screens/bottom_screen.dart';
import 'package:flutter_application_1/view/screens/main_wapper.dart';
import 'package:flutter_application_1/view/screens/home_screen.dart';
import 'package:flutter_application_1/view/screens/userprofile_screen.dart';
import 'package:flutter_application_1/view/screens/profile_screen.dart';
import 'package:flutter_application_1/view/screens/account_security_view.dart';
import 'package:flutter_application_1/view/screens/munue_screen.dart';
import 'package:flutter_application_1/view/screens/servises_selection_screen.dart';
import 'package:flutter_application_1/view/screens/service_items_screen.dart';
import 'package:flutter_application_1/view/screens/assistant_screen.dart';
import 'package:flutter_application_1/view/screens/AiTranslatorScreen.dart';
import 'package:flutter_application_1/view/screens/Smart_ChatScreen.dart';
import 'package:flutter_application_1/view/screens/feedback_screen.dart';
import 'package:flutter_application_1/view/screens/complaint_screen.dart';
import 'package:flutter_application_1/view/screens/faq_screen.dart';
import 'package:flutter_application_1/view/screens/favorite_screen.dart';
import 'package:flutter_application_1/view/screens/support_screen.dart';
import 'package:flutter_application_1/view/screens/weather_screen.dart';

// --- استيراد الترجمة واللغات والبايدنغ الرئيسي ---
import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';
import 'core/binding/App_binding.dart';

void main() async {
  // تأمين ربط ويدجت فلاتر قبل استدعاء أي كود خارجي
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // تحميل ملف الـ env قبل تشغيل التطبيق
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Error loading .env file: $e");
  }

  // تهيئة اللغة العربية للتواريخ (تمنع الكراش في كروت الطقس)
  await initializeDateFormatting('ar', null);

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

      // حقن البايدنغ الموحد الشامل لكل الـ 21 كونترول دفعة واحدة
      initialBinding: AppBinding(),

      getPages: [
        // 1. صفحات البداية والمصادقة (Auth & Splash)
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignupScreen()),
        GetPage(name: '/password', page: () => const PasswordScreen()),

        // 2. الشاشات الرئيسية والتنقل (Main & Navigation)
        GetPage(name: '/bottom', page: () => const MainScreen()),
        GetPage(name: '/home', page: () => const MainWrapper()),
        GetPage(name: '/home_view', page: () => const HomeScreen()),
        GetPage(name: '/menu', page: () => const MenuScreen()),

        // 3. صفحات الملف الشخصي والأمان (Profile & Security)
        GetPage(name: '/user_profile', page: () => const UserProfileScreen()),
        GetPage(name: '/profile_view', page: () => const ProfileScreen()),
        GetPage(name: '/security', page: () => const AccountSecurityView()),

        // 4. صفحات الخدمات وعناصرها (Services)
        GetPage(name: "/servicesselect", page: () => const ServiceSelection()),
        GetPage(
          name: "/serviceitemsscreen",
          page: () => const ServiceItemsScreen(),
        ),
        GetPage(name: '/favorite', page: () => const FavoriteScreen()),
        GetPage(name: '/weather', page: () => const WeatherScreen()),

        // 5. صفحات الذكاء الاصطناعي والمحادثات الذكية (AI Features)
        GetPage(name: '/assistant', page: () => const AiAssistantHomeScreen()),
        GetPage(name: "/translator_ai", page: () => AiTranslatorScreen()),
        GetPage(
          name: "/gemini_chat",
          page: () => SmartChatScreen(),
          transition: Transition.rightToLeftWithFade,
          transitionDuration: const Duration(milliseconds: 500),
        ),

        // 6. صفحات الدعم والآراء والشكاوى (Support & Feedback)
        GetPage(name: "/feedback", page: () => const FeedbackScreen()),
        GetPage(name: '/complaint', page: () => ComplaintScreen()),
        GetPage(name: '/faq', page: () => const FAQScreen()),
        GetPage(name: '/support', page: () => const SupportScreen()),
        // في قائمة الـ getPages، أضيفي هذا السطر فقط:
        GetPage(name: '/search', page: () => const SearchScreen()),
        GetPage(name: '/payment', page: () => const PaymentScreen()),
        // GetPage(name: '/card_payment', page: () => const CardPaymentScreen()), // استبدلي بالصفحة الفعلية
        //GetPage(name: '/bank_transfer', page: () => const BankTransferScreen()), // استبدلي بالصفحة الفعلية
      ],
    );
  }
}
