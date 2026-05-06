import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import '../../controller/mainwapper_controller.dart';
import '../../core/color/constants.dart';
import 'munue_screen.dart';

class MainWrapper extends GetView<MainWrapperController> {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: controller.zoomDrawerController,
      menuScreen: const MenuScreen(),
      mainScreen: Obx(() => controller.pages[0]),
      borderRadius: 50.0,
      angle: -5.0,
      isRtl: false,
      boxShadow: [
        BoxShadow(
          color: AppColors.golden.withOpacity(0.3),
          blurRadius: 20,
          spreadRadius: 5,
          offset: const Offset(-20, 0),
        ),
      ],
      mainScreenScale: 0.1,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      menuBackgroundColor: AppColors.background,
      mainScreenTapClose: true,
      openCurve: Curves.bounceInOut,
      closeCurve: Curves.bounceInOut,
      overlayBlur: 0.10,
      mainScreenOverlayColor: Colors.black.withOpacity(0.3),
    );
  }
}
