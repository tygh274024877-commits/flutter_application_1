import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/animations/splashAnimations.dart';
import 'package:flutter_application_1/view/components/shared/tripmate.dart';

class SplashWidgets {
  //  الخلفية (splashscreen.png)
  static Widget buildBackground() {
    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/splashscreen.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(color: Colors.black.withOpacity(0)),
            ),
          ),
        ],
      ),
    );
  }

  // كرة الأرض
  static Widget buildLogoSection(SplashAnimations anims) {
    return FadeTransition(
      opacity: anims.logoFade,
      child: SlideTransition(
        position: anims.logoSlide,
        child: RotationTransition(
          turns: anims.logoRotate,
          child: Image.asset('assets/images/smal.png', height: 140),
        ),
      ),
    );
  }

  //الاسم
  static Widget buildTextSection(SplashAnimations anims) {
    return FadeTransition(
      opacity: anims.titleFade,
      child:TripMate()
    );
  }

  //  المنطاد
  static Widget buildBalloonSection(SplashAnimations anims) {
    return FadeTransition(
      opacity: anims.balloonFade,
      child: SlideTransition(
        position: anims.balloonFlight,
        child: Image.asset(
          'assets/images/pictuersSplashscreen.png',
          width: 220,
          height: 150,
        ),
      ),
    );
  }

  // 5. النصوص
  static Widget buildFooterSection(
    SplashAnimations anims,
    String text,
    Color color,
    FontWeight weight,
    double size,
  ) {
    return FadeTransition(
      opacity: anims.finalTextsFade,
      child: Text(
        text,
        style: TextStyle(fontSize: size, color: color, fontWeight: weight),
      ),
    );
  }
}
