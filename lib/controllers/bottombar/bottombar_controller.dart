import 'dart:io';

import 'package:get/get.dart';
import 'package:speed_vpn/helpers/permission_settings.dart';
import 'package:open_file/open_file.dart';

class BottombarController extends GetxController {
  var currentPage = 0.obs;
  var value = 0.0.obs;
 // var _openResult;

  var isPermit = false.obs;

  @override
  void onInit() {
    _getPermission();
    super.onInit();
  }

  _getPermission() async {
    isPermit((await PermissionSettings.promptPermissionSetting()));
  }

  Future<void> openFileWithDefaultApp(FileSystemEntity fileSystemEntity) async {
    print("THis is: ${fileSystemEntity.path}");
    String filePath = fileSystemEntity.path;
    OpenResult _result = await OpenFile.open(filePath);

    print("Result message: " + _result.message);
    //_openResult.value = "type=${_result.type}  message=${_result.message}";
  }
}
