import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Fungsi untuk registrasi
  Future<void> _registerWithEmailPassword() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Semua field harus diisi.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kata sandi tidak cocok.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      print("Registered: ${userCredential.user?.email}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registrasi berhasil! Selamat datang, ${userCredential.user?.email}'),
          backgroundColor: Colors.green,
        ),
      );

      // Kembali ke halaman login setelah registrasi berhasil
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'Kata sandi terlalu lemah.';
          break;
        case 'email-already-in-use':
          errorMessage = 'Email sudah terdaftar. Silakan masuk.';
          break;
        case 'invalid-email':
          errorMessage = 'Format email tidak valid.';
          break;
        default:
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
      appBar: AppBar(
        title: Text('Registrasi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Kata Sandi',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Konfirmasi Kata Sandi',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _registerWithEmailPassword, // Panggil fungsi registrasi
              child: Text('Daftar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Kembali ke halaman login
              },
              child: Text("Sudah memiliki akun? Masuk"),
            ),
          ],
        ),
      ),
    );
  }
}
