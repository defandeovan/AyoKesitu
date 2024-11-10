import 'package:get/get.dart';

class PayMethodController extends GetxController {
  var selectedMethod = ''.obs;

  void selectMethod(String method) {
    selectedMethod.value = method;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
