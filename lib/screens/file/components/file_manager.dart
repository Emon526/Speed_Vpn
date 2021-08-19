import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;
import 'package:intl/intl.dart';
import 'package:speed_vpn/screens/file/components/common.dart';

class FileManager extends StatefulWidget {
  @override
  _FileManagerState createState() => _FileManagerState();
}

class _FileManagerState extends State<FileManager> {
  List<FileSystemEntity> currentFiles = [];
  Directory currentDir;
  ScrollController controller = ScrollController();
  List<double> position = [];

  @override
  void initState() {
    super.initState();
    getCurrentPathFiles(Common().rootPath);
  }

  Future<bool> onWillPop() async {
    if (currentDir.path != Common().rootPath) {
      getCurrentPathFiles(currentDir.parent.path);
      jumpToPosition(false);
    } else {
      SystemNavigator.pop();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            currentDir?.path == Common().rootPath
                ? ''
                : p.basename(currentDir.path),
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Color(0xffeeeeee),
          elevation: 0.0,
          leading: currentDir?.path == Common().rootPath
              ? Container()
              : IconButton(
                  icon: Icon(Icons.chevron_left, color: Colors.black),
                  onPressed: onWillPop),
        ),
        body: currentFiles.length == 0
            ? Center(child: Text('The folder is empty'))
            : Scrollbar(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: controller,
                  itemCount: currentFiles.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (FileSystemEntity.isFileSync(currentFiles[index].path))
                      return _buildFileItem(currentFiles[index]);
                    else
                      return _buildFolderItem(currentFiles[index]);
                  },
                ),
              ),
      ),
    );
  }

  Widget _buildFileItem(FileSystemEntity file) {
    String modifiedTime = DateFormat('yyyy-MM-dd HH:mm:ss', 'zh_CN')
        .format(file.statSync().modified.toLocal());

    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
        ),
        child: ListTile(
          leading: _buildImage(file.path),
          title: Text(file.path.substring(file.parent.path.length + 1)),
          subtitle: Text(
              '$modifiedTime  ${Common().getFileSize(file.statSync().size)}',
              style: TextStyle(fontSize: 12.0)),
        ),
      ),
      onTap: () {
        OpenFile.open(file.path);
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CupertinoButton(
                  pressedOpacity: 0.6,
                  child: Text('Rename',
                      style: TextStyle(color: Color(0xff333333))),
                  onPressed: () {
                    Navigator.pop(context);
                    renameFile(file);
                  },
                ),
                CupertinoButton(
                  pressedOpacity: 0.6,
                  child: Text('Delete',
                      style: TextStyle(color: Color(0xff333333))),
                  onPressed: () {
                    Navigator.pop(context);
                    deleteFile(file);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildImage(String path) {
    switch (p.extension(path)) {
      case '.jpg':
      case '.jpeg':
      case '.png':
        return Image.file(File(path),
            width: 40.0, height: 40.0, fit: BoxFit.cover);
      default:
        return Image.asset(Common().selectIcon(p.extension(path)),
            width: 40.0, height: 40.0);
    }
  }

  Widget _buildFolderItem(FileSystemEntity file) {
    String modifiedTime = DateFormat('yyyy-MM-dd HH:mm:ss', 'zh_CN')
        .format(file.statSync().modified.toLocal());

    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
        ),
        child: ListTile(
          leading: Image.asset('assets/images/folder.png'),
          title: Row(
            children: <Widget>[
              Expanded(
                  child:
                      Text(file.path.substring(file.parent.path.length + 1))),
              Text(
                '${_calculateFilesCountByFolder(file)}item',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          subtitle: Text(modifiedTime, style: TextStyle(fontSize: 12.0)),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
      onTap: () {
        position.add(controller.offset);
        getCurrentPathFiles(file.path);
        jumpToPosition(true);
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CupertinoButton(
                  pressedOpacity: 0.6,
                  child: Text('Rename',
                      style: TextStyle(color: Color(0xff333333))),
                  onPressed: () {
                    Navigator.pop(context);
                    renameFile(file);
                  },
                ),
                CupertinoButton(
                  pressedOpacity: 0.6,
                  child: Text('Delete',
                      style: TextStyle(color: Color(0xff333333))),
                  onPressed: () {
                    Navigator.pop(context);
                    deleteFile(file);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  int _calculatePointBegin(List<FileSystemEntity> fileList) {
    int count = 0;
    for (var v in fileList) {
      if (p.basename(v.path).substring(0, 1) == '.') count++;
    }

    return count;
  }

  int _calculateFilesCountByFolder(Directory path) {
    var dir = path.listSync();
    int count = dir.length - _calculatePointBegin(dir);

    return count;
  }

  void jumpToPosition(bool isEnter) async {
    if (isEnter)
      controller.jumpTo(0.0);
    else {
      try {
        await Future.delayed(Duration(milliseconds: 1));
        controller?.jumpTo(position[position.length - 1]);
      } catch (e) {}
      position.removeLast();
    }
  }

  void getCurrentPathFiles(String path) {
    try {
      currentDir = Directory(path);
      List<FileSystemEntity> _files = [];
      List<FileSystemEntity> _folder = [];

      for (var v in currentDir.listSync()) {
        if (p.basename(v.path).substring(0, 1) == '.') {
          continue;
        }
        if (FileSystemEntity.isFileSync(v.path))
          _files.add(v);
        else
          _folder.add(v);
      }

      _files
          .sort((a, b) => a.path.toLowerCase().compareTo(b.path.toLowerCase()));
      _folder
          .sort((a, b) => a.path.toLowerCase().compareTo(b.path.toLowerCase()));
      setState(() {
        currentFiles.clear();
        currentFiles.addAll(_folder);
        currentFiles.addAll(_files);
      });
    } catch (e) {
      print(e);
      print("Directory does not exist！");
    }
  }

  void deleteFile(FileSystemEntity file) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Confirm delete'),
          content: Text('Unrecoverable after deletion'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Cancel', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text('OK', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                if (file.statSync().type == FileSystemEntityType.directory) {
                  Directory directory = Directory(file.path);
                  directory.deleteSync(recursive: true);
                } else if (file.statSync().type == FileSystemEntityType.file) {
                  file.deleteSync();
                }

                getCurrentPathFiles(file.parent.path);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void renameFile(FileSystemEntity file) {
    TextEditingController _controller = TextEditingController();

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: CupertinoAlertDialog(
              title: Text('Rename'),
              content: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0)),
                    hintText: 'Please enter a new name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0)),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Cancel', style: TextStyle(color: Colors.blue)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text('OK', style: TextStyle(color: Colors.blue)),
                  onPressed: () async {
                    String newName = _controller.text;
                    if (newName.trim().length == 0) {
                      Fluttertoast.showToast(
                          msg: 'Name cannot be empty',
                          gravity: ToastGravity.CENTER);
                      return;
                    }

                    String newPath = file.parent.path +
                        '/' +
                        newName +
                        p.extension(file.path);
                    file.renameSync(newPath);
                    getCurrentPathFiles(file.parent.path);

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
