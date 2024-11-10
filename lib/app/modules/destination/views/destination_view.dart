import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/destination_controller.dart';

class DestinationView extends GetView<DestinationController> {
  const DestinationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DestinationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DestinationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
