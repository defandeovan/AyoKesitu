import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:project_flutter/app/modules/editprofile/controllers/editprofile_controller.dart';

class EditprofileView extends StatelessWidget {
  final String userId;
  final EditprofileController controller = Get.put(EditprofileController());

  EditprofileView({required this.userId});

  @override
  Widget build(BuildContext context) {
    controller.initializeData(userId);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () => _showImageSourcePicker(context),
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return Positioned.fill(
                          child: WillPopScope(
                            onWillPop: () async =>
                                false, // Mencegah back saat loading
                            child: Container(
                              color: Colors.black
                                  .withOpacity(0.7), // Latar lebih gelap
                              child: const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
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
                  _buildTextField(
                      "Phone Number", controller.phoneNumberController),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    height: 43,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 15, 133, 29),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onPressed: () async {
                        
                        await controller.saveChanges(userId);
                      },
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

          // FULLSCREEN LOADING
          Obx(() {
            if (controller.isLoading.value) {
              return Positioned.fill(
                child: WillPopScope(
                  onWillPop: () async => false, // Mencegah back saat loading
                  child: Container(
                    color: Colors.black.withOpacity(0.7), // Latar lebih gelap
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
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
