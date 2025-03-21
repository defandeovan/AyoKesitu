
// data.dart
import 'package:chatview/chatview.dart';

class Data {
  static List<Message> messageList = [
    Message(
      id: '1',
      message: 'Hello, how are you?',
      createdAt: DateTime.now(),
      sentBy: '2',
    ),
    Message(
      id: '2',
      message: 'I am fine, thank you!',
      createdAt: DateTime.now(),
      sentBy: '1',
    ),
  ];

  static String profileImage =
      'https://www.w3schools.com/howto/img_avatar.png';
}