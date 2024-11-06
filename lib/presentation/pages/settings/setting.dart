import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_flutter/authcontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_flutter/login.dart';

class SettingsPage extends StatelessWidget {
  void deleteUserAccount(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Menampilkan dialog untuk meminta kata sandi pengguna
      String password = ''; // Variabel untuk menyimpan kata sandi yang dimasukkan pengguna
      bool isPasswordCorrect = false;

      // Tampilkan dialog untuk meminta kata sandi
      await showDialog(
        context: context,
        builder: (context) {
          TextEditingController passwordController = TextEditingController();
          return AlertDialog(
            title: Text("Konfirmasi Kata Sandi"),
            content: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: "Masukkan Kata Sandi"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  password = passwordController.text;
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );

      // Jika kata sandi kosong atau tidak valid, batalkan penghapusan
      if (password.isEmpty) {
        Get.snackbar("Error", "Kata sandi tidak boleh kosong.");
        return;
      }

      try {
        // Re-authenticate dengan kredensial yang dimasukkan
        await user.reauthenticateWithCredential(
          EmailAuthProvider.credential(email: user.email!, password: password),
        );

        // Hapus data pengguna dari Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .delete();

        // Hapus akun pengguna dari Firebase Authentication
        await user.delete();

        // Navigasi keluar dan tampilkan pesan sukses
        Get.snackbar("Berhasil", "Akun berhasil dihapus.");
        Get.to(SignInScreen()); // arahkan ke halaman login
      } catch (e) {
        print("Error deleting account: $e");
        Get.snackbar(
            "Error", "Gagal menghapus akun. Pastikan kata sandi benar.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the content
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Delete Account",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 30), // Jarak antara teks dan tombol
                  Container(
                    width: 100,
                    height: 40,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onPressed: () {
                        deleteUserAccount(context);
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Container(
                width: 200,
                height: 43,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 15, 133, 29),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  onPressed: () {
                    AuthController authController = Get.find<AuthController>();
                    authController.logout();
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
