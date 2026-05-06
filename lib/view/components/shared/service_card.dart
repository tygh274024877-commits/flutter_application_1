import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:flutter_application_1/core/theme/app_shadows.dart';
import 'package:flutter_application_1/models/tripservices.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class Servicecard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onTap;
  final int? index;
  const Servicecard({
    super.key,
    required this.onTap,
    required this.service,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final int itemIndex = index ?? 0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * 0.1,
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primary.withOpacity(0.5),
            width: 1,
          ),
          color: AppColors.background.withOpacity(0.9),
          boxShadow: AppShadows.neumorphicShadow,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: itemIndex.isEven
                    ? AppColors.golden.withOpacity(0.2)
                    : AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                service.icon,
                size: 30,
                color: itemIndex.isEven ? AppColors.golden : AppColors.primary,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                service.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.BurntBrown,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
