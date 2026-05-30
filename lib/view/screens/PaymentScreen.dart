import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controller/PaymentController.dart';
// تأكدي من استيراد ملفات الثيم الخاصة بكِ
import '../../core/color/constants.dart';
import '../../core/theme/app_shadows.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.BurntBrown),
        title: Text(
          "الدفع",
          style: TextStyle(
            color: AppColors.BurntBrown,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // --- منطقة الأنيميشن الخارق (تدفق الأموال) ---
          SizedBox(
            height: 260,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 1. توليد "سيل" من الأموال (أوراق وعملات)
                ...List.generate(6, (index) {
                  return AnimatedBuilder(
                    animation: controller.animController,
                    builder: (context, child) {
                      // توزيع عشوائي ومنظم للأموال
                      double progress =
                          (controller.animController.value + (index / 6)) % 1.0;
                      double yPos =
                          -80 + (progress * 180); // التحرك من الأعلى للأسفل
                      double xPos =
                          (index % 2 == 0 ? -30 : 30) *
                          (1 - progress); // ميلان خفيف نحو المركز

                      return Positioned(
                        top: yPos,
                        left:
                            (MediaQuery.of(context).size.width / 2) - 20 + xPos,
                        child: Opacity(
                          opacity: progress < 0.1
                              ? progress * 10
                              : (progress > 0.8 ? (1 - progress) * 5 : 1.0),
                          child: index % 2 == 0
                              ? _buildPaperMoney() // ورقة نقدية
                              : _buildGoldCoin(), // عملة ذهبية
                        ),
                      );
                    },
                  );
                }),

                // 2. الهدف الفخم (المحفظة الذهبية العائمة)
                Positioned(
                  bottom: 20,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.golden, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.golden.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          FontAwesomeIcons.wallet,
                          color: AppColors.golden,
                          size: 60,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
          Text(
            "اختر وسيلة الدفع المفضلة",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.BurntBrown,
            ),
          ),

          const SizedBox(height: 30),
          // أضيفي هذا تحت النص الأساسي
          const SizedBox(
            height: 5,
          ), // رفعنا النص قليلاً بتقليل المسافة من 10 إلى 5
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.BurntBrown.withOpacity(
                    0.8,
                  ), // جعلنا اللون العام أغمق قليلاً (0.8 بدلاً من 0.7)
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Montserrat', // أو أي خط تستخدمينه
                ),
                children: [
                  const TextSpan(text: "نقدر ثقتكم بـ "),
                  TextSpan(
                    text: "TripMate",
                    style: TextStyle(
                      color: AppColors
                          .BurntBrown, // لون أغمق (بدون شفافية) ليكون بارزاً
                      fontWeight:
                          FontWeight.bold, // جعلناها عريضة أيضاً لبروز أكثر
                    ),
                  ),
                  const TextSpan(
                    text:
                        ". بياناتكم محمية بأحدث تقنيات التشفير لضمان رحلة دفع آمنة وموثوقة",
                  ),
                ],
              ),
            ),
          ),
          // خيارات الدفع (تصميم النيومورفيك الفخم)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _buildLargeOption(
                      "بطاقة بنكية",
                      Icons.credit_card,
                      controller.goToCardPayment,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildLargeOption(
                      "تحويل مباشر",
                      Icons.account_balance,
                      controller.goToBankTransfer,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ويدجت الورقة النقدية الخضراء
  Widget _buildPaperMoney() {
    return Container(
      width: 45,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.green.shade600,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.green.shade900, width: 0.5),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
      ),
      child: const Center(
        child: Text(
          "\$",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  // ويدجت العملة الذهبية
  Widget _buildGoldCoin() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.amber,
      ),
      child: Icon(Icons.monetization_on, color: AppColors.golden, size: 28),
    );
  }

  // ويدجت خيارات الدفع (تصميمكِ القديم المطور)
  Widget _buildLargeOption(String title, IconData icon, VoidCallback onTap) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.golden, width: 2),
        boxShadow: AppShadows.neumorphicShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 55, color: AppColors.primary),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.BurntBrown,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
