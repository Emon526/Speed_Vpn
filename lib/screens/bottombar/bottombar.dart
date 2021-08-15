import 'package:circle_bottom_navigation/circle_bottom_navigation.dart';
import 'package:circle_bottom_navigation/widgets/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_vpn/controllers/bottombar/bottombar_controller.dart';
import 'package:speed_vpn/model/menuitem.dart';
import 'package:speed_vpn/screens/home/home_screen.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class CustomBottonBar extends StatelessWidget {
  const CustomBottonBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(),
      Container(),
      Container(),
    ];

    BottombarController controller = Get.put(BottombarController());
    // final _drawerController = ZoomDrawerController();

    // final List<MenuItem> options = [
    //   MenuItem(Icons.payment, 'Payments'),
    //   MenuItem(Icons.favorite, 'Discounts'),
    //   MenuItem(Icons.notifications, 'Notification'),
    //   MenuItem(Icons.format_list_bulleted, 'Orders'),
    //   MenuItem(Icons.help, 'Help'),
    // ];

    return Obx(() {
      return Scaffold(
        
        appBar: AppBar(
          title: Text("Speed Vpn"),
        ),
        body: _pages[controller.currentPage.value],
        bottomNavigationBar: CircleBottomNavigation(
          barHeight: 60,
          circleSize: 40,
          initialSelection: controller.currentPage.value,
          inactiveIconColor: Colors.grey,
          textColor: Colors.black,
          hasElevationShadows: false,
          tabs: [
            TabData(
              icon: Icons.home,
              iconSize: 27,
              title: 'Home',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            TabData(
              icon: Icons.browser_not_supported_rounded, //for check
              iconSize: 27,
              title: 'Browser',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            TabData(
              icon: Icons.folder,
              iconSize: 37,
              title: 'File',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ],
          onTabChangedListener: (index) {
            controller.currentPage.value = index;
          },
        ),
      );
    });
  }
}
