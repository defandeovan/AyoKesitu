import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/your_order_controller.dart';

class YourOrderView extends GetView<YourOrderController> {
  const YourOrderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YourOrderView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'YourOrderView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
