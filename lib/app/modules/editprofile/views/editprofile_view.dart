import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:io';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_flutter/app/routes/app_pages.dart';


class EditprofileView extends StatefulWidget {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final File? image;

  const EditprofileView({
    Key? key,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.image,
  }) : super(key: key);

  @override
  _EditprofileViewState createState() => _EditprofileViewState();
}

class _EditprofileViewState extends State<EditprofileView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.firstName;
    _lastNameController.text = widget.lastName;
    _emailController.text = widget.email;
    _phoneNumberController.text = widget.phoneNumber;
    _selectedImage = widget.image;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> updateProfile() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .update({
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
        'email': _emailController.text,
        'telp': _phoneNumberController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profil berhasil diperbarui!')),
      );
      Get.to(Routes.HOME);
    } catch (e) {
      print("Error updating profile: $e");
   
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            GestureDetector(
              onTap: _pickImage,
              child: ClipOval(
                child: _selectedImage != null
                    ? Image.file(
                        _selectedImage!,
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
            ),
            TextButton(
              onPressed: _pickImage,
              child: Text(
                "Change Your Photo Profile",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 150, 231),
                  fontFamily: 'WorkSans',
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: 20),
            buildTextField("First Name", _firstNameController),
            buildTextField("Last Name", _lastNameController),
            buildTextField("Email", _emailController),
            buildTextField("Phone Number", _phoneNumberController),
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
                onPressed: updateProfile,
                child: Text(
                  "Save Changes",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      )),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: controller,
        enabled: labelText != 'Email',
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ),
    );
  }
}
