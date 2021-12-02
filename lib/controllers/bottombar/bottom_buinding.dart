import 'package:get/get.dart';
import 'package:speed_vpn/controllers/bottombar/bottombar_controller.dart';
class BottomControllerBuinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottombarController());
  }
  
}