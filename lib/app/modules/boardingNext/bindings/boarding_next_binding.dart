import 'package:get/get.dart';

import '../controllers/boarding_next_controller.dart';

class BoardingNextBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BoardingNextController>(
      () => BoardingNextController(),
    );
  }
}
