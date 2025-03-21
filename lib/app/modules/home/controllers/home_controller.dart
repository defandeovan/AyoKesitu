import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_flutter/app/data/Databese_Service.dart';
import 'package:project_flutter/app/data/Destination.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseService _databaseService = DatabaseService();

  // Observable variables
  var favorites = <Destination>[].obs;
  var destinations = <Destination>[].obs;
  var searchText = ''.obs;
  var isLoading = true.obs;
  var userId = ''.obs;
  var recommendedDestinations = <Destination>[].obs;

  @override
  void onInit() {
    super.onInit();
    print("onInit dipanggil");

    var arguments = Get.arguments;
    if (arguments != null && arguments['userId'] != null) {
      userId.value = arguments['userId'];
      print("UserID dari arguments: ${userId.value}");
      fetchFavorites();  // Ambil daftar favorit saat aplikasi dibuka
    } else {
      print("UserID tidak ditemukan di arguments, mengambil dari Firestore...");
      fetchUserId();
    }

    fetchDestinations();
  }

  void fetchUserId() async {
    try {
      print("Mengambil userId dari Firestore...");
      var userDoc =
          await _firestore.collection('users').doc('userDocumentId').get();

      if (userDoc.exists) {
        userId.value = userDoc.data()?['userId'] ?? '';
        print("UserID ditemukan di Firestore: ${userId.value}");
        fetchFavorites();
      } else {
        print("Dokumen user tidak ditemukan di Firestore!");
      }
    } catch (e) {
      print("Error fetching userId: $e");
    }
  }

  void fetchDestinations() async {
    try {
      isLoading.value = true;
      print("Mengambil data destinasi...");

      QuerySnapshot snapshot = await _firestore
          .collection('destinations')
          .orderBy('rating', descending: true)
          .get();

      destinations.value =
          snapshot.docs.map((doc) => Destination.fromFirestore(doc)).toList();

      recommendedDestinations
          .assignAll(destinations.where((d) => d.rating > 4.5));

      isLoading.value = false;
      print("Data destinasi berhasil dimuat.");
    } catch (e) {
      print("Error fetching destinations: $e");
      isLoading.value = false;
    }
  }

  void updateSearchText(String text) {
    searchText.value = text;
  }

  bool isFavorite(String destinationId) {
    return favorites.any((d) => d.id == destinationId);
  }

  void toggleFavorite(Destination destination) async {
    try {
      if (isFavorite(destination.id)) {
        // Jika sudah favorit, hapus dari Firestore
        await _firestore
            .collection('favorites')
            .where('userId', isEqualTo: userId.value)
            .where('destinationId', isEqualTo: destination.id)
            .get()
            .then((snapshot) {
          for (var doc in snapshot.docs) {
            doc.reference.delete();
          }
        });

        favorites.removeWhere((d) => d.id == destination.id);
        print("❌ Destinasi dihapus dari favorit");
      } else {
        // Jika belum favorit, tambahkan ke Firestore
        await _firestore.collection('favorites').add({
          'userId': userId.value,
          'destinationId': destination.id,
          'fav': 'true',
        });

        favorites.add(destination);
        print("✅ Destinasi ditambahkan ke favorit");
      }
    } catch (e) {
      print("❌ Error mengubah status favorit: $e");
    }
  }

  void fetchFavorites() async {
    try {
      if (userId.value.isEmpty) {
        print("❌ UserID masih kosong, tidak bisa mengambil favorit!");
        return;
      }

      print("🔍 Mengambil data favorit untuk userId: ${userId.value}");
      QuerySnapshot snapshot = await _firestore
          .collection('favorites')
          .where('userId', isEqualTo: userId.value)
          .where('fav', isEqualTo: 'true')
          .get();

      print("📄 Jumlah data favorit ditemukan: ${snapshot.docs.length}");

      List<String> favoriteDestinationIds = snapshot.docs
          .map((doc) => doc.get('destinationId') as String)
          .toList();

      List<DocumentSnapshot> destinationDocs = await Future.wait(
        favoriteDestinationIds.map(
          (id) => _firestore.collection('destinations').doc(id).get(),
        ),
      );

      favorites.value = destinationDocs
          .where((doc) => doc.exists)
          .map((doc) => Destination.fromFirestore(doc))
          .toList();

      print("✅ Destinasi favorit berhasil dimuat: ${favorites.length} item");
    } catch (e) {
      print("❌ Error mengambil data favorit: $e");
    }
  }
}
