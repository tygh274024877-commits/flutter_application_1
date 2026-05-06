import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'golden_widgets.dart'; // استدعاء ملف الغولدن

class WaveHeader extends StatelessWidget {
  const WaveHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.225,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            top: Get.height * 0.05,
            child: Image.asset(
              "assets/images/waveheader.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: Get.height * 0.06,
            left: Get.width * 0.14,
            child: const AppLogo(height: 130),
          ),
          Positioned(
            top: Get.height * 0.09,
            left: Get.width * 0.4,
            child: const GoldenGradientWrapper(
              child: Text(
                'TripMate',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
