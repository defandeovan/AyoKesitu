import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_flutter/presentation/pages/onboarding/onboarding.dart';
import 'package:project_flutter/presentation/pages/homeprofile/profile/addDest.dart';

// import 'package:project_flutter/homebody.dart';

import 'package:project_flutter/presentation/pages/login/login.dart';

import 'package:firebase_core/firebase_core.dart';


import 'package:project_flutter/presentation/pages/pemesanan/pemesanan_page.dart';

import 'presentation/pages/controller/firebase_options.dart';
import 'presentation/pages/controller/authcontroller.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'ayo_kesitu',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());
  // final messagingHandler = FirebaseMessagingHandler();
  // await messagingHandler
  //     .initLocalNotification(); // Inisialisasi lokal terlebih dahulu
  // await messagingHandler
  //     .initPushNotification(); // Kemudian inisialisasi push notification

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: BromoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
