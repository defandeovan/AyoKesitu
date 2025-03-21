import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_flutter/app/modules/forgot_password/views/Email.dart';
import 'package:project_flutter/app/modules/forgot_password/views/forgot_password_view.dart';

import '../controllers/forgot_password_controller.dart';

class Ver extends GetView<ForgotPasswordController> {
  const Ver({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Halaman Utama')),
      body: Center(
        child:Column(
          children: [
            ElevatedButton(
          onPressed: () {
            // Navigasi ke halaman Verifikasi
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CheckEmailPage()),
            );
          },
          child: Text('Verifikasi Email'),
        ),
        ElevatedButton(
          onPressed: () {
            // Navigasi ke halaman Verifikasi
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPasswordView()),
            );
          },
          child: Text('Verifikasi Telepon'),
        ),
          ],
        ) 
        
      ),
    );
  }
}