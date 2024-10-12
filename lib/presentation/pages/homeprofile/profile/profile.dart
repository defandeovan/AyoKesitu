import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "JOKO PUTRA";
  String email = "jokoputra@gmail.com";
  String firstName = "JOKO";
  String lastName = "PUTRA";
  String location = "Indonesia";
  String phoneNumber = "08123456789";
  File? _image; // Variabel untuk menyimpan gambar profil

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text(
              "Your Profile",
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
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
              name,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              email,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'WorkSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                // Navigasi ke halaman Edit Profile dan menunggu hasil
                final updatedProfile = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      firstName: firstName,
                      lastName: lastName,
                      location: location,
                      phoneNumber: phoneNumber,
                      image: _image, // Kirim gambar profil saat ini
                    ),
                  ),
                );
                // Jika ada perubahan, set state baru
                if (updatedProfile != null) {
                  setState(() {
                    firstName = updatedProfile['firstName'];
                    lastName = updatedProfile['lastName'];
                    location = updatedProfile['location'];
                    phoneNumber = updatedProfile['phoneNumber'];
                    _image = updatedProfile['image']; // Update gambar profil
                    name = "$firstName $lastName";
                  });
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
             Container(
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
              SizedBox(
                height: 20,
              ),
              Container(
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
              SizedBox(
                height: 20,
              ),
              Container(
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
                    SizedBox(width: 20),
                    Text(
                      'Setting',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'WorkSans',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 95,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/img/Chevron right.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ]
                )
          
              )// Lainnya tetap sama
          ],
        ),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String location;
  final String phoneNumber;
  final File? image; // Tambahkan parameter untuk gambar

  EditProfilePage({
    required this.firstName,
    required this.lastName,
    required this.location,
    required this.phoneNumber,
    this.image, // Inisialisasi parameter
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController locationController;
  late TextEditingController phoneNumberController;
  File? _image; // Variabel untuk menyimpan gambar profil

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    locationController = TextEditingController(text: widget.location);
    phoneNumberController = TextEditingController(text: widget.phoneNumber);
    _image = widget.image; // Set gambar dari halaman sebelumnya
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    locationController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Set gambar yang dipilih
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
            SizedBox(height: 50),
            Text(
              "Edit Profile",
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.firstName,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  widget.lastName,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: _pickImage, // Panggil fungsi pemilih gambar
              child: Text(
                "Change Your Photo Profile",
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 150, 231),
                  fontFamily: 'WorkSans',
                  fontSize: 10,
                ),
              ),
            ),
            SizedBox(height: 20),
            buildTextField("First Name", firstNameController),
            buildTextField("Last Name", lastNameController),
            buildTextField("Location", locationController),
            buildTextField("Phone Number", phoneNumberController),
            SizedBox(height: 20),
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
                  // Kirim data yang diubah ke halaman ProfilePage
                  Navigator.pop(context, {
                    'firstName': firstNameController.text,
                    'lastName': lastNameController.text,
                    'location': locationController.text,
                    'phoneNumber': phoneNumberController.text,
                    'image': _image // Kirim gambar profil baru
                  });
                },
                child: Text(
                  "Save Changes",
                  style: TextStyle(
                      color: Color(0xffffffff),
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
