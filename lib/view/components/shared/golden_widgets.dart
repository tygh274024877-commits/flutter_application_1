import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/color/constants.dart'; // تأكدي من مسار الألوان عندك

// ١. الغولدن الأساسي لتلوين أي نص أو أيقونة
class GoldenGradientWrapper extends StatelessWidget {
  final Widget child;
  final bool isImage;

  const GoldenGradientWrapper({
    super.key,
    required this.child,
    this.isImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.golden, AppColors.lightGolden, AppColors.golden],
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      blendMode: isImage ? BlendMode.srcIn : BlendMode.modulate,
      child: child,
    );
  }
}

// ٢. كلاس اللوجو مع ظله (احترافي للهيدر)
class AppLogo extends StatelessWidget {
  final double height;
  const AppLogo({super.key, this.height = 130});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Image.asset(
            "assets/images/small.png",
            height: height,
            color: AppColors.darkBrown,
            colorBlendMode: BlendMode.srcIn,
          ),
        ),
        GoldenGradientWrapper(
          isImage: true,
          child: Image.asset("assets/images/small.png", height: height),
        ),
      ],
    );
  }
}

// ٣. الدويرة الذهبية (الـ Avatar)
class ProfileAvatar extends StatelessWidget {
  final String imagePath;
  final double radius;
  final VoidCallback onTap;
  final Widget? deleteButton;

  const ProfileAvatar({
    super.key,
    required this.imagePath,
    required this.onTap,
    this.radius = 120,
    this.deleteButton,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.golden,
                  AppColors.lightGolden,
                  AppColors.golden,
                ],
              ),
            ),
            child: Container(
              width: radius,
              height: radius,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: imagePath.isEmpty
                    ? const GoldenGradientWrapper(
                        isImage: true,
                        child: Icon(Icons.person, size: 80),
                      )
                    : Image.file(File(imagePath), fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        if (deleteButton != null) deleteButton!,
      ],
    );
  }
}
