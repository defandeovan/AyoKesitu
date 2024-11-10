import 'package:get/get.dart';

import '../controllers/your_order_controller.dart';

class YourOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YourOrderController>(
      () => YourOrderController(),
    );
  }
}
