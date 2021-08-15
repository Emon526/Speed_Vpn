import 'dart:async';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(
      Duration(seconds: 5),
      () {
         Get.offAllNamed('/customerbottonbar');
        //Get.offAll(  CustomBottonBar());
      },
    );
  }
}
