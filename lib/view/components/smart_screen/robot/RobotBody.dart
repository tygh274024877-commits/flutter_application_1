import 'package:flutter/material.dart';

class RobotBody extends StatelessWidget {
  final Color primaryColor;
  final Color backgroundColor;

  const RobotBody({
    Key? key,
    required this.primaryColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // الرقبة
        Container(width: 8, height: 2, color: primaryColor),
        // الجذع
        Container(
          width: 34,
          height: 24,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: backgroundColor, width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
