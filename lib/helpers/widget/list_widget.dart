import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_vpn/controllers/server_controller/server_screen_controller.dart';
import 'package:speed_vpn/helpers/constants.dart';
import 'package:speed_vpn/helpers/size_config.dart';

class ListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ServerController serverController = Get.put(ServerController());

    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: serverController.servers.length,
      itemBuilder: (context2, int index) {
        return InkWell(
          onTap: () {
            serverController.changeServer(index);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            decoration: BoxDecoration(
              color: serverController.serverIndex == index
                  ? kPrimaryColor
                  : kWhiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.withOpacity(.3),
              ),
            ),
            child: ListTile(
              leading: Container(
                width: getProportionateScreenWidth(35),
                height: getProportionateScreenWidth(35),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/' +
                          serverController.servers[index]['flag'],
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
                      size: 25,
                    )
                  : Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
