import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/splash_controller.dart';
import 'package:flutter_application_1/core/color/constants.dart';
import 'package:flutter_application_1/view/components/Splash_screen_Widgwts/splash_screenwidgwt.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SplashScreen extends GetView<SplashController>{
  const SplashScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
builder: (controller){
          return Stack(
          children: [
            SplashWidgets.buildBackground(),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SplashWidgets.buildLogoSection(controller.anims),
                  const SizedBox(height: 10),
                  SplashWidgets.buildTextSection(controller.anims),
                  SplashWidgets.buildFooterSection(controller.anims,"Explore Syria", AppColors.primary,FontWeight.normal,22),
                  const SizedBox(height: 30),
                  SplashWidgets.buildBalloonSection(controller.anims),
                  const SizedBox(height: 20),
                  SplashWidgets.buildFooterSection(controller.anims,"Start your journey",AppColors.BurntBrown,FontWeight.bold,35),
                ],
              ),
            ),
          ],
  );}
      ),
    );
  }
}