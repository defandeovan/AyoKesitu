import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_flutter/app/modules/home/views/location_view.dart';

import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FavoriteView'),
        centerTitle: true,
      ),
      body: const Center(
        
      ),
    );
  }
}
