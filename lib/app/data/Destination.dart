import 'package:cloud_firestore/cloud_firestore.dart';

class Destination {
  final String id; // Tambahkan ini
  final String name;
  final String location;
  final double rating;
  final List<String> amenities;
  final double price;
  final String selfCheckIn;
  final String cleanAccommodation;
  final String img;
  bool isPopular;

  Destination({
    required this.id, // Tambahkan ini
    required this.name,
    required this.location,
    required this.rating,
    required this.amenities,
    required this.price,
    required this.selfCheckIn,
    required this.cleanAccommodation,
    this.isPopular = false,
    required this.img,
  });

  // Factory method untuk mengonversi dokumen Firestore menjadi objek Destination
  factory Destination.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Destination(
      id: doc.id, // Ambil ID dokumen dari Firestore
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      amenities: List<String>.from(data['amenities'] ?? []),
      price: (data['price'] ?? 0.0).toDouble(),
      selfCheckIn: data['selfCheckIn'] ?? '',
      cleanAccommodation: data['cleanAccommodation'] ?? '',
      img: data['img'] ?? ''
    );
  }
}
