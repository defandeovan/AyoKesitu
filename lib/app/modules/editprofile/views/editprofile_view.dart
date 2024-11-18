import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_flutter/app/modules/editprofile/controllers/editprofile_controller.dart';
import 'dart:io';


class EditprofileView extends StatelessWidget {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  EditprofileView({
    Key? key,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  }) : super(key: key);

  final EditprofileController controller = Get.put(EditprofileController());

  @override
  Widget build(BuildContext context) {
    controller.initializeData(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () => _showImageSourcePicker(context),
                child: Obx(
                  () => ClipOval(
                    child: controller.selectedImage.value != null
                        ? Image.file(
                            controller.selectedImage.value!,
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
              ),
              TextButton(
                onPressed: () => _showImageSourcePicker(context),
                child: const Text(
                  "Change Your Photo Profile",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 150, 231),
                    fontFamily: 'WorkSans',
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField("First Name", controller.firstNameController),
              _buildTextField("Last Name", controller.lastNameController),
              _buildTextField("Email", controller.emailController),
              _buildTextField("Phone Number", controller.phoneNumberController),
              const SizedBox(height: 20),
              Container(
                width: 200,
                height: 43,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 15, 133, 29),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  onPressed: controller.saveChanges,
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSourcePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  controller.pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  controller.pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: TextField(
        controller: controller,
        enabled: labelText != 'Email',
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
