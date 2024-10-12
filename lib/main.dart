import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_flutter/presentation/pages/homepage/Home_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: LoginScreen(), debugShowCheckedModeBanner: false);
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/img/image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content on top of the background
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo Image
              Image.asset(
                'assets/img/logo.png', // Path ke logo Anda
                width: 150, // Anda dapat sesuaikan ukuran logo di sini
                height: 150,
              ),
              SizedBox(height: 5), // Jarak dikurangi dari 1 menjadi 5
              Text(
                'Travel with ease, Discover with Dave',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Spacer(), // Spacer untuk menempatkan elemen-elemen di bawah
              // Sign In Button
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
                                builder: (context) => HomeScreen()),
                          );
                        },
                        child: Text('Sign In'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Background color
                          foregroundColor:
                              Colors.white, // Warna teks diubah ke putih
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          textStyle: TextStyle(
                            fontSize: 16, // Smaller font size
                          ),
                          minimumSize: Size(250, 50), // Ukuran minimum tombol
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Tambahkan aksi ketika tombol "Sign In With Google" dipencet
                          print("Sign In with Google button pressed");
                        },
                        icon: Icon(Icons.login, size: 18), // Smaller icon
                        label: Text('Sign In With Google Account'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white, // Text color
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15), // Padding tombol
                          textStyle: TextStyle(
                            fontSize: 16, // Smaller font size
                          ),
                          minimumSize: Size(250, 50), // Ukuran minimum tombol
                        ),
                      ),
                      SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal, // Tidak bold
                          ),
                          children: <TextSpan>[
                            TextSpan(text: "Don't have any account? "),
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold, // Dicetak tebal
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 30), // Jarak dikurangi untuk mengangkat teks
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Text(
                          "By creating an account or signing up, you agree to our Terms of Service and Privacy Policy",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
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
