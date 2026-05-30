import 'package:get/get.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ChatDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();

  void toggle() => zoomDrawerController.toggle?.call();
}
