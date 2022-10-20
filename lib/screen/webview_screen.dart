import 'dart:io';

import 'package:alive_and_kicking/models/alive_and_kicking_pages.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {

  const WebViewScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      name: AliveAndKickingPages.aliveAndKicking,
      key: ValueKey(AliveAndKickingPages.aliveAndKicking),
      child: const WebViewScreen(),
    );
  }

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slides of Alive & Kicking'),
      ),
      body: const WebView(
        initialUrl:
            'https://docs.google.com/presentation/d/1qBWM4DabIK-qsj-SWmo4XJR9eyN'
                '563MKkInuXS5Z2wo/mobilepresent?slide=id.p',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
