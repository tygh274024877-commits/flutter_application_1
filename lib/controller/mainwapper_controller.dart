import 'package:get/get.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_application_1/view/screens/home_screen.dart';

class MainWrapperController extends GetxController {
  static MainWrapperController get instance =>
      Get.find<MainWrapperController>();

  final zoomDrawerController = ZoomDrawerController();
  var currentIndex = 0.obs;
  final pages = [HomeScreen()].obs;

  void toggleDrawer() {
    print("Toggling Drawer...");
    zoomDrawerController.toggle?.call();
  }

  void changePage(int index) {
    currentIndex.value = index;
    update();
  }
}
