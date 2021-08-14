import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:speed_vpn/controllers/splash/splash_controller_binding.dart';
import 'package:speed_vpn/screens/home/home_screen.dart';
import 'package:speed_vpn/screens/splash/splash_screen.dart';

void main(List<String> args) {
  runApp(
    GetMaterialApp(
      initialRoute: '/splash',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/splash',
          page: () => SpalshScreen(),
          binding: SplashControllerBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
        ),
      ],
    ),
  );
}
