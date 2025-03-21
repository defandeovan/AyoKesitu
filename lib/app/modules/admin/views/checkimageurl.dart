import 'package:http/http.dart' as http;

Future<bool> checkImageUrl(String imageUrl) async {
  try {
    final response = await http.head(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return true; // Gambar ada di URL
    } else {
      return false; // Gambar tidak ditemukan
    }
  } catch (e) {
    print('Error: $e');
    return false; // Error saat mengecek URL
  }
}
