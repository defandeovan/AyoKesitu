import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'dart:math';
import 'SendOTPPage.dart'; // Import halaman baru

class CheckEmailPage extends StatefulWidget {
  @override
  _CheckEmailPageState createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CheckEmailPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  String _message = "";

  // Fungsi untuk generate OTP 6 digit
  String generateOTP() {
    var rng = Random();
    return (100000 + rng.nextInt(900000)).toString();
  }

  // Fungsi untuk mengirim OTP melalui email
  Future<void> sendEmailOTP(String email, String otp) async {
    String username = "your_email@gmail.com";  // Ganti dengan email pengirim
    String password = "your_app_password";     // Gunakan app password dari Google

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, "Admin")
      ..recipients.add(email)
      ..subject = "Kode OTP Anda"
      ..text = "Kode OTP Anda adalah: $otp. Jangan bagikan dengan siapapun.";

    try {
      await send(message, smtpServer);
      setState(() {
        _message = "OTP telah dikirim ke email.";

        // ✅ Setelah OTP dikirim, navigasi ke halaman OTP
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SendOTPPage(email : email)),
        );
      });
    } catch (e) {
      setState(() {
        _message = "Gagal mengirim email: ${e.toString()}";
      });
    }
  }

  // Fungsi untuk cek apakah email terdaftar di Firebase
  Future<void> checkEmailAndSendOTP() async {
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        _message = "Masukkan email terlebih dahulu.";
      });
      return;
    }

    try {
      // Cek apakah email terdaftar di Firebase
      List<String> signInMethods = await _auth.fetchSignInMethodsForEmail(email);
      if (signInMethods.isNotEmpty) {
        // Jika email ditemukan, buat OTP dan kirim
        String otp = generateOTP();
        await sendEmailOTP(email, otp);
      } else {
        setState(() {
          _message = "Email tidak ditemukan. Silakan daftar terlebih dahulu.";
        });
      }
    } catch (e) {
      setState(() {
        _message = "Terjadi kesalahan: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cek dan Kirim OTP Email')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Masukkan Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkEmailAndSendOTP,
              child: Text('Cek Email & Kirim OTP'),
            ),
            SizedBox(height: 20),
            Text(
              _message,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
