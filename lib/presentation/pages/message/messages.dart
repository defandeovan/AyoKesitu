import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  var isChatSelected = true.obs;

  void toggleTab(bool isChat) {
    isChatSelected.value = isChat;
  }
}

class MessagePage extends StatelessWidget {
  final MessageController controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => controller.toggleTab(true),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                      decoration: BoxDecoration(
                        color: controller.isChatSelected.value
                            ? Colors.green
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Chat',
                        style: TextStyle(
                          color: controller.isChatSelected.value
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => controller.toggleTab(false),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                      decoration: BoxDecoration(
                        color: !controller.isChatSelected.value
                            ? Colors.grey[300]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Notifikasi',
                        style: TextStyle(
                          color: !controller.isChatSelected.value
                              ? Colors.black
                              : Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: [
                chatTile('Admin 1', 'Halo', '12.00', 'assets/img/admin1.png'),
                chatTile('Admin 2', 'Halo', '12.00', 'assets/img/admin2.png'),
                chatTile('Admin 3', 'Halo', '12.00', 'assets/img/admin3.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget chatTile(String name, String message, String time, String avatarPath) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(avatarPath),
      ),
      title: Text(name),
      subtitle: Text(message),
      trailing: Text(time),
    );
  }
}
