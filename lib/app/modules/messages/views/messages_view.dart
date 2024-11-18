import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_flutter/app/routes/app_pages.dart';
import '../controllers/messages_controller.dart';

class MessagesView extends StatelessWidget {
  final MessagesController controller = Get.put(MessagesController());
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 16),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 317,
                    height: 38,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.black.withOpacity(0.2), // Warna bayangan
                          blurRadius: 10, // Tingkat blur
                          offset: const Offset(0, 5), // Posisi bayangan
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => controller.toggleTab(true),
                          child: Container(
                            width: 152, // Ganti dengan lebar yang Anda inginkan
                            height: 34,
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 60),

                            decoration: BoxDecoration(
                              color: controller.isChatSelected.value
                                  ? Colors.green
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
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
                            width: 152, // Ganti dengan lebar yang Anda inginkan
                            height: 34,
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 40),
                            decoration: BoxDecoration(
                              color: controller.isNotificationSelected.value
                                  ? Colors.green
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
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
                    ),
                  )
                ],
              )),
          SizedBox(height: 24),
          Expanded(
            child: Obx(() {
              if (controller.isChatSelected.value) {
                // Daftar Chat
                return ListView(
                  children: [
                    chatTile(
                        'Admin 1', 'Halo', '12.00', 'assets/img/admin1.png'),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: DottedLine(
                        lineThickness: 2, // Ketebalan garis
                        dashColor: Color(0xFFD9D9D9), // Warna garis
                        dashLength: 5, // Panjang tiap dash
                        dashGapLength:
                            0, // Tidak ada celah, sehingga menjadi garis lurus
                      ),
                    ),
                    chatTile(
                        'Admin 2', 'Halo', '12.00', 'assets/img/admin2.png'),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: DottedLine(
                        lineThickness: 2, // Ketebalan garis
                        dashColor: Color(0xFFD9D9D9), // Warna garis
                        dashLength: 5, // Panjang tiap dash
                        dashGapLength:
                            0, // Tidak ada celah, sehingga menjadi garis lurus
                      ),
                    ),
                    chatTile(
                        'Admin 3', 'Halo', '12.00', 'assets/img/admin3.png'),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: DottedLine(
                        lineThickness: 2, // Ketebalan garis
                        dashColor: Color(0xFFD9D9D9), // Warna garis
                        dashLength: 5, // Panjang tiap dash
                        dashGapLength:
                            0, // Tidak ada celah, sehingga menjadi garis lurus
                      ),
                    ),
                  ],
                );
              } else {
                // Daftar Notifikasi
                return ListView(
                  children: [
                    notificationTile(
                        'Ayo Kesitu!', 'Ada promo menarik buat kamu!', '12.00'),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: DottedLine(
                        lineThickness: 2, // Ketebalan garis
                        dashColor: Color(0xFFD9D9D9), // Warna garis
                        dashLength: 5, // Panjang tiap dash
                        dashGapLength:
                            0, // Tidak ada celah, sehingga menjadi garis lurus
                      ),
                    ),
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
  return GestureDetector(
    onTap: () {
      // Navigate to the chat screen with the user's chat details
      Get.toNamed(Routes.CHAT);
    },
    child: ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(avatarPath),
      ),
      title: Text(name),
      subtitle: Text(message),
      trailing: Text(time),
    ),
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
