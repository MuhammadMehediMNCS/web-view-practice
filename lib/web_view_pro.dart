import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewDesign2 extends StatelessWidget {
  const WebViewDesign2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyWebView(),
    );
  }
}


class MyWebView extends StatefulWidget {
  const MyWebView({super.key});

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late WebViewController controller;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(await controller.canGoBack()) {
          // Stay in app
          return false;
        } else {
          // Leave app
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.clear, color: Colors.black),
            onPressed: () {
              controller.clearCache();
              CookieManager().clearCookies();
            }
          ),
          title: const Text('Web-View Design', style: TextStyle(color: Colors.black),),
          actions: [
            IconButton(
              icon:const Icon(Icons.arrow_back, color: Colors.black,),
              onPressed: () async {
                if(await controller.canGoBack()) {
                  controller.goBack();
                }
              }
            ),
            IconButton(
              icon:const Icon(Icons.refresh, color: Colors.black,),
              onPressed: () => controller.reload()
            ),
            IconButton(
              icon:const Icon(Icons.import_export, color: Colors.black,),
              onPressed: () {
                controller.evaluateJavascript(
                  "document.getElementsByTagName('header')[0].style.display='none'"
                );
                controller.evaluateJavascript(
                  "document.getElementsByTagName('footer')[0].style.display='none'"
                );
              }
            )
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              color: Colors.blue,
              backgroundColor: Colors.black26,
            ),
            Expanded(
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: 'https://amazon.com',
                onWebViewCreated: (controller) {
                  this.controller = controller;
                },
                onProgress: (progress) => setState(() => this.progress = progress / 100),
                
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.launch),
          onPressed: () async {
            final url = await controller.currentUrl();
    
            controller.loadUrl('https://youtube.com');
          }
        ),
      ),
    );
  }
}