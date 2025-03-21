import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  // Fungsi untuk memilih gambar dari kamera atau galeri
  static Future<File?> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}
