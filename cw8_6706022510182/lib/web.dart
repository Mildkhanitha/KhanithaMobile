import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web extends StatefulWidget {
  const Web({super.key});

  @override
  State<Web> createState() => _webtState();
}

class _webtState extends State<Web> {
  late final WebViewController _controller;

  @override
  void initState (){
    super.initState();
    _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse("https://kmutnb.ac.th/"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Website KMUTNB"),backgroundColor: Colors.orange,),
      body: WebViewWidget(controller: _controller),
    );
  }
}