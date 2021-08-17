import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_manager/file_manager.dart';
import 'package:get/get.dart';
import 'package:speed_vpn/controllers/bottombar/bottombar_controller.dart';
import 'package:speed_vpn/screens/file/fileitemWidget.dart';

class FileScreen extends StatelessWidget {
  FileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FileManagerController controller = FileManagerController();
    return WillPopScope(
        onWillPop: () async {
          if (await controller.isRootDirectory()) {
            return true;
          } else {
            controller.goToParentDirectory();
            return false;
          }
        },
        child: Container(
            child: FileManager(
                controller: controller,
                builder: (context, snapshot) {
                  final List<FileSystemEntity> entities = snapshot;

                  return GridView.builder(
                    physics: BouncingScrollPhysics(),
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
                    itemCount: entities.length > 0 ? entities.length : 0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0),
                    itemBuilder: (context, index) {
                      FileSystemEntity entity = entities[index];

                      return GestureDetector(
                        onTap: () async {
                          print("folder clicked");
                          if (FileManager.isDirectory(entity)) {
                            // open the folder
                            controller.openDirectory(entity);
                          } else {
                            Get.find<BottombarController>()
                                .openFileWithDefaultApp(
                                    entities.elementAt(index));
                          }
                        },
                        child: FileitemWidget(
                          entity: entity,
                        ),
                      );
                    },
                  );
                })));
  }

  Widget subtitle(FileSystemEntity entity) {
    return FutureBuilder<FileStat>(
      future: entity.stat(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (entity is File) {
            int size = snapshot.data.size;

            return Text(
              "${FileManager.formatBytes(size)}",
            );
          }
          return Text(
            "${snapshot.data.modified}",
          );
        } else {
          return Text("");
        }
      },
    );
  }
}
