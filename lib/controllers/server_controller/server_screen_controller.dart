import 'package:get/get.dart';

class ServerController extends GetxController {
  int serverIndex = 0;
  var isLoading = false.obs;
  List<Map<String, String>> servers = [
    {
      "country": "Fastest Server",
      "flag": "speed.png",
      "file": "usa_dns.ovpn",
      "username": "vpn",
      "password": "vpn",
      "premium": "false",
    },
    {
      "country": "United State",
      "flag": "us.png",
      "file": "usa_dns.ovpn",
      "username": "vpn",
      "password": "vpn",
      "premium": "false",
    },
    {
      "country": "United State 2",
      "flag": "us.png",
      "file": "usa_vpn.ovpn",
      "username": "vpn",
      "password": "vpn",
      "premium": "false",
    },
    {
      "country": "Japan",
      "flag": "japan.png",
      "file": "japan_dns.ovpn",
      "username": "vpn",
      "password": "vpn",
      "premium": "false",
    },
    {
      "country": "Japan 2",
      "flag": "japan.png",
      "file": "japan_dns2.ovpn",
      "username": "vpn",
      "password": "vpn",
      "premium": "false",
    },
    {
      "country": "Germany",
      "flag": "ger.png",
      "file": "german_vpn.ovpn",
      "username": "vpn",
      "password": "vpn",
      "premium": "false",
    },
    {
      "country": "Netherland",
      "flag": "net.png",
      "file": "netherland_vpn.ovpn",
      "username": "vpn",
      "password": "vpn",
      "premium": "false",
    },
    {
      "country": "Russia",
      "flag": "japan.png",
      "file": "russia_vpn1.ovpn",
      "username": "vpn",
      "password": "vpn",
      "premium": "false",
    },
    {
      "country": "Russia 2",
      "flag": "japan.png",
      "file": "russia_vpn2.ovpn",
      "username": "vpn",
      "password": "vpn",
      "premium": "false",
    },
    {
      "country": "United Kingdom",
      "flag": "uk.png",
      "file": "uk_vpn.ovpn",
      "username": "vpn",
      "password": "vpn",
      "premium": "false",
    },
  ];

  void changeServer(int val) {
    try {
      isLoading(true);
      serverIndex = val;
    } finally {
      isLoading(false);
    }
  }
}