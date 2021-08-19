import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speed_vpn/screens/file/components/common.dart';
import 'package:speed_vpn/screens/file/components/file_manager.dart';

class FileScreen extends StatefulWidget {
  @override
  _FileScreenState createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  bool isPermit = false;

  @override
  void initState() {
    super.initState();

    //   Future.wait([initializeDateFormatting("zh_CN", null), getPermission()])
    //     .then((result) {
    //   runApp(MyApp());
    // });

    getPermission();
  }

  Future<void> getSDCardDir() async {
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();

    Common().rootPath = storageInfo[0].rootDir;
  }

  // Permission check
  void getPermission() async {
    if (Platform.isAndroid) {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);

      if (permission != PermissionStatus.granted) {
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      } else {
        await getSDCardDir();
        isPermit = true;
      }
    } else if (Platform.isIOS) {
      await getSDCardDir();
      isPermit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isPermit ? FileManager() : CircularProgressIndicator(),
    );
  }
}
