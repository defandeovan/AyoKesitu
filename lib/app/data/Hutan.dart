import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const Hutan(title: 'hALAMAN1',));
}

class Hutan extends StatelessWidget {
  const Hutan({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter WebView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WebViewPage(),
    );
  }
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          'https://www.enervon.co.id/article/5583/wisata-hutan'));
  }

  Future<bool> _onWillPop() async {
    if (await _controller.canGoBack()) {
      // Jika ada halaman sebelumnya, kembali ke halaman tersebut
      _controller.goBack();
      return false; // Tidak keluar dari aplikasi
    }
    return true; // Keluar dari aplikasi
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Recomendation'),
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
