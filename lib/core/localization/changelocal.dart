import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends GetxController {
  Locale? language;
  SharedPreferences? sharePref;

  // هذه الدالة لتغيير اللغة وحفظها فوراً
  void changeLang(String langcode) {
    Locale locale = Locale(langcode);
    sharePref?.setString("lang", langcode); // حفظ الاختيار
    Get.updateLocale(locale);
    language = locale;
    update();
  }

  // هذه الدالة هي التي تجعل اللغة تبقى عربية عند فتح التطبيق مرة ثانية
  Future<void> checkInitialLang() async {
    sharePref = await SharedPreferences.getInstance();
    String? sharedPrefLang = sharePref?.getString("lang");

    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
    } else {
      // إذا كان أول مرة يفتح التطبيق، نأخذ لغة الجهاز
      language = Locale(Get.deviceLocale!.languageCode);
    }
    update();
  }
}
