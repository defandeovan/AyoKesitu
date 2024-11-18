import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatController extends GetxController {
  var selectedImages = <File>[].obs; // Daftar gambar yang dipilih
  var selectedVideos = <File>[].obs; // Daftar video yang dipilih
  var messages =
      <Map<String, dynamic>>[].obs; // Menyimpan pesan teks, gambar, dan video

  var textController = TextEditingController();
  FlutterSoundRecorder? _audioRecorder;
  bool isRecording = false;
  File? recordedAudio;
  @override
  void onInit() {
    super.onInit();
    _audioRecorder = FlutterSoundRecorder();
    _initRecorder();
  }
Future<void> _initRecorder() async {
  // Requesting microphone and storage permissions
  var statusMicrophone = await Permission.microphone.request();
  var statusStorage = await Permission.storage.request();

  if (statusMicrophone != PermissionStatus.granted ||
      statusStorage != PermissionStatus.granted) {
    // Show a message to guide the user to enable permissions
    Get.snackbar(
      'Permission Denied', 
      'Please allow microphone and storage permissions. Go to Settings > Apps > Your App > Permissions to enable.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return;
  }

  try {
    // Open the recorder after permissions are granted
    await _audioRecorder?.openRecorder();
    // Ensure the recorder is properly initialized
    _audioRecorder?.setSubscriptionDuration(const Duration(milliseconds: 100));
  } catch (e) {
    print("Error while opening the recorder: $e");
    Get.snackbar('Recorder Initialization Failed', 'Failed to open the recorder.', snackPosition: SnackPosition.BOTTOM);
  }

  try {
    await _audioRecorder?.openRecorder();
    // Ensure the recorder is properly initialized
    _audioRecorder?.setSubscriptionDuration(const Duration(milliseconds: 100));
  } catch (e) {
    print("Error while opening the recorder: $e");
    Get.snackbar('Recorder Initialization Failed', 'Failed to open the recorder.');
  }
}

Future<void> requestPermissions() async {
  // Request microphone and storage permissions
  var microphoneStatus = await Permission.microphone.request();
  var storageStatus = await Permission.storage.request();

  if (microphoneStatus.isGranted && storageStatus.isGranted) {
    // Continue with your functionality
  } else {
    // Show error message or prompt user to allow permissions
    Get.snackbar(
      'Permission Denied',
      'Please allow microphone and storage permissions.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }


  
}

Future<void> startRecording() async {
  if (_audioRecorder == null) {
    print("Recorder not initialized.");
    return;
  }

  if (!_audioRecorder!.isRecording) {
    isRecording = true;
    update();
    String path = '/storage/emulated/0/Download/flutter_sound.aac';
    
    try {
      await _audioRecorder?.startRecorder(toFile: path);
    } catch (e) {
      print("Error starting the recorder: $e");
    }
  }
}




Future<void> stopRecording() async {
  if (_audioRecorder != null && _audioRecorder!.isRecording) {
    try {
      // Hentikan perekaman dan dapatkan path file
      final path = await _audioRecorder?.stopRecorder();
      
      // Cek apakah path tidak null dan file benar-benar ada
      if (path != null && path.isNotEmpty) {
        final audioFile = File(path);

        if (audioFile.existsSync()) {
          recordedAudio = audioFile;
          addVoiceNoteMessage(recordedAudio!);
          print("Audio file saved successfully at path: $path");

          // Memutar audio menggunakan audioplayers
          AudioPlayer audioPlayer = AudioPlayer();
          await audioPlayer.play(DeviceFileSource(audioFile.path));
          print("Audio is playing");
        } else {
          print("Failed to save audio file. File not found at path: $path");
        }
      } else {
        print("Recorder stopped but no file path was returned.");
      }
    } catch (e) {
      print("Error while stopping the recorder: $e");
    } finally {
      // Pastikan isRecording selalu di-set false
      isRecording = false;
      update();
    }
  }
}




  // Menambahkan pesan voice note
  void addVoiceNoteMessage(File audio) {
    messages.add({
      'type': 'audio',
      'content': audio,
      'timestamp': DateTime.now(),
    });
  }

  @override
  void onClose() {
    _audioRecorder?.closeRecorder();
    super.onClose();
  }

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
