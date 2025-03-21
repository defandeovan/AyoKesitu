import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_flutter/app/data/ProfileData.dart';
import 'package:project_flutter/app/data/cloudimgprofile.dart';

class ProfileController extends GetxController {
  var selectedImage = Rxn<File>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  String ? imageUrl;
  
  final CloudinaryServiceProfile _cloudinaryService =
      CloudinaryServiceProfile();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  void initializeData(String userId) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (doc.exists) {
      Profile profile = Profile.fromFirestore(doc);
      firstNameController.text = profile.firstName;
      lastNameController.text = profile.lastName;
      emailController.text = profile.email;
      phoneNumberController.text = profile.telp;
      imageUrl = profile.img ?? '';
      
    }
  }
}
