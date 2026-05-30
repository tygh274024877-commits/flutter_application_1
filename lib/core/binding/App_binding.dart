import 'package:flutter_application_1/controller/PaymentController.dart';
import 'package:flutter_application_1/controller/favorite_controller.dart';
import 'package:flutter_application_1/core/class/crud.dart';
import 'package:get/get.dart';

// --- استيراد جميع الكونترولات من مجلد controller الخاص بمشروعكِ TripMate ---
import 'package:flutter_application_1/controller/account_security_controller.dart';
import 'package:flutter_application_1/controller/assistant_controller.dart';
import 'package:flutter_application_1/controller/AiTransLator_controller.dart';
import 'package:flutter_application_1/controller/ChatController.dart';
import 'package:flutter_application_1/controller/ChatDrawerController.dart';
import 'package:flutter_application_1/controller/chat_history_controller.dart';

import 'package:flutter_application_1/controller/feedback_controller.dart';
import 'package:flutter_application_1/controller/home_controller.dart';
import 'package:flutter_application_1/controller/login_controller.dart';
import 'package:flutter_application_1/controller/mainwapper_controller.dart';
import 'package:flutter_application_1/controller/navigation_controllers.dart';
import 'package:flutter_application_1/controller/password_controller.dart';
import 'package:flutter_application_1/controller/profile_controller.dart';
import 'package:flutter_application_1/controller/rating_controller.dart';
import 'package:flutter_application_1/controller/serviceitems_controller.dart';
import 'package:flutter_application_1/controller/service_selection_controller.dart';
import 'package:flutter_application_1/controller/signup_controller.dart';
import 'package:flutter_application_1/controller/slider_controller.dart';
import 'package:flutter_application_1/controller/splash_controller.dart';
import 'package:flutter_application_1/controller/support_controller.dart';
import 'package:flutter_application_1/controller/userprofile_controller.dart';
import 'package:flutter_application_1/controller/voice_and_animation_controller.dart';
import 'package:flutter_application_1/controller/weather_controller.dart';
import 'package:flutter_application_1/controller/search_controller.dart';

// استيراد كونترول اللغة الأساسي والمشترك
import 'package:flutter_application_1/core/localization/changelocal.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // 1. الأساسيات واللغة والـ Splash (يتم إنشاؤها فوراً وبشكل دائم)
    Get.put(LocaleController(), permanent: true);
    Get.put(SplashController());

    // 2. كونترولات نظام الواجهات والملاحة والتنقل (Navigation & UI)
    Get.lazyPut(() => NavigationController(), fenix: true);
    Get.lazyPut(() => MainWrapperController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => SliderController(), fenix: true);

    // 3. كونترولات نظام الحسابات والمصادقة والأمان (Auth, Profile & Security)
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => SignupController(), fenix: true);
    Get.lazyPut(() => PasswordController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => UserProfileController(), fenix: true);
    Get.lazyPut(() => AccountSecurityController(), fenix: true);

    // 4. كونترولات الخدمات، العناصر، المفضلات والطقس (Services & Features)
    Get.lazyPut<ServicesselectController>(
      () => ServicesselectController(),
      fenix: true,
    );
    Get.lazyPut<ServiceitemController>(
      () => ServiceitemController(),
      fenix: true,
    );
    Get.lazyPut(() => FavoriteController(), fenix: true);
    Get.lazyPut(() => WeatherController(), fenix: true);

    // 5. كونترولات الذكاء الاصطناعي، الروبوت والمحادثات (AI, Gemini Chat & Voice)
    Get.lazyPut(() => AiTranslatorController(), fenix: true);
    Get.lazyPut<AiAssistantController>(
      () => AiAssistantController(),
      fenix: true,
    );
    Get.lazyPut(() => ChatController(), fenix: true);
    Get.lazyPut(() => ChatDrawerController(), fenix: true);
    Get.lazyPut(() => ChatHistoryController(), fenix: true);
    Get.lazyPut(() => VoiceAndAnimationController(), fenix: true);

    // 6. كونترولات التقييمات، الآراء، الدعم الفني والشكاوى (Feedback & Support)
    Get.lazyPut(() => FeedbackController(), fenix: true);
    Get.lazyPut(() => RatingController(), fenix: true);
    Get.lazyPut(() => SupportController(), fenix: true);
    Get.lazyPut(() => GlobalSearchController(), fenix: true);
    Get.lazyPut<PaymentController>(() => PaymentController());
    Get.put(Crud());
  }
}
