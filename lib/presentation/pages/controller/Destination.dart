import 'package:cloud_firestore/cloud_firestore.dart';

class Destination {
  final String name;
  final String location;
  final double rating;
  final List<String> amenities;
  final double price;
  final String selfCheckIn;
  final String cleanAccommodation;

  Destination({
    required this.name,
    required this.location,
    required this.rating,
    required this.amenities,
    required this.price,
    required this.selfCheckIn,
    required this.cleanAccommodation,
  });

  // Factory method untuk mengonversi dokumen Firestore menjadi objek Destination
  factory Destination.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Destination(
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      rating: data['rating'] ?? 0.0,
      amenities: List<String>.from(data['amenities'] ?? []),
      price: data['price'] ?? 0.0,
      selfCheckIn: data['selfCheckIn'] ?? '',
      cleanAccommodation: data['cleanAccommodation'] ?? '',
    );
  }
}
