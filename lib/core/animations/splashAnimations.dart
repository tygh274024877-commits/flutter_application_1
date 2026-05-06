import 'package:flutter/material.dart';

class SplashAnimations {
  final AnimationController controller;

  late final Animation<Offset> logoSlide;
  late final Animation<double> logoRotate;
  late final Animation<double> logoFade;
  late final Animation<double> titleFade;
  late final Animation<double> balloonFade;
  late final Animation<Offset> balloonFlight;
  late final Animation<double> finalTextsFade;

  SplashAnimations(this.controller) {
    _initAnimations();
  }

  void _initAnimations() {
    // حركة كرة الأرض (smal)
    logoSlide = createOffsetAnimation(
      begin: const Offset(-1.2, -1.2),
      end: Offset.zero,
      start: 0.0,
      endInterval: 0.25,
      curve: Curves.easeOutBack,
      controller: controller,
    );
    logoRotate = _createDoubleAnimation(
      begin: 0.0,
      end: 2.0,
      start: 0.0,
      endInterval: 0.25,
    );
    logoFade = _createDoubleAnimation(
      begin: 0.0,
      end: 1.0,
      start: 0.0,
      endInterval: 0.15,
    );

    // النصوص
    titleFade = _createDoubleAnimation(
      begin: 0.0,
      end: 1.0,
      start: 0.25,
      endInterval: 0.45,
    );

    // حركة المنطاد (pictuersSplashscreen)
    balloonFade = _createDoubleAnimation(
      begin: 0.0,
      end: 1.0,
      start: 0.45,
      endInterval: 0.60,
    );
    balloonFlight = createOffsetAnimation(
      begin: const Offset(0, 2.0),
      end: Offset.zero,
      start: 0.45,
      endInterval: 0.85,
      curve: Curves.easeOutCubic,
      controller: controller,
    );

    // الفوتر
    finalTextsFade = _createDoubleAnimation(
      begin: 0.0,
      end: 1.0,
      start: 0.85,
      endInterval: 1.0,
    );
  }

  Animation<double> _createDoubleAnimation({
    required double begin,
    required double end,
    required double start,
    required double endInterval,
  }) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(start, endInterval, curve: Curves.easeIn),
      ),
    );
  }

  static Animation<Offset> createOffsetAnimation({
    required Animation<double> controller,
    required Offset begin,
    required Offset end,
    required double start,
    required double endInterval,
    Curve curve = Curves.linear,
  }) {
    return Tween<Offset>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(start, endInterval, curve: curve),
      ),
    );
  }
}
