import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_flutter/app/modules/login/views/google-signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_flutter/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:project_flutter/app/routes/app_pages.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userId = '';
  List<String> adminEmails = ['admin@gmail.com'];

  Future<void> _saveUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_id', userId);
    print("UserID berhasil disimpan!");
  }

  void _handleGoogleSignIn(BuildContext context) async {
  final user = await GoogleSignInApi.signInWithGoogle();
  if (user != null) {
    userId = user.uid;
    _saveUserId();

    // Referensi ke Firestore
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    // Cek apakah user sudah ada di Firestore
    final docSnapshot = await userRef.get();

    if (!docSnapshot.exists) {
      // Jika user belum ada, tambahkan ke Firestore
      await userRef.set({
        'uid': userId,
        'name': user.displayName ?? 'Unknown',
        'email': user.email ?? '',
        'photoUrl': user.photoURL ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("User baru ditambahkan ke Firestore.");
    } else {
      print("User sudah ada di Firestore.");
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login Berhasil: ${user.displayName}")),
    );

    Get.offAllNamed('/home', arguments: {'userId': userId});
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login Gagal atau Dibatalkan")),
    );
  }
}


  Future<void> _signInWithEmailPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      String userEmail = userCredential.user!.email!;
      userId = userCredential.user!.uid;
      _saveUserId();

      if (adminEmails.contains(userEmail)) {
        Get.offAllNamed('/admin', arguments: {'userId': userId});
      } else {
        Get.offAllNamed('/home', arguments: {'userId': userId});
      }

      print("UserID dari arguments: $userId");
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Akun tidak ditemukan. Silakan daftar terlebih dahulu.';
          break;
        case 'wrong-password':
          errorMessage = 'Kata sandi yang Anda masukkan salah.';
          break;
        case 'invalid-email':
          errorMessage = 'Format email tidak valid.';
          break;
        default:
          errorMessage = 'Terjadi kesalahan. Coba lagi nanti.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/img/image 17.png', fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/img/logo.png', width: 150, height: 150),
                  SizedBox(height: 5),
                  Text('Travel with ease, Discover with Dave',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  SizedBox(height: 10),
                  Text('Sign in now',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 32),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      hintText: 'Email',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      hintText: 'Password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Get.to(ForgotPasswordView()),
                      child: Text('Forgot Password?', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _signInWithEmailPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Text('Sign In'),
                  ),
                  SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => _handleGoogleSignIn(context),
                    icon: Icon(Icons.login, color: Colors.white),
                    label: Text('Sign In With Google Account', style: TextStyle(color: Colors.white)),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      side: BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.REGISTER),
                    child: Text("Don't have an account? Sign Up", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
