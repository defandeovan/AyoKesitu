import 'package:get/get.dart';

import '../controllers/add_dest_controller.dart';

class AddDestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDestController>(
      () => AddDestController(),
    );
  }
}
