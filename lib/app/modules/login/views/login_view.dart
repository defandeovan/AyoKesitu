import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:project_flutter/app/routes/app_pages.dart';


class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // Fungsi untuk login
  Future<void> _signInWithEmailPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      print("Signed in: ${userCredential.user?.email}");

      // Menampilkan pesan keberhasilan login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Login berhasil! Selamat datang, ${userCredential.user?.email}'),
          // backgroundColor: Colors.green,
        ),
      );
      //id user
      String userID = userCredential.user!.uid;
      print("User ID: $userID");

      Get.toNamed('/home', arguments: {'userId': userID});
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      // Menangani berbagai jenis kesalahan yang mungkin terjadi
      if (e.code == 'user-not-found') {
        errorMessage = 'Akun tidak ditemukan. Silakan daftar terlebih dahulu.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Kata sandi yang Anda masukkan salah.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Format email tidak valid.';
      } else {
        errorMessage = 'Terjadi kesalahan. Coba lagi nanti.';
      }

      // Menampilkan pesan kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      // Menangani kesalahan lainnya
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/img/image 17.png', // Gantilah dengan lokasi gambar latar belakang
            fit: BoxFit.cover,
          ),
          Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/img/logo.png',
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Travel with ease, Discover with Dave',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Sign in now',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 32),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Tambahkan fungsi untuk lupa kata sandi jika perlu
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed:
                          _signInWithEmailPassword, // Panggil fungsi login
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Warna tombol
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text('Sign In'),
                    ),
                    SizedBox(height: 16),
                    
                    OutlinedButton.icon(
                      onPressed: () {
                      
                      },
                      icon: Icon(Icons.login, color: Colors.white),
                      label: Text(
                        'Sign In With Google Account',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        side: BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigasi ke halaman registrasi
                        Get.toNamed(Routes.REGISTER);
                      },
                      child: Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
