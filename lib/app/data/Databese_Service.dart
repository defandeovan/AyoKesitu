import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference destinationsCollection =
      FirebaseFirestore.instance.collection('destinations');

  final CollectionReference favoritesCollection =
      FirebaseFirestore.instance.collection('favorites');

  // Fungsi untuk menambahkan data destinasi ke Firestore
  Future<void> addDestination({
    required String name,
    required String location,
    required double rating,
    required List<String> amenities,
    required double price,
    required String selfCheckIn,
    required String cleanAccommodation,
    required String img,

  }) async {
    try {
      await destinationsCollection.add({
        'name': name,
        'location': location,
        'rating': rating,
        'amenities': amenities,
        'price': price,
        'selfCheckIn': selfCheckIn,
        'cleanAccommodation': cleanAccommodation,
        'img': img,
      });
      print("Data destinasi berhasil ditambahkan!");
    } catch (e) {
      print("Error menambahkan data destinasi: $e");
      rethrow;
    }
  }

  // Fungsi untuk mengupdate data destinasi di Firestore
  Future<void> updateDestination({
    required String docId,
    required String name,
    required String location,
    required double rating,
    required List<String> amenities,
    required double price,
    required String selfCheckIn,
    required String cleanAccommodation,
    required String img, 
  }) async {
    try {
      Map<String, dynamic> updateData = {
        'name': name,
        'location': location,
        'rating': rating,
        'amenities': amenities,
        'price': price,
        'selfCheckIn': selfCheckIn,
        'cleanAccommodation': cleanAccommodation,
        'img': img,
      };

      await destinationsCollection.doc(docId).update(updateData);
      print("Data destinasi berhasil diupdate!");
    } catch (e) {
      print("Error mengupdate data destinasi: $e");
      rethrow;
    }
  }

  // Fungsi untuk menghapus data destinasi di Firestore
  Future<void> deleteDestination(String docId) async {
    try {
      await destinationsCollection.doc(docId).delete();
      print('Data berhasil dihapus');
    } catch (e) {
      print('Gagal menghapus data: $e');
      rethrow;
    }
  }

  // Fungsi untuk menambahkan destinasi ke favorit
  Future<void> addToFavorite({
    required String userId,
    required String destinationId,
    required String fav
  }) async {
    try {
      await favoritesCollection.add({
        'userId': userId,
        'destinationId': destinationId,
        'fav': fav,
      });
      print('Destinasi berhasil ditambahkan ke favorit');
    } catch (e) {
      print('Gagal menambahkan ke favorit: $e');
      rethrow;
    }
  }

  // Fungsi untuk menghapus destinasi dari favorit
  Future<void> removeFromFavorite({
    required String userId,
    required String destinationId,
  }) async {
    try {
      QuerySnapshot snapshot = await favoritesCollection
          .where('userId', isEqualTo: userId)
          .where('destinationId', isEqualTo: destinationId)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
      print('Destinasi berhasil dihapus dari favorit');
    } catch (e) {
      print('Gagal menghapus dari favorit: $e');
      rethrow;
    }
  }

  // Fungsi untuk mendapatkan daftar destinasi favorit berdasarkan userId
  Future<List<DocumentSnapshot>> getUserFavorites(String userId) async {
    try {
      QuerySnapshot snapshot = await favoritesCollection
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs;
    } catch (e) {
      print('Gagal mendapatkan data favorit: $e');
      rethrow;
    }
  }

  // Fungsi untuk memeriksa apakah destinasi sudah difavoritkan oleh user
  Future<bool> isFavorite({
    required String userId,
    required String destinationId,
  }) async {
    try {
      QuerySnapshot snapshot = await favoritesCollection
          .where('userId', isEqualTo: userId)
          .where('destinationId', isEqualTo: destinationId)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Gagal memeriksa status favorit: $e');
      rethrow;
    }
  }
}
