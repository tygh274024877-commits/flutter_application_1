import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/color/constants.dart';

class StrongAnimatedWritingIcon extends StatefulWidget {
  const StrongAnimatedWritingIcon({super.key});

  @override
  State<StrongAnimatedWritingIcon> createState() =>
      _StrongAnimatedWritingIconState();
}

class _StrongAnimatedWritingIconState extends State<StrongAnimatedWritingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
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
            // تأثير التوهج (Glow)
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(
                      0.3 * (1 + math.sin(_controller.value * 2 * math.pi)),
                    ),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
            // أيقونة الدفتر مع ميلان خفيف
            Transform.rotate(
              angle: math.sin(_controller.value * 2 * math.pi) * 0.1,
              child: const Icon(
                Icons.menu_book_rounded,
                size: 100,
                color: AppColors.earthyBrown,
              ),
            ),
            // أيقونة القلم مع حركة دورانية
            Transform(
              transform: Matrix4.identity()
                ..translate(
                  30 * math.cos(_controller.value * 2 * math.pi),
                  30 * math.sin(_controller.value * 2 * math.pi),
                )
                ..rotateZ(0.5),
              child: const Icon(
                Icons.edit_rounded,
                size: 50,
                color: AppColors.primary,
              ),
            ),
          ],
        );
      },
    );
  }
}
