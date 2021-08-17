import 'dart:math';

import 'package:circle_bottom_navigation/circle_bottom_navigation.dart';
import 'package:circle_bottom_navigation/widgets/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_vpn/controllers/bottombar/bottombar_controller.dart';
import 'package:speed_vpn/screens/browser/browser.dart';
import 'package:speed_vpn/screens/file/file_screen.dart';
import 'package:speed_vpn/screens/home/home_screen.dart';

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

    return Obx(() {
      // double value = 0.0;
      onBottomChange(index) {
        controller.currentPage.value = index;
      }

      return Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Stack(
          children: [
            //drawer:
            Container(
              // color: Colors.deepPurple,
              width: 200.0,
              padding: EdgeInsets.all(14.0),
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 52.0,
                    decoration: BoxDecoration(
                        color: controller.currentPage.value == 0
                            ? Colors.white
                            : Colors.deepPurple,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ListTile(
                      onTap: () {
                        if (controller.currentPage.value != 0) {
                          controller.currentPage.value = 0;
                          onBottomChange(0);
                        }
                      },
                      leading: Icon(Icons.home,
                          color: controller.currentPage.value != 0
                              ? Colors.white
                              : Colors.deepPurple),
                      title: Text("Home",
                          style: TextStyle(
                              color: controller.currentPage.value != 0
                                  ? Colors.white
                                  : Colors.deepPurple)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 52.0,
                    decoration: BoxDecoration(
                        color: controller.currentPage.value == 1
                            ? Colors.white
                            : Colors.deepPurple,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ListTile(
                      onTap: () {
                        if (controller.currentPage.value != 1) {
                          controller.currentPage.value = 1;
                          onBottomChange(1);
                        }
                      },
                      leading: Icon(Icons.home,
                          color: controller.currentPage.value != 1
                              ? Colors.white
                              : Colors.deepPurple),
                      title: Text("Browser",
                          style: TextStyle(
                              color: controller.currentPage.value != 1
                                  ? Colors.white
                                  : Colors.deepPurple)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 52.0,
                    decoration: BoxDecoration(
                        color: controller.currentPage.value == 2
                            ? Colors.white
                            : Colors.deepPurple,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ListTile(
                      onTap: () {
                        if (controller.currentPage.value != 2) {
                          controller.currentPage.value = 2;
                          onBottomChange(2);
                        }
                      },
                      leading: Icon(Icons.home,
                          color: controller.currentPage.value != 2
                              ? Colors.white
                              : Colors.deepPurple),
                      title: Text("File",
                          style: TextStyle(
                              color: controller.currentPage.value != 2
                                  ? Colors.white
                                  : Colors.deepPurple)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 52.0,
                    child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.home, color: Colors.white),
                      title:
                          Text("About", style: TextStyle(color: Colors.white)),
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
                  return Obx(() {
                    return Transform(
                      //alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..setEntry(0, 3, 200 * valu)
                        ..rotateY((pi / 6) * valu),
                      child: Scaffold(
                        appBar: AppBar(
                          actions: [
                            IconButton(
                                onPressed: () {
                                  onBottomChange(2);
                                },
                                icon: Icon(Icons.ac_unit_sharp))
                          ],
                          leading: IconButton(
                              onPressed: () {
                                controller.value.value == 0
                                    ? controller.value.value = 1
                                    : controller.value.value = 0;
                              },
                              icon: Icon(Icons.menu)),
                          title: Text("Speed Vpn"),
                        ),
                        body: _pages[controller.currentPage.value],
                        bottomNavigationBar: Obx(() => CircleBottomNavigation(
                              barHeight: 60,
                              circleOutline: 4.0,
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
                                  icon: Icons
                                      .browser_not_supported_rounded, //for check
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
                              onTabChangedListener: onBottomChange,
                            )),
                      ),
                    );
                  });
                }),

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
      );
    });
  }
}
