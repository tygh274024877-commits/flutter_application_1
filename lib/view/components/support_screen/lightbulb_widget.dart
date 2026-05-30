import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/color/constants.dart';

class AnimatedBulb extends StatefulWidget {
  const AnimatedBulb({super.key});
  @override
  State<AnimatedBulb> createState() => _AnimatedBulbState();
}

class _AnimatedBulbState extends State<AnimatedBulb>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(
        begin: 0.9,
        end: 1.1,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      child: const Icon(
        Icons.lightbulb_circle,
        size: 110,
        color: AppColors.golden,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
