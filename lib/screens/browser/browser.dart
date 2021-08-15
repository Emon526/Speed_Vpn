import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Browser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15),
        child: AppBar(
          backgroundColor: Colors.white,
        ),
      ),
      body: WebviewScaffold(
        url: "https://google.com",
        withZoom: false,
      ),
    );
  }
}
