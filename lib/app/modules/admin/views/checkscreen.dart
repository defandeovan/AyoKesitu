import 'package:flutter/material.dart';
import 'package:project_flutter/app/data/cloudinactory_service.dart';

import 'package:image_picker/image_picker.dart';
import 'package:project_flutter/app/modules/admin/views/checkimageurl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckImageScreen(),
    );
  }
}

class CheckImageScreen extends StatefulWidget {
  @override
  _CheckImageScreenState createState() => _CheckImageScreenState();
}

class _CheckImageScreenState extends State<CheckImageScreen> {
  final CloudinaryService _cloudinaryService = CloudinaryService();
  String? imageUrl;
  bool isImageAvailable = false;

  Future<void> pickAndUploadImage() async {
    // Gunakan ImagePicker untuk memilih gambar dari galeri
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Upload gambar dan dapatkan URL
      String uploadedImageUrl =
          await _cloudinaryService.uploadImage(pickedFile.path);
      setState(() {
        imageUrl = uploadedImageUrl;
      });

      // Tambahkan print debug untuk URL yang dikembalikan
      print('URL yang diterima di main.dart: $uploadedImageUrl');

      // Cek apakah gambar tersedia di URL
      bool isAvailable = await checkImageUrl(uploadedImageUrl);
      setState(() {
        isImageAvailable = isAvailable;
      });
    } else {
      print('Tidak ada gambar yang dipilih.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cek URL Gambar')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageUrl != null
                ? Image.network(imageUrl!)
                : Text('Belum ada gambar'),
            SizedBox(height: 20),
            isImageAvailable
                ? Text(
                    'Gambar ditemukan!',
                    style: TextStyle(color: Colors.green),
                  )
                : Text(
                    'Gambar tidak ditemukan!',
                    style: TextStyle(color: Colors.red),
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickAndUploadImage,
              child: Text('Pilih dan Upload Gambar'),
            ),
          ],
        ),
      ),
    );
  }
}
