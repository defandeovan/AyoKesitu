import 'package:flutter/material.dart';
import 'ApiService.dart'; // Pastikan file ini sesuai
import 'Location.dart'; // Pastikan model lokasi ada di sini

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Location API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LocationsPage(),
    );
  }
}

class LocationsPage extends StatefulWidget {
  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  late Future<List<Location>> futureLocations;

  @override
  void initState() {
    super.initState();
    futureLocations = ApiService.fetchLocations();  // Memanggil API untuk mengambil data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
      ),
      body: FutureBuilder<List<Location>>(
        future: futureLocations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No locations found'));
          } else {
            final locations = snapshot.data!;
            return ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                final location = locations[index];
                return ListTile(
                  title: Text(location.name),
                  subtitle: Text(location.description),
                  leading: Icon(Icons.location_on),
                  onTap: () {
                    // Anda bisa menambahkan aksi untuk menampilkan detail lokasi.
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
