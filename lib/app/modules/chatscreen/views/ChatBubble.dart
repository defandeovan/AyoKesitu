// import 'dart:io';

// import 'package:flutter/material.dart';

// class ChatBubble extends StatelessWidget {
//   final String text;
//   final String time;
//   final bool isMe;
//   final String? imagePath; // Nullable imagePath

//   const ChatBubble({
//     required this.text,
//     required this.time,
//     required this.isMe,
//     this.imagePath, // Make imagePath optional (nullable)
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Column(
//         crossAxisAlignment:
//             isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//             margin: EdgeInsets.only(
//               top: 8,
//               bottom: 8,
//               left: isMe ? 50 : 0,
//               right: isMe ? 0 : 50,
//             ),
//             decoration: BoxDecoration(
//               color: isMe ? Color(0xFF00A550) : Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.3),
//                   blurRadius: 4,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 // Display image if imagePath is not null
//                 if (imagePath != null) 
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: Image.file(
//                       File(imagePath!),
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 // Text message
//                 Flexible(
//                   child: Text(
//                     text,
//                     style: TextStyle(
//                       color: isMe ? Colors.white : Colors.black87,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8), // Space between text and time
//                 // Time text with conditional color
//                 Text(
//                   time,
//                   style: TextStyle(
//                     color: isMe ? Colors.white : Colors.grey,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
