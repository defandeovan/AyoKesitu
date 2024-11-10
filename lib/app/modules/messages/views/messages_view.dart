import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_flutter/app/routes/app_pages.dart';
import '../controllers/messages_controller.dart';

class MessagesView extends StatelessWidget {
  final MessagesController controller = Get.put(MessagesController());

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
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 24),
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
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                      decoration: BoxDecoration(
                        color: controller.isNotificationSelected.value
                            ? Colors.green
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Notifikasi',
                        style: TextStyle(
                          color: controller.isNotificationSelected.value
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          SizedBox(height: 24),
          Expanded(
            child: Obx(() {
              if (controller.isChatSelected.value) {
                // Daftar Chat
                return ListView(
                  children: [
                    chatTile('Admin 1', 'Halo', '12.00', 'assets/img/admin1.png'),
                    chatTile('Admin 2', 'Halo', '12.00', 'assets/img/admin2.png'),
                    chatTile('Admin 3', 'Halo', '12.00', 'assets/img/admin3.png'),
                  ],
                );
              } else {
                // Daftar Notifikasi
                return ListView(
                  children: [
                    notificationTile('Ayo Kesitu!', 'Ada promo menarik buat kamu!', '12.00'),
                  ],
                );
              }
            }),
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

  Widget notificationTile(String title, String description, String time) {
    return ListTile(
      leading: Icon(Icons.notifications, color: Colors.green),
      title: Text(title),
      subtitle: Text(description),
      trailing: Text(time),
    );
  }
}
