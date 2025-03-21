import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: OtpScreen(),
  ));
}

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String generatedOtp = '1213123'; // OTP yang dikirim
  int? enteredOtp; // OTP yang dimasukkan pengguna

  @override
  void initState() {
    super.initState();
    sendOtp('085330571163', 'OTP is: '); // Kirim OTP saat aplikasi mulai
  }

  // Fungsi untuk mengirim OTP
  void sendOtp(String phoneNumber, String messageText) {
    setState(() {
      generatedOtp = (1000 + Random().nextInt(9000)).toString(); // Generate OTP 4 digit
    });
    print('OTP sent to $phoneNumber: $messageText $generatedOtp'); 
  }

  // Fungsi untuk mengecek OTP
  bool resultChecker() {
    return enteredOtp != null && enteredOtp.toString() == generatedOtp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OTP Verification")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Masukkan OTP yang dikirim ke nomor Anda"),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (val) {
                setState(() {
                  enteredOtp = int.tryParse(val);
                });
              },
              decoration: InputDecoration(labelText: "Masukkan OTP"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (resultChecker()) {
                  print('Success');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("OTP Benar! Login Berhasil")),
                  );
                } else {
                  print('Failure');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("OTP Salah! Silakan coba lagi")),
                  );
                }
              },
              child: Text("Verifikasi OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
