import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_flutter/main.dart';
import 'package:project_flutter/presentation/pages/homeprofile/profile/editProfile.dart';
import 'package:project_flutter/presentation/pages/payment/payment.dart';
import 'package:project_flutter/presentation/pages/settings/setting.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  const ProfilePage({super.key, required this.userId});
  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Map<String, dynamic>? userData;
  bool isLoading = true;

  File? _image;

  @override
  void initState() {
    super.initState();
    // Ambil data pengguna saat halaman diinisialisasi
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await db.collection('users').doc(widget.userId).get();
      if (snapshot.exists) {
        setState(() {
          userData = snapshot.data(); // Simpan data pengguna
          isLoading = false; // Set loading ke false
        });
      } else {
        // Handle jika pengguna tidak ditemukan
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // Tangani kesalahan
      if (kDebugMode) {
        print("Error fetching user data: $e");
      }
      setState(() {
        isLoading = false; // Set loading ke false meskipun terjadi error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              "Your Profile",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'WorkSans',
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            ClipOval(
              child: _image != null
                  ? Image.file(
                      _image!,
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      'assets/img/profile.svg',
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                    ),
            ),
            Text(
              '${userData?['first_name'] ?? 'Loading ...'} ${userData?['last_name'] ?? ''}',
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            Text(
              '${userData?['email'] ?? 'Loading...'}',
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'WorkSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navigasi ke halaman edit profil
                Get.to(EditProfilePage(
                    userId: widget.userId,
                    firstName: userData?['first_name'] ?? '',
                    lastName: userData?['last_name'] ?? '',
                    email: userData?['email'] ?? '',
                    phoneNumber:
                        userData?['telp'] ?? '' // Perbaiki email di sini
                    // Menambahkan lokasi
                    ));
              },
              child: Container(
                width: 295,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/img/icons profile.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Profile',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'WorkSans',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/img/Chevron right.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.to('');
              },
              child: Container(
                width: 295,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/img/Check circle.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Your Order',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'WorkSans',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 65,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/img/Chevron right.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                try {
                  Get.to(CheckoutPage());
                } catch (e) {
                  print('Error during navigation: $e');
                }
              },
              child: Container(
                width: 295,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/img/Credit card.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Payment Method',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'WorkSans',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/img/Chevron right.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SettingsPage(), // Pass userId if needed
                  ),
                );
              },
              child: Container(
                width: 295,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/img/Settings.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Setting',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'WorkSans',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/img/Chevron right.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
// Lainnya tetap sama
          ],
        ),
      ),
    );
  }
}
