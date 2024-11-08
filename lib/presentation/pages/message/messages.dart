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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Message",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 600,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => controller.toggleTab(true),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                          decoration: BoxDecoration(
                            color: controller.isChatSelected.value ? Colors.green : Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Chat',
                            style: TextStyle(
                              color: controller.isChatSelected.value ? Colors.white : Colors.black,
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
                            color: !controller.isChatSelected.value ? Colors.green : Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Notifikasi',
                            style: TextStyle(
                              color: !controller.isChatSelected.value ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 20),
              Obx(() => controller.isChatSelected.value ? ChatView() : NotificationView()),
            ],
          ),
        ),
      ),
    );
  }
}

// Tampilan untuk "Chat"
class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          chatTile('Admin 1', 'Halo', '12.00', 'assets/img/admin1.png'),
          chatTile('Admin 2', 'Halo', '12.00', 'assets/img/admin2.png'),
          chatTile('Admin 3', 'Halo', '12.00', 'assets/img/admin3.png'),
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

// Tampilan untuk "Notifikasi"
class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            title: Text(
              "Ayo Kesitu!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Ada promo menarik buat kamu!"),
            trailing: Text("12.00"),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MessagePage(),
    );
  }
}
