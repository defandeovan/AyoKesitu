import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_flutter/app/modules/home/views/home_view.dart';
import 'package:project_flutter/app/modules/boarding/views/boarding_view.dart';
import 'package:project_flutter/app/modules/login/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckdataView extends StatefulWidget {
  @override
  _CheckdataViewState createState() => _CheckdataViewState();
}

class _CheckdataViewState extends State<CheckdataView> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedId = prefs.getString('saved_id');
    String? status = prefs.getString('status');
    if (savedId != null && savedId.isNotEmpty) {
      if (savedId ==
          'lx4ACBzU3zdEuUXySpbLPd4o0lT2') {Get.offNamed('/admin', arguments: {'userId': savedId});} // Jika ada data login, langsung ke HomeView
      else{
              Get.offNamed('/home', arguments: {'userId': savedId});
      }
    } else {
      if (status != null && status.isNotEmpty) {
        // Jika tidak ada, tetap di LoginView
        Get.offAll(() => LoginView());
      } else {
        Get.offAll(() => BoardingView());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), // Tampilkan loading saat mengecek login
      ),
    );
  }
}
