import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animController;

  @override
  void onInit() {
    super.onInit();
    // مدة الحركة ثانيتان وتتكرر للأبد
    animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  void goToCardPayment() => Get.toNamed('/card_payment');
  void goToBankTransfer() => Get.toNamed('/bank_transfer');

  @override
  void onClose() {
    animController.dispose();
    super.onClose();
  }
}
