import 'package:flutter_application_1/controller/account_security_controller.dart';
import 'package:flutter_application_1/controller/home_controller.dart';
import 'package:flutter_application_1/controller/mainwapper_controller.dart';
import 'package:flutter_application_1/controller/profile_controller.dart';
import 'package:flutter_application_1/controller/service_selection_controller.dart';
import 'package:flutter_application_1/controller/serviceitems_controller.dart';
import 'package:flutter_application_1/controller/signup_controller.dart';
import 'package:flutter_application_1/controller/slider_controller.dart';
import 'package:flutter_application_1/controller/splash_controller.dart';
import 'package:flutter_application_1/controller/userprofile_controller.dart';
import 'package:flutter_application_1/core/localization/changelocal.dart';
import 'package:get/get.dart';
import '../../controller/login_controller.dart';
import '../../controller/password_controller.dart';
import '../../controller/navigation_controllers.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LocaleController(), permanent: true);
    Get.put(SplashController());
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => SignupController(), fenix: true);
    Get.lazyPut(() => PasswordController(), fenix: true);

    // الكنترولرات الخاصة بالبروفايل
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => UserProfileController(), fenix: true); // السطر الجديد هنا
    Get.lazyPut(() => AccountSecurityController(), fenix: true);
    Get.put(ProfileController(), permanent: true);
    Get.lazyPut(() => NavigationController(), fenix: true);
    Get.lazyPut(() => MainWrapperController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => SliderController(), fenix: true);
    Get.lazyPut<ServicesselectController>(
      () => ServicesselectController(),
      fenix: true,
    );
    Get.lazyPut<ServiceitemController>(
      () => ServiceitemController(),
      fenix: true,
    );
  }
}
