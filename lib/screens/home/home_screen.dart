import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openvpn/flutter_openvpn.dart';
import 'package:get/get.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:speed_vpn/controllers/server_controller/server_screen_controller.dart';
import 'package:speed_vpn/helpers/constants.dart';
import 'package:speed_vpn/helpers/size_config.dart';
import 'package:speed_vpn/screens/home/widgets/connected_screen.dart';
import 'package:speed_vpn/screens/home/widgets/connecting_screen.dart';
import 'package:speed_vpn/screens/home/widgets/server_connection_widgets.dart';
import 'package:speed_vpn/screens/home/widgets/up_down_widget.dart';
import 'package:speed_vpn/screens/server/server_screen.dart';

import 'package:stop_watch_timer/stop_watch_timer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ServerController serverController = Get.put(ServerController());
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final isHours = true;
  dynamic ipAddress = '00.0.000.000';
  String uploadUnitText = 'mb/s';
  String downLoadUnitText = 'kb/s';
  String inSpeed = '0.0 mb/s';
  String upSpeed = '0.0 mb/s';
  String state = 'DISCONNECTED';
  var stream;

  @override
  void initState() {
    super.initState();
    getAddress();
    FlutterOpenvpn.init();
  }

  String removeText(String text) {
    RegExp exp = RegExp(r"-\s\d+|(?:\.\d+)?\s\w+\/s",
        multiLine: true, caseSensitive: true);

    return text.replaceAll(exp, '');
  }

  void getVpnConnected() async {
    var vpnPath = await rootBundle.loadString(
        'assets/vpns/${serverController.servers[serverController.serverIndex]['file']}');
    await FlutterOpenvpn.lunchVpn(
      vpnPath,
      (isProfileLoaded) {
        print('isProfileLoaded : $isProfileLoaded');
      },
      (vpnActivated) {
        print('vpnActivated : $vpnActivated');
        if (vpnActivated == 'NOPROCESS' || vpnActivated == 'WAIT') {
          setState(() {
            state = vpnActivated;
          });
        } else if (vpnActivated == 'CONNECTED') {
          setState(() {
            state = vpnActivated;

            startTimer();
          });
          Get.snackbar(
            'CONNECTED',
            '',
            colorText: kBlackColor,
          );
        } else if (vpnActivated == 'DISCONNECTED') {
          setState(() {
            state = vpnActivated;

            stopTimer();
          });
          Get.snackbar(
            'DISCONNECTED',
            '',
            colorText: kBlackColor,
          );
        }
      },
      user: serverController.servers[serverController.serverIndex]['username'],
      pass: serverController.servers[serverController.serverIndex]['password'],
      onConnectionStatusChanged:
          (duration, lastPacketRecieve, byteIn, byteOut) {
        setState(() {
          inSpeed = byteIn;
          upSpeed = byteOut;
        });
      },
      expireAt: DateTime.now().add(
        Duration(
          hours: 5,
        ),
      ),
    );
  }

  void startTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    getAddress();
  }

  void stopTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    getAddress();
  }

  void getAddress() async {
    var ipAddressTemp = IpAddress(type: RequestType.text);
    var temp = await ipAddressTemp.getIpAddress();
    setState(() {
      ipAddress = temp;
    });
    print(ipAddress);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        if (state == 'NOPROCESS' ||
            state == 'WAIT' ||
            state == 'AUTH' ||
            state == 'GET_CONFIG') {
          FlutterOpenvpn.stopVPN();
        }
        return false;
      },
      child: Scaffold(
        //Drawer Section

        backgroundColor: kWhiteColor,

        body: Container(
          margin: EdgeInsets.only(
            top: 50,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/world_map.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: state == 'CONNECTED'
              ? ConnectedScreen(
                  ipAddress: ipAddress,
                  sessionTime: StreamBuilder<int>(
                    stream: _stopWatchTimer.rawTime,
                    initialData: _stopWatchTimer.rawTime.value,
                    builder: (context, snap) {
                      final value = snap.data;
                      final displayTime = StopWatchTimer.getDisplayTime(value,
                          hours: true, milliSecond: false);
                      return Container(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Session: ',
                              style: kDescriptionText.copyWith(
                                fontWeight: FontWeight.w600,
                                color: kBlackColor,
                              ),
                            ),
                            TextSpan(
                              text: displayTime.toString(),
                              style: kDescriptionText.copyWith(
                                color: kBlackColor,
                              ),
                            ),
                          ]),
                        ),
                      );
                    },
                  ),
                  onPress: () {
                    FlutterOpenvpn.stopVPN();
                    Get.snackbar(
                      'DISCONNECTED',
                      '',
                      colorText: kBlackColor,
                    );
                  },
                  onPressServers: () {
                    Navigator.pushNamed(context, ServersScreen.routeName);
                  },
                  upDown: Row(
                    children: [
                      UpDownWidget(
                        title: 'Upload',
                        icon: Icons.cloud_upload_outlined,
                        speed: removeText(
                              upSpeed,
                            ) +
                            '/s',
                        speedType: '',
                        title2: 'Download',
                        icon2: Icons.cloud_download_outlined,
                        speed2: removeText(
                              inSpeed,
                            ) +
                            '/s',
                        speedType2: '',
                      ),
                    ],
                  ),
                )
              : (state == 'WAIT' || state == 'NOPROCESS'
                  ? ConnectingScreen(
                      onPress: () {},
                    )
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: getProportionateScreenHeight(50),
                          ),
                          Text(
                            'CURRENT IP:',
                            textAlign: TextAlign.center,
                            style: kRegularText.copyWith(
                              color: kSecondaryColor,
                              letterSpacing: 2,
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
                              border: Border.all(
                                width: 5,
                                color: kSecondaryColor.withOpacity(.9),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: kPrimaryColor.withOpacity(0.5),
                                  spreadRadius: 8,
                                  blurRadius: 0,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.1, 0.5, 0.9],
                                colors: [
                                  Color(0xFF0F2D8B),
                                  Color(0xFF315FEF),
                                  Color(0xFF0F2D8B),
                                ],
                              ),
                              color: kPrimaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.power_settings_new,
                                size: SizeConfig.screenWidth / 8,
                                color: kSecondaryColor.withOpacity(.9),
                              ),
                              onPressed: () {
                                getVpnConnected();
                              },
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(30),
                          ),
                          Container(
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Session: ',
                                  style: kDescriptionText.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: kBlackColor,
                                  ),
                                ),
                                TextSpan(
                                  text: '00:00:00',
                                  style: kDescriptionText.copyWith(
                                    color: kBlackColor,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(17),
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
                                  text: "166ms",
                                  style: kDescriptionText.copyWith(
                                    color: kBlackColor,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(17),
                          ),
                          ServerConnectionWidgets(
                            onPress: () {
                              Get.toNamed("/server");
                            },
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(60),
                          ),
                          UpDownWidget(
                            title: 'Upload',
                            icon: Icons.cloud_upload_outlined,
                            speed: '0.0',
                            speedType: uploadUnitText,
                            title2: 'Download',
                            icon2: Icons.cloud_download_outlined,
                            speed2: '0.0',
                            speedType2: downLoadUnitText,
                          ),
                        ],
                      ),
                    )),
        ),
      ),
    );
  }
}
