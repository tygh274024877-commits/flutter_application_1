import 'package:flutter/material.dart';
import '../../../core/color/constants.dart';

class AnimatedSupportBulb extends StatefulWidget {
  const AnimatedSupportBulb({super.key});

  @override
  State<AnimatedSupportBulb> createState() => _AnimatedSupportBulbState();
}

class _AnimatedSupportBulbState extends State<AnimatedSupportBulb>
    with SingleTickerProviderStateMixin {
  late AnimationController _bulbController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _bulbController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _bulbController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bulbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bulbController,
      builder: (context, child) => Transform.scale(
        scale: _pulseAnimation.value,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.golden.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.golden.withOpacity(0.2),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.lightbulb_circle,
              size: 110,
              color: AppColors.golden,
            ),
          ],
        ),
      ),
    );
  }
}
