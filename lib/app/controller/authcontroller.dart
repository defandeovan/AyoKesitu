import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_flutter/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  Future<void> _clearText() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_id');
  }

  @override
  void onReady() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onReady();
  }

  Future<void> logout() async {
    await _auth.signOut();
    _clearText();
    Get.offAllNamed(Routes.CHECKDATA); // Arahkan ke halaman login setelah logout
  }
}
