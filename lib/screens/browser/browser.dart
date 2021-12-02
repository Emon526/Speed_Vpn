import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class BrowserScreen extends StatelessWidget {
  const BrowserScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: "https://google.com",
      withZoom: false,
    );
  }
}
