import 'dart:convert'; // Untuk jsonDecode
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ApiPage(), // Mengarahkan ke halaman utama HomePage
    );
  }
}

class ApiPage extends StatefulWidget {
  const ApiPage({Key? key}) : super(key: key);

  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  bool isLoading = true; // Untuk menampilkan loading indicator
  List<dynamic> data = []; // Menyimpan data dari API

  // Fungsi untuk mengambil data dari API
  Future<void> fetchData() async {
    const url = 'https://jsonplaceholder.typicode.com/posts'; // URL API

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Jika status code 200, ambil data dan parse ke dalam list
        setState(() {
          data = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Ambil data saat halaman dimuat pertama kali
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data dari API')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(data[index]['title']),
                    subtitle: Text(data[index]['body']),
                  ),
                );
              },
            ),
    );
  }
}
