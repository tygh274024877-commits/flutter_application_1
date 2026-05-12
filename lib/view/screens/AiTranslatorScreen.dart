import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/AiTransLator_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:flutter_application_1/view/components/Aitranslator/BottomActionArea.dart';
import 'package:flutter_application_1/view/components/Aitranslator/CustomAppBar.dart';
import 'package:flutter_application_1/view/components/Aitranslator/GlassInputField.dart';
import 'package:flutter_application_1/view/components/Aitranslator/LanguageSelector.dart';
import 'package:flutter_application_1/view/components/Aitranslator/TranslateButtonPill.dart';
import 'package:flutter_application_1/view/components/Aitranslator/buildBackgroundEffects.dart';
import 'package:get/get.dart';

// تحويل الكلاس إلى GetView
class AiTranslatorScreen extends GetView<AiTranslatorController> {
  const AiTranslatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ملاحظة: تأكدي أنكِ قمتِ بعمل Get.put للكنترولر في الـ Binding أو قبل الانتقال لهذه الشاشة
    // إذا لم تكوني تستخدمين Bindings، يمكنك إبقاء Get.put هنا أو الأفضل وضعها في أول ملف الـ main أو الـ Navigation

    return Scaffold(
      backgroundColor: AppColors.translatorBg,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: const [
          BackgroundEffects(),
          SafeArea(
            child: Column(
              children: [
                CustomAppBar(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        LanguageSelector(),
                        SizedBox(height: 25),
                        GlassInputField(hint: "Enter text...", isResult: false),
                        SizedBox(height: 35),
                        TranslateButtonPill(),
                        SizedBox(height: 35),
                        GlassInputField(hint: "Translation...", isResult: true),
                      ],
                    ),
                  ),
                ),
                BottomActionArea(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
