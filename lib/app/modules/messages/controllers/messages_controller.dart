import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_flutter/app/modules/messages/views/chatMessage.dart';
class MessagesController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<ChatMessage> chatMessages = <ChatMessage>[].obs;
  RxString userRole = ''.obs; // Untuk menyimpan role user

  // Fungsi untuk mendapatkan role user dari Firestore
  Future<void> getUserRole(String userId) async {
    var doc = await firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      userRole.value = doc.data()?['role'] ?? 'user'; // Default ke 'user' jika tidak ditemukan
    }
  }

  // Fungsi untuk mengirim chat
  Future<void> sendMessage(String userId, String sender, String message) async {
    await getUserRole(userId); // Ambil role sebelum mengirim pesan
    ChatMessage newMessage = ChatMessage(
      sender: sender,
      message: message,
      timestamp: DateTime.now().toIso8601String(),
    );

    await firestore.collection('chats').add(newMessage.toJson());
  }

  // Fungsi untuk mengambil chat secara real-time
  void listenToMessages() {
    firestore.collection('chats').orderBy('timestamp').snapshots().listen((snapshot) {
      chatMessages.value = snapshot.docs.map((doc) => ChatMessage.fromJson(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  @override
  void onInit() {
    super.onInit();
    listenToMessages();
  }
}
