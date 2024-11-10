import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_flutter/app/data/Destination.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable variables
  var destinations = <Destination>[].obs;
  var searchText = ''.obs;
  var isLoading = true.obs;
  var userId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Cek apakah userId sudah diteruskan melalui arguments
    var arguments = Get.arguments;
    if (arguments != null && arguments['userId'] != null) {
      userId.value = arguments['userId']; // Ambil userId dari arguments
    } else {
      fetchUserId(); // Jika tidak ada, ambil userId dari Firestore
    }
    fetchDestinations();
  }

  // Fungsi untuk mengambil userId dari Firestore
  void fetchUserId() async {
    try {
      // Misalnya, kita ambil dari koleksi "users" dan dokumen tertentu
      var userDoc = await _firestore.collection('users').doc('userDocumentId').get();
      if (userDoc.exists) {
        userId.value = userDoc.data()?['userId'] ?? '';
      }
    } catch (e) {
      print("Error fetching userId: $e");
    }
  }

  // Fetch data dari Firestore
  void fetchDestinations() {
    isLoading.value = true;  // Menandakan data sedang dimuat
    _firestore.collection('destinations').snapshots().listen((snapshot) {
      destinations.value = snapshot.docs
          .map((doc) => Destination.fromFirestore(doc))
          .toList();
      isLoading.value = false;  // Data selesai dimuat
    });
  }

  void updateSearchText(String text) {
    searchText.value = text;
  }
}
