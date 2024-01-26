import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class chatbot extends StatefulWidget {
  const chatbot({super.key});

  @override
  State<chatbot> createState() => _chatbotState();
}

class _chatbotState extends State<chatbot> {

  final controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)..loadRequest
 (Uri.parse('https://console.dialogflow.com/api-client/demo/embedded/cba37b96-98fc-4535-ba91-74134e1d9478'));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebViewWidget (controller: controller),
      ),
    );
  }
}