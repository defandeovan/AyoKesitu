import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:project_flutter/presentation/pages/homepage/Home_Screen.dart';
import 'package:project_flutter/login.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_flutter/presentation/pages/message/chat.dart';
import 'package:project_flutter/presentation/pages/payment/payment.dart';
import 'package:project_flutter/presentation/pages/payment/success.dart';

import 'firebase_options.dart';
import 'authcontroller.dart';
// ignore: unused_import
import 'FirebaseMessagingHandler.dart';

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
      home: PaymentSuccessPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/img/logo.png',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 5),
              Text(
                'Travel with ease, Discover with Dave',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>   SignInScreen()),
                          );
                        },
                        child: Text('Sign In'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          textStyle: TextStyle(fontSize: 16),
                          minimumSize: Size(250, 50),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          print("Sign In with Google button pressed");
                        },
                        icon: Icon(Icons.login, size: 18),
                        label: Text('Sign In With Google Account'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          textStyle: TextStyle(fontSize: 16),
                          minimumSize: Size(250, 50),
                        ),
                      ),
                      SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                          children: <TextSpan>[
                            TextSpan(text: "Don't have any account? "),
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Text(
                          "By creating an account or signing up, you agree to our Terms of Service and Privacy Policy",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
