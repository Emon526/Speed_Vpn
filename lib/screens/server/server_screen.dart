import 'package:flutter/material.dart';
import 'package:speed_vpn/helpers/constants.dart';
import 'package:speed_vpn/helpers/size_config.dart';
import 'package:speed_vpn/screens/server/body.dart';

class ServersScreen extends StatelessWidget {
  static const routeName = 'servers_screen';

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
      body: Body(),
    );
  }
}
