import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/components/smart_screen/robot/robot_smile_painter.dart';

/// 1. مكون رأس الروبوت (شامل التفاصيل والفيونكة)
class RobotHead extends StatelessWidget {
  final Color primaryColor;
  final Color backgroundColor;

  const RobotHead({
    Key? key,
    required this.primaryColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 34,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // الأذن اليسرى
          Positioned(top: 6, left: 2, child: _buildEar()),
          // الأذن اليمنى
          Positioned(top: 6, right: 2, child: _buildEar()),
          // الهوائي العلوي
          Positioned(
            top: 0,
            child: Container(
              width: 26,
              height: 8,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
            ),
          ),
          // الوجه والشاشة الداخلية
          Positioned(
            top: 4,
            child: Container(
              width: 32,
              height: 24,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Center(child: _buildScreen()),
            ),
          ),
          // الفيونكة (الببيونة) المحمية من القطش
          Positioned(top: -1, right: -2, child: _buildBowTie()),
        ],
      ),
    );
  }

  Widget _buildEar() {
    return Container(
      width: 7,
      height: 18,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildScreen() {
    return Container(
      width: 26,
      height: 18,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(radius: 2, backgroundColor: primaryColor),
              const SizedBox(width: 2),
              CircleAvatar(radius: 2, backgroundColor: primaryColor),
            ],
          ),
          const SizedBox(height: 1),
          CustomPaint(
            size: const Size(10, 4),
            painter: RobotSmilePainter(color: primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildBowTie() {
    return SizedBox(
      width: 14,
      height: 10,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 0,
            child: Transform.rotate(angle: 0.3, child: _buildBowWing()),
          ),
          Positioned(
            left: 0,
            child: Transform.rotate(angle: -0.3, child: _buildBowWing()),
          ),
          Container(
            width: 3.5,
            height: 3.5,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBowWing() {
    return Container(
      width: 6,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 1)],
      ),
    );
  }
}
