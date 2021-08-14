import 'package:get/get.dart';
import 'package:speed_vpn/controllers/splash/splash_controller.dart';

class SplashControllerBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
  
}