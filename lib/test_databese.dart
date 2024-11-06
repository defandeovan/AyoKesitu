import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestDatabese extends StatefulWidget {
  const TestDatabese({super.key});

  @override
  State<TestDatabese> createState() => _TestDatabeseState();
}

class _TestDatabeseState extends State<TestDatabese> {
  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: db.collection('users').snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshots.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          //olah data
          var _data = snapshots.data!.docs;
          
          return ListView.builder(
            itemCount: _data.length,
            itemBuilder: (context, index) {
            return ListTile(
              title: Text(_data[index].data().toString()),
            );
          }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final user = <String, dynamic>{
            "firs": "ADA",
            "last": "KARAKOC",
            "born": 1825
          };
          db
              .collection("users")
              .add(user)
              .then((DocumentReference doc) => print("id ${doc.id}"));
        },
      ),
    );
  }
}
