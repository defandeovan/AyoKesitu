import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';

class EditprofileController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final box = GetStorage(); 
  Rx<File?> selectedImage = Rx<File?>(null);

  void initializeData({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
  }) {
    firstNameController.text = firstName;
    lastNameController.text = lastName;
    emailController.text = email;
    phoneNumberController.text = phoneNumber;

    // Load image from GetStorage if exists
    String? imagePath = box.read('profile_image');
    if (imagePath != null) {
      selectedImage.value = File(imagePath);
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      selectedImage.value = File(image.path);

      // Save image path to GetStorage
      box.write('profile_image', image.path);
    }
  }

  void saveChanges() {
    String updatedFirstName = firstNameController.text;
    String updatedLastName = lastNameController.text;
    String updatedPhoneNumber = phoneNumberController.text;

    // Save to GetStorage (or any other storage solution)
    box.write('first_name', updatedFirstName);
    box.write('last_name', updatedLastName);
    box.write('phone_number', updatedPhoneNumber);

    // Navigate back
    Get.back();
  }
}
