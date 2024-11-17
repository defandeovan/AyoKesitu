import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  var selectedImages = <File>[].obs; // Daftar gambar yang dipilih
  var selectedVideos = <File>[].obs; // Daftar video yang dipilih
  var messages =
      <Map<String, dynamic>>[].obs; // Menyimpan pesan teks, gambar, dan video

  var textController = TextEditingController();

  // Mengambil gambar dari galeri
  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      // Menambahkan gambar-gambar yang dipilih ke dalam daftar
      for (var image in images) {
        selectedImages.add(File(image.path));
      }
    }
  }

  // Mengambil gambar dari kamera
  Future<void> pickImageFromCamera() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImages.add(File(image.path));
    }
  }

  // Mengambil video dari galeri
  Future<void> pickVideoFromGallery() async {
    final picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      selectedVideos.add(File(video.path));
    }
  }

  // Mengambil video dari kamera
  Future<void> pickVideoFromCamera() async {
    final picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      selectedVideos.add(File(video.path));
    }
  }

  // Menyimpan image/video path ke GetStorage (Opsional)
  void saveMediaPathToStorage() async {
    final storage = GetStorage();
    // Menyimpan semua path gambar dan video ke GetStorage
    List<String> imagePaths = selectedImages.map((file) => file.path).toList();
    List<String> videoPaths = selectedVideos.map((file) => file.path).toList();
    storage.write('imagePaths', imagePaths);
    storage.write('videoPaths', videoPaths);
  }

// Menambahkan timestamp pada pesan
  void addTextMessage(String text) {
    if (text.isNotEmpty) {
      messages.add({
        'type': 'text',
        'content': text,
        'timestamp': DateTime.now() // Menambahkan timestamp
      });
    }
  }

  void addImageMessage(File image) {
    messages.add({
      'type': 'image',
      'content': image,
      'timestamp': DateTime.now(), // Menambahkan timestamp
    });
  }

  void addVideoMessage(File video) {
    messages.add({
      'type': 'video',
      'content': video,
      'timestamp': DateTime.now(), // Menambahkan timestamp
    });
  }

// Mengurutkan pesan berdasarkan timestamp sebelum ditampilkan
  void sortMessages() {
    messages.sort((a, b) {
      return a['timestamp'].compareTo(b['timestamp']);
    });
  }

// Kirim pesan (termasuk pengurutan pesan berdasarkan timestamp)
  void sendMessage() {
    String text = textController.text;
    if (text.isNotEmpty) {
      addTextMessage(text);
      textController.clear(); // Kosongkan input setelah mengirim pesan
    }

    // Kirim semua gambar yang dipilih
    for (var image in selectedImages) {
      addImageMessage(image);
    }

    // Kirim semua video yang dipilih
    for (var video in selectedVideos) {
      addVideoMessage(video);
    }

    selectedImages.clear(); // Kosongkan daftar gambar setelah mengirim
    selectedVideos.clear(); // Kosongkan daftar video setelah mengirim

    // Urutkan pesan berdasarkan waktu pengiriman
    sortMessages();
  }
}
