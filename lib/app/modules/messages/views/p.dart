import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChatScreen(
        userId: 'Hvo78FLfyTYLaE0cpd1gdhyMiGD3',
        peerId: 'hmRbMRb7UhaV2Mq20zEDPObFaoq2',
      ), // Ubah sesuai user yang login
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String userId;
  final String peerId; // ID lawan bicara

  const ChatScreen({super.key, required this.userId, required this.peerId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  late types.User _currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String _chatId;

  @override
  void initState() {
    super.initState();
    _currentUser =
        types.User(id: widget.userId, firstName: 'User ${widget.userId}');

    // Gunakan fungsi getChatId untuk mendapatkan ID unik
   _chatId = getChatId(widget.userId, widget.peerId);


    _loadMessages();
  }

  /// Fungsi untuk membuat chatId unik berdasarkan 2 user
String getChatId(String userId1, String userId2) {
  List<String> sortedIds = [userId1, userId2]..sort(); // Urutkan ID agar tetap konsisten
  return sortedIds.join('_'); // Gabungkan jadi chatId unik
}


  // Ambil pesan dari Firestore berdasarkan chatId
  void _loadMessages() {
    _firestore
        .collection('chats')
        .doc(_chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        _messages.clear();
        for (var doc in snapshot.docs) {
          _messages.add(types.TextMessage(
            id: doc.id,
            text: doc['text'],
            author: types.User(id: doc['authorId']),
            createdAt: doc['createdAt'],
          ));
        }
      });
    });
  }

  // Simpan pesan ke Firestore
  void _handleSendPressed(types.PartialText message) async {
  try {
    String chatId = getChatId(widget.userId, widget.peerId); // Perbaikan: gunakan dua parameter

    DocumentReference chatRef = _firestore.collection('chats').doc(chatId);

    // Cek apakah chat sudah ada, jika tidak, buat chat baru
    DocumentSnapshot chatSnapshot = await chatRef.get();
    if (!chatSnapshot.exists) {
      await chatRef.set({
        'users': [widget.userId, widget.peerId], // Tambahkan kedua user
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      });
    }

    // Simpan pesan ke Firestore
    await chatRef.collection('messages').add({
      'text': message.text,
      'authorId': _currentUser.id,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
  } catch (e) {
    print("Error saat mengirim pesan: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat with ${widget.peerId}')),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _currentUser,
      ),
    );
  }
}
