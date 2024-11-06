import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart'; // Pastikan untuk mengimpor halaman login yang sesuai

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Inisialisasi Firebase Auth

  // Metode logout
  void logout() async {
    try {
      await _auth.signOut(); // Melakukan logout dari Firebase
      // ignore: prefer_const_constructors
      Get.offAll(() => SignInScreen()); // Menghapus semua halaman dan kembali ke halaman Login
    } catch (e) {
      // Menangani kesalahan jika logout gagal
      Get.snackbar('Logout Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
