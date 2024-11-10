import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_flutter/app/routes/app_pages.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Inisialisasi Firebase Auth

  // Metode logout
  void logout() async {
    try {
      await _auth.signOut(); // Melakukan logout dari Firebase
      // ignore: prefer_const_constructors
      Get.offAll(() => Routes.LOGIN); // Menghapus semua halaman dan kembali ke halaman Login
    } catch (e) {
      // Menangani kesalahan jika logout gagal
      Get.snackbar('Logout Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
