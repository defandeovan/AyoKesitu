import 'package:http/http.dart' as http;
import 'package:project_flutter/app/controller/Location.dart';

class ApiService {
  static Future<List<Location>> fetchLocations() async {
    final response = await http.get(Uri.parse('http://localhost:3000/locations'));

    if (response.statusCode == 200) {
      // Jika server mengembalikan respons OK 200, maka parse JSON
      return Location.fromJsonList(response.body);
    } else {
      throw Exception('Gagal memuat lokasi');
    }
  }
}
