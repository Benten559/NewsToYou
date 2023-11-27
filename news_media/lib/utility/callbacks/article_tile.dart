import 'package:NewsToYou/WebView/webview.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// At this time, an in-app webview is only supported on Andriod/iOS compiled versions
/// If a user is running on a webbrowser, this will open a separate tab for them.
void handleURLButtonPress(BuildContext context, String url) {
  if (kIsWeb) {
    final uri = Uri.parse(url);
    launchUrl(uri);
  } else {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WebViewPage(url)));
  }
}
