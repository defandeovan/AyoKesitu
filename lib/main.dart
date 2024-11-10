import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_flutter/app/controller/firebase_options.dart';

import 'app/routes/app_pages.dart';

import 'package:firebase_core/firebase_core.dart';
import 'app/controller/authcontroller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'ayo_kesitu',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
