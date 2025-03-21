import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Konfigurasi ActionCodeSettings
final ActionCodeSettings actionCodeSettings = ActionCodeSettings(
  url: "https://ayokesituu.web.app/finishSignUp", // Sesuai dengan domain yang diizinkan
  handleCodeInApp: true,
  iOSBundleId: "com.example.ios",
  androidPackageName: "com.example.android",
  androidInstallApp: true,
  androidMinimumVersion: "12",
);


  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("Link reset password telah dikirim ke: $email");
    } catch (e) {
      print("Error mengirim link reset password: $e");
    }
  }
  // Mengirim link sign-in ke email
  Future<void> sendSignInLinkToEmail(String email) async {
    try {
      await _auth.sendSignInLinkToEmail(email: email, actionCodeSettings: actionCodeSettings);
      print("Email verifikasi terkirim ke: $email");
    } catch (e) {
      print("Error mengirim email: $e");
    }
  }
}
