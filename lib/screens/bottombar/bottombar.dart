import 'dart:math';

import 'package:circle_bottom_navigation/circle_bottom_navigation.dart';
import 'package:circle_bottom_navigation/widgets/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_vpn/controllers/bottombar/bottombar_controller.dart';
import 'package:speed_vpn/helpers/constants.dart';
import 'package:speed_vpn/screens/browser/browser.dart';
import 'package:speed_vpn/screens/file/file_screen.dart';
import 'package:speed_vpn/screens/home/home_screen.dart';
import 'package:speed_vpn/screens/speed-test/speed_test_screen.dart';

class CustomBottonBar extends StatelessWidget {
  const CustomBottonBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(),
      BrowserScreen(),
      FileScreen(),
    ];

    BottombarController controller = Get.put(BottombarController());

    return Obx(
      () {
        // double value = 0.0;
        onBottomChange(index) {
          controller.currentPage.value = index;
        }

        return Scaffold(
          backgroundColor: kPrimaryColor,
          body: SafeArea(
            child: Stack(
              children: [
                //drawer:
                Container(
                  width: 200.0,
                  child: ListView(
                    children: [
                      // Container(
                      //   alignment: Alignment.center,
                      //   height: 52.0,
                      //   decoration: BoxDecoration(
                      //       color: controller.currentPage.value == 2
                      //           ? Colors.white
                      //           : Colors.deepPurple,
                      //       borderRadius: BorderRadius.circular(10.0)),
                      //   child: ListTile(
                      //     onTap: () {
                      //       if (controller.currentPage.value != 2) {
                      //         controller.currentPage.value = 2;
                      //         onBottomChange(2);
                      //       }
                      //     },
                      //     leading: Icon(Icons.home,
                      //         color: controller.currentPage.value != 2
                      //             ? Colors.white
                      //             : Colors.deepPurple),
                      //     title: Text("File",
                      //         style: TextStyle(
                      //             color: controller.currentPage.value != 2
                      //                 ? Colors.white
                      //                 : Colors.deepPurple)),
                      //   ),
                      // ),

                      Container(
                        height: 100.0,
                        color: kWhiteColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "VPN",
                              style: TextStyle(fontSize: 24.0),
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 15.0),
                        alignment: Alignment.center,
                        height: 52.0,
                        // speed screen navigate
                        child: ListTile(
                          onTap: () {
                            Get.toNamed('/speed');
                          },
                          leading: Icon(Icons.speed, color: Colors.white),
                          title: Text("Speed Test",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 52.0,
                        child: ListTile(
                          onTap: () {},
                          leading: Icon(Icons.info, color: Colors.white),
                          title: Text("About",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),

                TweenAnimationBuilder(
                  //   curve: Curves.easeIn,
                  tween: Tween<double>(begin: 0, end: controller.value.value),
                  duration: Duration(milliseconds: 400),
                  builder: (_, double valu, __) {
                    return Obx(
                      () {
                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..setEntry(0, 3, 200 * valu)
                            ..rotateY((pi / 6) * valu),
                          child: Scaffold(
                            backgroundColor: kWhiteColor,
                            body: SafeArea(
                              child: Stack(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          // ignore: unrelated_type_equality_checks
                                          top: controller.currentPage == 1
                                              ? 0
                                              : 14.0),
                                      child:
                                          _pages[controller.currentPage.value]),
                                  Container(
                                      height: 55.0,
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                controller.value.value == 0
                                                    ? controller.value.value = 1
                                                    : controller.value.value =
                                                        0;
                                              },
                                              icon: Icon(Icons.menu)),
                                          Text("Speed VPN",
                                              style: TextStyle(
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold)),
                                          IconButton(
                                              onPressed: () {
                                                Get.to(SpeedTestScreen());
                                              },
                                              icon: Icon(Icons.speed))
                                        ],
                                      )),
                                ],
                              ),
                            ),
                            bottomNavigationBar: Obx(
                              () => CircleBottomNavigation(
                                barHeight: 60,
                                circleOutline: 4.0,
                                circleSize: 40,
                                initialSelection: controller.currentPage.value,
                                inactiveIconColor: Colors.black,
                                textColor: Colors.black,
                                activeIconColor: Color(0xFFd39856),
                                circleColor: Colors.black12,
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
                                    icon: Icons
                                        .browser_not_supported_rounded, //for check
                                    iconSize: 27,
                                    title: 'Browser',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  TabData(
                                    icon: Icons.folder_outlined,
                                    iconSize: 37,
                                    title: 'File',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                                onTabChangedListener: onBottomChange,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                //swinping
                GestureDetector(
                  onHorizontalDragUpdate: (e) {
                    if (e.delta.dx > 0) {
                      controller.value.value = 1;
                    } else {
                      controller.value.value = 0;
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
