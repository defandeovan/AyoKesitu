import 'package:flutter/material.dart';

Future<void> main()async{
  runApp(MyPage());
}


class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Future<void> refreshData() async {
    await Future.delayed(Duration(seconds: 2)); // Simulasi loading data
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pull to Refresh")),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: ListView(
          children: [
           
            
          ],
        ),
      ),
    );
  }
}
