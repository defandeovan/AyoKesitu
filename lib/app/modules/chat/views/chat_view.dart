import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter/app/modules/chat/controllers/chat_controller.dart';

import 'package:video_player/video_player.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white),
            ),
            SizedBox(width: 10),
            Text('Admin'),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              // Urutkan pesan berdasarkan waktu
              controller.sortMessages();

              // Menampilkan semua pesan dalam bubble
              return ListView(
                // Menghapus reverse: true agar pesan baru muncul di bawah
                children: controller.messages.map((message) {
                  if (message['type'] == 'image') {
                    return _buildImageBubble(
                        message['content'], message['timestamp']);
                  } else if (message['type'] == 'text') {
                    return _buildTextBubble(
                        message['content'], message['timestamp']);
                  } else if (message['type'] == 'video') {
                    return _buildVideoBubble(
                        message['content'], message['timestamp']);
                  } else if (message['type'] == 'audio') {
                    return _buildAudioBubble(
                        message['content'], message['timestamp']);
                  } else {
                    return Container(); // Untuk tipe pesan yang tidak diketahui
                  }
                }).toList(),
              );
            }),
          ),
          Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color.fromARGB(235, 222, 222, 222),
                border: Border.all(
                  color: const Color.fromARGB(255, 162, 162, 162),
                  width: 1.5,
                ),
              ),
              child: Row(children: [
                GestureDetector(
                  onTap: () => _showMediaPickerBottomSheet(context),
                  child: SvgPicture.asset(
                    'assets/img/add.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 35,
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      border: Border.all(
                        color: const Color.fromARGB(255, 162, 162, 162),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: controller.textController,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onLongPress: controller.startRecording,
                  onLongPressUp: controller.stopRecording,
                  child: SvgPicture.asset(
                    'assets/img/mic.svg', // Tambahkan ikon mikrofon sesuai aset Anda
                    width: 24,
                    height: 24,
                  ),
                ),
                GestureDetector(
                  onTap: controller.sendMessage,
                  child: SvgPicture.asset(
                    'assets/img/send_chat.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ]))
        ],
      ),
    );
  }

  // Menampilkan menu untuk memilih media (gambar/video)
  void _showMediaPickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Take Photo"),
                onTap: () {
                  controller.pickImageFromCamera();
                  Navigator.pop(context); // Menutup menu setelah memilih opsi
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("Choose from Gallery"),
                onTap: () {
                  controller.pickImageFromGallery();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam),
                title: Text("Record Video"),
                onTap: () {
                  controller.pickVideoFromCamera();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.video_library),
                title: Text("Choose Video from Gallery"),
                onTap: () {
                  controller.pickVideoFromGallery();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextBubble(String text, DateTime timestamp) {
    String formattedTime = DateFormat('hh:mm a').format(timestamp);

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.0, right: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Color(0xFF00A550),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 4), // Spasi antara pesan dan waktu
            Text(
              formattedTime, // Menampilkan waktu
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageBubble(File image, DateTime timestamp) {
    String formattedTime = DateFormat('hh:mm a').format(timestamp);

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.0, right: 10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color(0xFF00A550),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                image,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 4), // Spasi antara gambar dan waktu
            Text(
              formattedTime, // Menampilkan waktu
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoBubble(File video, DateTime timestamp) {
    String formattedTime = DateFormat('hh:mm a').format(timestamp);

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.0, right: 10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color(0xFF00A550),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            VideoBubble(video: video), // Video player bubble
            SizedBox(height: 4), // Spasi antara video dan waktu
            Text(
              formattedTime, // Menampilkan waktu
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}Widget _buildAudioBubble(File audioFile, DateTime timestamp) {
  String formattedTime = DateFormat('hh:mm a').format(timestamp);
  
  final AudioPlayer audioPlayer = AudioPlayer(); // Gunakan instance yang sudah ada

  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      margin: EdgeInsets.only(bottom: 8.0, right: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xFF00A550),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(Icons.play_arrow, color: Colors.white),
            onPressed: () async {
              try {
                // Jika audio sedang diputar, hentikan dulu
                await audioPlayer.stop(); 

                // Pastikan audio file ada dan bisa diputar
                bool fileExists = await audioFile.exists();
                if (fileExists) {
                  await audioPlayer.play(DeviceFileSource(audioFile.path));
                  print("Playing audio...");
                } else {
                  print("File not found.");
                }
              } catch (e) {
                print('Error saat memutar audio: $e');
              }
            },
          ),
          SizedBox(height: 4),
          Text(
            formattedTime,
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    ),
  );
}



class VideoBubble extends StatefulWidget {
  final File video;

  VideoBubble({required this.video});

  @override
  _VideoBubbleState createState() => _VideoBubbleState();
}

class _VideoBubbleState extends State<VideoBubble> {
  late VideoPlayerController _controller;
  bool _isPlaying =
      false; // Menyimpan status apakah video sedang diputar atau dipause

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.video)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // Fungsi untuk toggle play/pause
  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: _togglePlayPause,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
              // Tombol Play/Pause
              IconButton(
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: _togglePlayPause,
              ),
            ],
          )
        : Container();
  }
}
