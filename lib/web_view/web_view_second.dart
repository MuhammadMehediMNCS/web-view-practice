import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewSecond extends StatelessWidget {
  const WebViewSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WebClearCacheCookie(),
    );
  }
}

class WebClearCacheCookie extends StatefulWidget {
  const WebClearCacheCookie({super.key});

  @override
  State<WebClearCacheCookie> createState() => _WebClearCacheCookieState();
}

class _WebClearCacheCookieState extends State<WebClearCacheCookie> {
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
          leading: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              controller.clearCache();
              CookieManager().clearCookies();
            }
          ),
          title: const Text('WebView'),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                if(await controller.canGoBack()) {
                  controller.goBack();
                }
              }
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => controller.reload()
            )
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              color: Colors.red,
              backgroundColor: Colors.black12,
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
      ),
    );
  }
}