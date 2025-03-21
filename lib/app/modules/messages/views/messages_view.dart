import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_flutter/app/modules/messages/views/chatMessage.dart';
import 'package:project_flutter/app/routes/app_pages.dart';
import '../controllers/messages_controller.dart';
class MessagesView extends StatelessWidget {
  final String userId; // Tambahkan userId sebagai parameter
  MessagesView({required this.userId});

  final MessagesController controller = Get.put(MessagesController());
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.getUserRole(userId); // Panggil saat build untuk mendapatkan role user

    return Scaffold(
      appBar: AppBar(title: Text('Chat Messages')),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.chatMessages.length,
                itemBuilder: (context, index) {
                  final chat = controller.chatMessages[index];
                  return ListTile(
                    title: Text(chat.sender, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(chat.message),
                    trailing: Text(chat.timestamp.substring(11, 16)), // Menampilkan jam dan menit
                  );
                },
              );
            }),
          ),
          Obx(() {
            return controller.userRole.value == 'admin' || controller.userRole.value == 'user'
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            decoration: InputDecoration(
                              hintText: "Ketik pesan...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send, color: Colors.blue),
                          onPressed: () {
                            if (messageController.text.isNotEmpty) {
                              controller.sendMessage(userId, "User", messageController.text);
                              messageController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  )
                : Center(child: Text("Anda tidak memiliki izin untuk mengirim pesan"));
          }),
        ],
      ),
    );
  }
}
