import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:project_flutter/app/data/ProfileData.dart';
import 'package:project_flutter/app/data/cloudimgprofile.dart';
import 'package:project_flutter/app/modules/home/views/home_view.dart';
import 'package:project_flutter/app/modules/profile/views/profile_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditprofileController extends GetxController {
  var selectedImage = Rxn<File>();
  var imageUrl = ''.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final CloudinaryServiceProfile _cloudinaryService =
      CloudinaryServiceProfile();

  var isLoading = false.obs; // Menggunakan RxBool

  // Inisialisasi data profil dari Firestore
  void initializeData(String userId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (doc.exists) {
        Profile profile = Profile.fromFirestore(doc);
        firstNameController.text = profile.firstName;
        lastNameController.text = profile.lastName;
        emailController.text = profile.email;
        phoneNumberController.text = profile.telp;
        imageUrl.value = profile.img ?? '';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile data');
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      isLoading.value = true;
      try {
        String uploadedImageUrl =
            await _cloudinaryService.uploadImage(pickedFile.path);
        imageUrl.value = uploadedImageUrl;
        await _saveStatus('success');
      } catch (e) {
        Get.snackbar('Upload Failed', 'Failed to upload image');
        await _saveStatus('failed');
      } finally {
        isLoading.value = false;
      }
    } else {
      await _saveStatus('cancel');
      Get.snackbar('No image selected', 'Please select an image.');
    }
  }

  Future<void> saveChanges(String userId) async {
    if (isLoading.value) return;
    String imgdef =
        'https://res.cloudinary.com/db5vhptv9/image/upload/v1742273212/profile_tuvqab.svg';
    isLoading.value = true;
    if (imageUrl.value.isEmpty) {
      try {
        Profile updatedProfile = Profile(
          id: userId,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          telp: phoneNumberController.text,
          img: imgdef,
        );

        await updatedProfile.updateProfile();
        Get.snackbar('Success', 'Profile updated successfully');
      } catch (e) {
        Get.snackbar('Error', 'Failed to update profile');
      } finally {
        isLoading.value = false;
        Get.to(() => HomeView(userId: userId), arguments: {'selectedIndex': 3});
      }
    }else{
       try {
        Profile updatedProfile = Profile(
          id: userId,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          telp: phoneNumberController.text,
          img: imageUrl.value,
        );

        await updatedProfile.updateProfile();
        Get.snackbar('Success', 'Profile updated successfully');
      } catch (e) {
        Get.snackbar('Error', 'Failed to update profile');
      } finally {
        isLoading.value = false;
        Get.to(() => HomeView(userId: userId), arguments: {'selectedIndex': 3});
      }
    }
   

  }

  Future<void> _saveStatus(String status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('stsupld', status);
    print("✅ Status upload berhasil disimpan: $status");
  }
}
