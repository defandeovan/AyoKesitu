import 'package:flutter/material.dart';

class SendOTPPage extends StatelessWidget {
  final String email;

  SendOTPPage({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verifikasi OTP')),
      body: Center(
        child: Text(
          'Kode OTP telah dikirim ke: $email',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
