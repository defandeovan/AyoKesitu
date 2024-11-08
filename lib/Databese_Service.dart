import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference destinationsCollection =
      FirebaseFirestore.instance.collection('destinations');

  // Fungsi untuk menambahkan data destinasi ke Firestore
  Future<void> addDestination({
    required String name,
    required String location,
    required double rating,
    required List<String> amenities,
    required double price,
    required String selfCheckIn, // New field
    required String cleanAccommodation, // New field
  }) async {
    try {
      await destinationsCollection.add({
        'name': name,
        'location': location,
        'rating': rating,
        'amenities': amenities,
        'price': price,
        'selfCheckIn': selfCheckIn, // New field
        'cleanAccommodation': cleanAccommodation, // New field
      });
      print("Data destinasi berhasil ditambahkan!");
    } catch (e) {
      print("Error menambahkan data destinasi: $e");
    }
  }
}
