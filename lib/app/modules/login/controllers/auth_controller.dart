import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_flutter/app/routes/app_pages.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onReady() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onReady();
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed(Routes.LOGIN); // Arahkan ke halaman login setelah logout
  }
}
