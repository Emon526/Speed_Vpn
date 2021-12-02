import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_vpn/controllers/server_controller/server_screen_controller.dart';
import 'package:speed_vpn/helpers/constants.dart';
import 'package:speed_vpn/helpers/size_config.dart';

class ServerConnectionWidgets extends StatelessWidget {
  final Function onPress;
  ServerConnectionWidgets({
    this.onPress,
  });
  final ServerController serverController = Get.put(ServerController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: kWhiteColor,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Obx(
          () {
            if (serverController.isLoading.isTrue) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container(
                alignment: Alignment.center,
                width: SizeConfig.screenWidth / 1.5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: getProportionateScreenWidth(35),
                      height: getProportionateScreenWidth(35),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/' +
                                  serverController
                                          .servers[serverController.serverIndex]
                                      ['flag'],
                            ),
                            // ...
                          ),
                          // ...
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      serverController.servers[serverController.serverIndex]
                          ['country'],
                      style: kDescriptionText.copyWith(
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}