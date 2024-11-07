import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_flutter/authcontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_flutter/login.dart';

class Yourorder extends StatelessWidget {
  void yourOrder(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0), // Add padding around the content
        child: Center(),
      ),
    );
  }
}
