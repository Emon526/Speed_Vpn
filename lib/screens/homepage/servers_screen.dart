import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_vpn/controllers/servers_controller.dart';
import 'package:speed_vpn/helpers/constants.dart';
import 'package:speed_vpn/helpers/size_config.dart';

class ServersScreen extends StatelessWidget {
  static const routeName = 'servers_screen';
  final ServerController serverController = Get.find();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kBlackColor),
        backgroundColor: kWhiteColor,
        elevation: 0,
        title: Text(
          "Servers",
          style: TextStyle(
            color: kBlackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/world_map.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Obx(
          () {
            if (serverController.isLoading.isTrue) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (serverController.servers.isEmpty) {
                return Center(
                  child: Text(
                    'No Servers Available',
                    style: kRegularText,
                  ),
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: serverController.servers.length,
                    itemBuilder: (context2, int index) {
                      return GestureDetector(
                        onTap: () {
                          serverController.changeServer(index);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: serverController.serverIndex == index
                                ? kPrimaryColor
                                : kWhiteColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey.withOpacity(.5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              leading: Container(
                                width: getProportionateScreenWidth(35),
                                height: getProportionateScreenWidth(35),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/' +
                                          serverController.servers[index]
                                              ['flag'],
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                serverController.servers[index]['country'],
                                style: kRegularText.copyWith(
                                  color: serverController.serverIndex == index
                                      ? kWhiteColor
                                      : Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: serverController.serverIndex == index
                                  ? Icon(
                                      Icons.check_circle,
                                      color: kWhiteColor,
                                      size: 20,
                                    )
                                  : Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey,
                                          )),
                                    )),
                        ),
                      );
                    });
              }
            }
          },
        ),
      ),
    );
  }
}
