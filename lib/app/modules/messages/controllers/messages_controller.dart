import 'package:get/get.dart';

class MessagesController extends GetxController {
  var isChatSelected = true.obs;
  var isNotificationSelected = false.obs; 

  void toggleTab(bool isChat) {
    isChatSelected.value = isChat;
     isChatSelected.value = isChat;
    isNotificationSelected.value = !isChat;
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
