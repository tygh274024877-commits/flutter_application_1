import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/components/Aitranslator/PositionedGlow.dart';

import 'positionedGlow.dart' hide PositionedGlow;

class BackgroundEffects extends StatelessWidget {
  const BackgroundEffects({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const PositionedGlow(top: -70, right: -70, opacity: 0.7),
        const PositionedGlow(bottom: -70, left: -70, opacity: 0.6),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}
