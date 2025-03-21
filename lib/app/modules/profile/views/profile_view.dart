import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_flutter/app/modules/editprofile/views/editprofile_view.dart';
import 'package:project_flutter/app/modules/yourOrder/views/your_order_view.dart';
import 'package:project_flutter/app/routes/app_pages.dart';

class ProfileView extends StatefulWidget {
  final String userId;

  const ProfileView({
    super.key,
    required this.userId,
  });

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Map<String, dynamic>? userData;
  final GetStorage storage = GetStorage();
  bool isLoading = true;
  String? imageUrl;
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserData();
      loadProfileImage();
    });
  }

  Future<void> getUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await db.collection('users').doc(widget.userId).get();
      if (snapshot.exists) {
        setState(() {
          userData = snapshot.data();
          imageUrl = userData?['img'];
          print("imgurl: ${userData?['img']}");
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching user data: $e");
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  void loadProfileImage() {
    String? imagePath = storage.read<String>('profile_image');
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  Future<void> refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      getUserData();
      loadProfileImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  child: Container(
                    width: 130,
                    height: 130,
                    color: Colors.grey[300],
                    child: userData?['img'] != null
                        ? Image.network(
                            userData!['img'],
                            fit: BoxFit.cover,
                          )
                        : SvgPicture.asset(
                            'assets/img/profile.svg',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${userData?['first_name'] ?? '...'} ${userData?['last_name'] ?? ''}',
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
                _buildProfileOption(
                  iconPath: 'assets/img/icons profile.svg',
                  title: 'Profile',
                  onTap: () {
                    Get.to(EditprofileView(userId: widget.userId));
                  },
                ),
                const SizedBox(height: 20),
                _buildProfileOption(
                  iconPath: 'assets/img/Check circle.svg',
                  title: 'Your Order',
                  onTap: () {
                    // Get.to(YourOrderPage());
                  },
                ),
                const SizedBox(height: 20),
                _buildProfileOption(
                  iconPath: 'assets/img/Credit card.svg',
                  title: 'Payment Method',
                  onTap: () {
                    // Get.toNamed(Routes.PAY_METHOD);
                  },
                ),
                const SizedBox(height: 20),
                _buildProfileOption(
                  iconPath: 'assets/img/Settings.svg',
                  title: 'Setting',
                  onTap: () {
                    Get.toNamed(Routes.SETTING);
                  },
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required String iconPath,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 295,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(iconPath, width: 40, height: 40),
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'WorkSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset('assets/img/Chevron right.svg',
                  width: 40, height: 40),
            ),
          ],
        ),
      ),
    );
  }
}
