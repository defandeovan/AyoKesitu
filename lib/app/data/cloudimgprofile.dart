import 'dart:convert';
import 'package:http/http.dart' as http;

class CloudinaryServiceProfile {
  final String cloudName = 'db5vhptv9'; // Ganti dengan Cloud Name kamu
  final String uploadPreset = 'profil_img'; // Ganti dengan Upload Preset kamu

  Future<String> uploadImage(String imagePath) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imagePath));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await http.Response.fromStream(response);
      final data = jsonDecode(responseBody.body);

      // Mendapatkan URL gambar yang di-upload
      String imageUrl = data['secure_url'];
      
      // Tambahkan print debug di sini
      print('URL Gambar yang di-upload: $imageUrl');

      return imageUrl;
    } else {
      throw Exception('Gagal mengupload gambar');
    }
  }
}
