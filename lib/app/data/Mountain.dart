import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const Mountain(title: 'hALAMAN1',));
}

class Mountain extends StatelessWidget {
  const Mountain({super.key, required String title});

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
          'https://www.traveloka.com/id-id/explore/destination/menjelajahi-wisata-gunung-terpopuler-di-indonesia-acc/89421'));
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
          title: const Text('Recomendation Mountains'),
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
