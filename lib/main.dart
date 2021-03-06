import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:speed_vpn/controllers/bottombar/bottom_buinding.dart';
import 'package:speed_vpn/controllers/splash/splash_controller_binding.dart';
import 'package:speed_vpn/helpers/size_config.dart';
import 'package:speed_vpn/screens/bottombar/bottombar.dart';
import 'package:speed_vpn/screens/server/server_screen.dart';

import 'package:speed_vpn/screens/splash/splash_screen.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return GetMaterialApp(
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
          name: '/customerbottonbar',
          binding: BottomControllerBuinding(),
          page: () => CustomBottonBar(),
        ),
         GetPage(
          name: '/server',
          page: () => ServersScreen(),
        ),
      ],
    );
  }
}
