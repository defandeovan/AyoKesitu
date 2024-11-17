
// import 'package:flutter/material.dart';
// import 'package:project_flutter/app/modules/chatscreen/views/ChatBubble.dart';

// class ChatMessages extends StatelessWidget {
//   final List<Map<String, String>> messages;

//   const ChatMessages({required this.messages});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: EdgeInsets.all(8),
//       itemCount: messages.length,
//       itemBuilder: (context, index) {
//         final message = messages[index];
//         final isMe = message['isMe'] == 'true';
//         return ChatBubble(
//           text: message['text']!,
//           time: message['time']!,
//           isMe: isMe,
//         );
//       },
//     );
//   }
// }
