// import 'package:flutter/material.dart';





// import 'package:project_flutter/app/modules/chatscreen/views/ChatInputField.dart';
// import 'package:project_flutter/app/modules/chatscreen/views/ChatMessages.dart';



// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ChatscreenView(),
//     );  
//   }
// }

// class ChatscreenView extends StatefulWidget {
//   @override
//   _ChatscreenViewState createState() => _ChatscreenViewState();
// }

// class _ChatscreenViewState extends State<ChatscreenView> {
//   final List<Map<String, String>> messages = [
//     {'text': 'Halo', 'time': '12:00 PM', 'isMe': 'false'},
//     {'text': 'Selamat Pagi', 'time': '12:00 PM', 'isMe': 'false'},
//     {'text': 'Halo', 'time': '12:00 PM', 'isMe': 'true'},
//     {'text': 'Selamat pagi', 'time': '12:00 PM', 'isMe': 'true'},
//     {'text': 'Halo', 'time': '12:00 PM', 'isMe': 'false'},
//     {'text': 'Selamat Siang', 'time': '12:00 PM', 'isMe': 'false'},
//     {'text': 'Halo', 'time': '12:00 PM', 'isMe': 'true'},
//     {'text': 'Selamat Siang', 'time': '12:00 PM', 'isMe': 'true'},
//   ];

//   final TextEditingController _controller = TextEditingController();

//   void _sendMessage() {
//     if (_controller.text.trim().isNotEmpty) {
//       setState(() {
//         messages.add({
//           'text': _controller.text,
//           'time': '12:00 PM',
//           'isMe': 'true',
//         });
//       });
//       _controller.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: Colors.blue,
//               child: Icon(Icons.person, color: Colors.white),
//             ),
//             SizedBox(width: 10),
//             Text('Admin'),
//           ],
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {},
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(child: ChatMessages(messages: messages)),
//           ChatInputField(controller: _controller, onSend: _sendMessage),
//         ],
//       ),
//     );
//   }
// }
