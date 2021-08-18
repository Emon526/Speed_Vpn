// import 'dart:io';

// import 'package:file_manager/file_manager.dart';
// import 'package:flutter/material.dart';

// class FileitemWidget extends StatelessWidget {
//   const FileitemWidget({Key key, this.entity}) : super(key: key);
//   final FileSystemEntity entity;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           FileManager.isFile(entity)
//               ? Icon(
//                   Icons.feed_outlined,
//                   color: Colors.deepPurple,
//                   size: 70,
//                 )
//               : Icon(
//                   Icons.folder,
//                   color: Colors.deepPurple,
//                   size: 70,
//                 ),
//           Container(
//             alignment: Alignment.center,
//             width: 80.0,
//             child: Text(
//               FileManager.basename(entity),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
