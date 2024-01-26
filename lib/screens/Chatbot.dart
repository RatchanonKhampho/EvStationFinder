import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class chatbot extends StatefulWidget {
  const chatbot({super.key});

  @override
  State<chatbot> createState() => _chatbotState();
}

class _chatbotState extends State<chatbot> {

  final controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)..loadRequest
 (Uri.parse('https://evcharger-d3288.web.app/'));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: WebViewWidget (controller: controller)),
        ),
      ),
    );
  }
}