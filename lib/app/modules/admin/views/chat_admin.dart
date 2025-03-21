import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatAdmin extends StatelessWidget {
  final String userId; // ID pengguna yang diajak chat
  ChatAdmin({required this.userId});

  final TextEditingController messageController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final User? admin = FirebaseAuth.instance.currentUser; // Admin yang sedang login

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat dengan $userId')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: firestore
                  .collection('chats')
                  .doc(getChatId(admin!.uid, userId))
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView(
                  reverse: true,
                  children: snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                    bool isAdmin = data['senderId'] == admin!.uid;
                    return Align(
                      alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: isAdmin ? Colors.blueAccent : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(data['message']),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(hintText: 'Ketik pesan...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => sendMessage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      firestore
          .collection('chats')
          .doc(getChatId(admin!.uid, userId))
          .collection('messages')
          .add({
        'senderId': admin!.uid,
        'receiverId': userId,
        'message': messageController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      messageController.clear();
    }
  }

  String getChatId(String id1, String id2) {
    return id1.hashCode <= id2.hashCode ? '$id1-$id2' : '$id2-$id1';
  }
}