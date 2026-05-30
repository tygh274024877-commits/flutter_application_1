import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/components/smart_screen/robot/RobotBody.dart';
import 'package:flutter_application_1/view/components/smart_screen/robot/RobotHead.dart';

class BeautifulRobot extends StatelessWidget {
  final double walkCycle;
  final Color primaryColor;
  final Color backgroundColor;

  const BeautifulRobot({
    Key? key,
    required this.walkCycle,
    required this.primaryColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      height: 75,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          // الذراع اليسرى
          Positioned(
            top: 36,
            left: 8,
            child: Transform.rotate(
              angle: walkCycle * 0.35,
              origin: const Offset(0, -3),
              child: _buildLimb(6, 15),
            ),
          ),
          // الذراع اليمنى
          Positioned(
            top: 36,
            right: 8,
            child: Transform.rotate(
              angle: -walkCycle * 0.35,
              origin: const Offset(0, -3),
              child: _buildLimb(6, 15),
            ),
          ),
          // الرجل اليسرى
          Positioned(
            bottom: 2,
            left: 22,
            child: Transform.rotate(
              angle: -walkCycle * 0.22,
              origin: const Offset(0, -3),
              child: _buildLimb(7, 14),
            ),
          ),
          // الرجل اليمنى
          Positioned(
            bottom: 2,
            right: 22,
            child: Transform.rotate(
              angle: walkCycle * 0.22,
              origin: const Offset(0, -3),
              child: _buildLimb(7, 14),
            ),
          ),

          // رأس الروبوت المستورد
          Positioned(
            top: 2,
            child: RobotHead(
              primaryColor: primaryColor,
              backgroundColor: backgroundColor,
            ),
          ),

          // جسم الروبوت المستورد
          Positioned(
            top: 31,
            child: RobotBody(
              primaryColor: primaryColor,
              backgroundColor: backgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLimb(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
