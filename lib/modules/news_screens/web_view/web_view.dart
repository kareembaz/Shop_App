import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webViewScreen extends StatelessWidget {
  late final String url;
  webViewScreen(this.url);
  final webveeiwController = WebViewController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: WebViewWidget(
          controller: webveeiwController..loadRequest(Uri.parse(url)),
        ));
  }
}
