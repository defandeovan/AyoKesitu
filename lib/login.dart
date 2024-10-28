import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:project_flutter/presentation/pages/homepage/Home_Screen.dart';
import 'package:project_flutter/SignUpScreen.dart'; // Import halaman registrasi

// Handler untuk notifikasi latar belakang
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Menangani pesan latar belakang: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inisialisasi Firebase Messaging
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Tangani pesan saat aplikasi dalam keadaan terminated
  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }

  runApp(MyApp());
}

// Fungsi untuk menangani pesan
void _handleMessage(RemoteMessage message) {
  print("Navigasi ke layar berdasarkan data pesan: ${message.data}");
  // Navigasi atau lakukan tindakan berdasarkan data pesan jika diperlukan
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ayo Kesitu',
      home: SignInScreen(), // Halaman login sebagai halaman awal
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _configureFCM();
  }

  // Minta izin untuk notifikasi
  void _requestPermission() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();
    print('Pengguna memberikan izin: ${settings.authorizationStatus}');
  }

  // Konfigurasi FCM untuk menerima notifikasi
  void _configureFCM() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Pesan diterima di foreground: ${message.notification?.title}");
      _showNotificationDialog(message.notification);
    });
  }

  // Tampilkan dialog notifikasi
  void _showNotificationDialog(RemoteNotification? notification) {
    if (notification != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(notification.title ?? "Notifikasi"),
            content: Text(notification.body ?? "Anda memiliki pesan baru."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // Fungsi untuk login
  Future<void> _signInWithEmailPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      print("Signed in: ${userCredential.user?.email}");

      // Menampilkan pesan keberhasilan login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login berhasil! Selamat datang, ${userCredential.user?.email}'),
          backgroundColor: Colors.green,
        ),
      );

      // Arahkan ke halaman utama setelah login berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      // Menangani berbagai jenis kesalahan yang mungkin terjadi
      if (e.code == 'user-not-found') {
        errorMessage = 'Akun tidak ditemukan. Silakan daftar terlebih dahulu.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Kata sandi yang Anda masukkan salah.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Format email tidak valid.';
      } else {
        errorMessage = 'Terjadi kesalahan. Coba lagi nanti.';
      }

      // Menampilkan pesan kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      // Menangani kesalahan lainnya
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/img/bali.png', // Gantilah dengan lokasi gambar latar belakang
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ayo Kesitu!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Travel with ease, Discover with Dave',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 32),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Tambahkan fungsi untuk lupa kata sandi jika perlu
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _signInWithEmailPassword, // Panggil fungsi login
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Warna tombol
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Sign In'),
                ),
                SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {
                    // Tambahkan fungsi untuk sign in dengan Google
                  },
                  icon: Icon(Icons.login, color: Colors.white),
                  label: Text(
                    'Sign In With Google Account',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    side: BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigasi ke halaman registrasi
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
