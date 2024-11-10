import 'package:get/get.dart';

import '../controllers/pay_method_controller.dart';

class PayMethodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PayMethodController>(
      () => PayMethodController(),
    );
  }
}
