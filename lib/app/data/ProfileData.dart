import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String telp;
  String? img;

  Profile({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.telp,
    required this.img,
  });

  // Factory method untuk konversi dari Firestore
  factory Profile.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Profile(
      id: doc.id,
      firstName: data['first_name'] ?? '',
      lastName: data['last_name'] ?? '',
      telp: data['telp'] ?? '',
      email: data['email'] ?? '',
         img: data['img'] ?? ''
    );
  }

  // Konversi ke Map untuk penyimpanan di Firestore
  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'telp': telp,
      'email': email,
      'img': img,
    };
  }

  // Method untuk update data di Firestore
  Future<void> updateProfile() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(toMap());
  }
}
