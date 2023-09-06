import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WebViewDesign(),
    );
  }
}

class WebViewDesign extends StatefulWidget {
  const WebViewDesign({super.key});

  @override
  State<WebViewDesign> createState() => _WebViewDesignState();
}

class _WebViewDesignState extends State<WebViewDesign> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView'),
      ),
      body: WebView(
        // webview_flutter: ^2.0.12
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:'https://amazon.com',
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
        onPageStarted: (url) {
          print('New Website: $url');

          /*
          // Hide header and footer of website.
          if(url.contains('www.amazon.com')) {
            Future.delayed(Duration(milliseconds: 300), () {
              controller.evaluateJavascript(
                "document.getElementsByTagName('header')[0].style.display='none'"
              );
              controller.evaluateJavascript(
                "document.getElementsByTagName('footer')[0].style.display='none'"
              );
            });
          }
          */
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.import_export, size: 32),
        onPressed: () async {

          controller.evaluateJavascript(
            "document.getElementsByTagName('header')[0].style.display='none'"
          );
          controller.evaluateJavascript(
            "document.getElementsByTagName('footer')[0].style.display='none'"
          );


          /*
          final url = await controller.currentUrl();
          print('Previous Website: $url');

          controller.loadUrl('https://youtube.com');
          */
        }
      ),
    );
  }
}