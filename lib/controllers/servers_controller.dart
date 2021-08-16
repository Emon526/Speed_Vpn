import 'package:get/get.dart';

class ServerController extends GetxController {
  int serverIndex = 0;
  var isLoading = false.obs;
  List<Map<String, String>> servers = [
    {
      "country": "United States",
      "flag": "us.png",
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
