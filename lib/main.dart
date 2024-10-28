import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_flutter/presentation/pages/homepage/Home_Screen.dart';
import 'package:project_flutter/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'authcontroller.dart';
import 'FirebaseMessagingHandler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
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
      home: LoginScreen(),
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
                                builder: (context) => SignInScreen()),
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

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUp() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Jika pendaftaran berhasil, navigasi ke HomeScreen
      Get.to(HomeScreen());
    } on FirebaseAuthException catch (e) {
      // Menampilkan pesan kesalahan
      Get.snackbar('Error', e.message ?? 'Registration failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: signUp,
              child: Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
