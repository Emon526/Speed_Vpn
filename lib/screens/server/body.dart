import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:speed_vpn/controllers/server_controller/server_screen_controller.dart';
import 'package:speed_vpn/helpers/widget/list_widget.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ServerController serverController = Get.put(ServerController());
    return Container(
      child: Obx(
        () {
          if (serverController.isLoading.isTrue) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (serverController.servers.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      child: Lottie.asset('assets/lottie/noserver.json'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "No Server Found",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.offAllNamed('/server');
                      },
                      child: Text(
                        "Refresh",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ))
                ],
              );
            } else {
              return ListWidget();
            }
          }
        },
      ),
    );
  }
}