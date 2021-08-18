import 'package:flutter/material.dart';
import 'package:speed_vpn/helpers/constants.dart';
import 'package:speed_vpn/helpers/size_config.dart';
import 'server_connection_widgets.dart';

class ConnectedScreen extends StatelessWidget {
  final String ipAddress;
  final String pingServer;
  final Widget sessionTime;
  final Function onPress;
  final Function onPressServers;
  final Widget upDown;
  ConnectedScreen({
    @required this.ipAddress,
    this.onPress,
    this.pingServer,
    this.sessionTime,
    this.onPressServers,
    this.upDown,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: getProportionateScreenHeight(50),
              ),
              Text(
                'Current IP:',
                textAlign: TextAlign.center,
                style: kHeadLine4.copyWith(
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Text(
                ipAddress,
                textAlign: TextAlign.center,
                style: kHeadLine3,
              ),
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),
              Container(
                width: SizeConfig.screenWidth / 2.5,
                height: SizeConfig.screenWidth / 2.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 0.5, 0.9],
                    colors: [
                      kPrimaryColor,
                      kPrimaryColor.withOpacity(.3),
                      kPrimaryColor,
                    ],
                  ),
                  border: Border.all(
                    width: 5,
                    color: kSecondaryColor,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimaryColor.withOpacity(0.5),
                      spreadRadius: 8,
                      blurRadius: 0,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.power_settings_new,
                    size: SizeConfig.screenWidth / 8,
                    color: kWhiteColor,
                  ),
                  onPressed: onPress,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              sessionTime,
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              Container(
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Ping: ',
                      style: kDescriptionText.copyWith(
                        fontWeight: FontWeight.w600,
                        color: kBlackColor,
                      ),
                    ),
                    TextSpan(
                      text: pingServer,
                      style: kDescriptionText.copyWith(
                        color: kBlackColor,
                      ),
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              ServerConnectionWidgets(
                onPress: onPressServers,
              ),
              SizedBox(
                height: getProportionateScreenHeight(60),
              ),
              upDown,
            ],
          ))
        ],
      ),
    );
  }
}
