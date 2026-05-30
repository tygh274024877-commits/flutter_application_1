import 'package:get/get_utils/src/extensions/internacionalization.dart';

class FAQModel {
  final String question;
  final String answer;

  FAQModel({required this.question, required this.answer});

  static List<FAQModel> get faqList => [
    FAQModel(question: "faq_q1".tr, answer: "faq_a1".tr),
    FAQModel(question: "faq_q2".tr, answer: "faq_a2".tr),
    FAQModel(question: "faq_q3".tr, answer: "faq_a3".tr),
    FAQModel(question: "faq_q4".tr, answer: "faq_a4".tr),
    FAQModel(question: "faq_q5".tr, answer: "faq_a5".tr),
  ];
}
