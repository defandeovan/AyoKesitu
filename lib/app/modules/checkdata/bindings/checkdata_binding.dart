import 'package:get/get.dart';

import '../controllers/checkdata_controller.dart';

class CheckdataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckdataController>(
      () => CheckdataController(),
    );
  }
}
