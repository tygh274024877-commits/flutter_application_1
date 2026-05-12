import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/color/constants.dart';

class FloatingRobotWithSmartHi extends StatefulWidget {
  const FloatingRobotWithSmartHi();
  @override
  State<FloatingRobotWithSmartHi> createState() =>
      _FloatingRobotWithSmartHiState();
}

class _FloatingRobotWithSmartHiState extends State<FloatingRobotWithSmartHi>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _hiOpacity;
  late Animation<double> _hiScale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
    _hiOpacity = TweenSequence([
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 10),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 10),
    ]).animate(_controller);

    _hiScale = TweenSequence([
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 40),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.2,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 20,
      ),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 10),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 10),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: -_controller.value * 2 * math.pi,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.golden.withOpacity(0.4),
                    width: 2.5,
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(
                12 * math.cos(_controller.value * 2 * math.pi),
                18 * math.sin(_controller.value * 2 * math.pi),
              ),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.golden.withOpacity(0.3),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.smart_toy_rounded,
                      size: 100,
                      color: AppColors.primary,
                    ),
                  ),
                  Positioned(
                    right: -25,
                    top: 10,
                    child: FadeTransition(
                      opacity: _hiOpacity,
                      child: ScaleTransition(
                        scale: _hiScale,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: const Text(
                            "Hi!",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
