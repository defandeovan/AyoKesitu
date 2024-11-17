// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:project_flutter/app/modules/chatscreen/controllers/chatscreen_controller.dart';

// class ChatInputField extends StatefulWidget {
//   final TextEditingController controller;
//   final VoidCallback onSend;

//   const ChatInputField({
//     Key? key,
//     required this.controller,
//     required this.onSend,
//   }) : super(key: key);

//   @override
//   _ChatInputFieldState createState() => _ChatInputFieldState();
// }

// class _ChatInputFieldState extends State<ChatInputField> {
//   final LayerLink _layerLink = LayerLink();
//   OverlayEntry? _menuOverlay;

//   void _toggleMenu() {
//     if (_menuOverlay == null) {
//       _menuOverlay = _createMenuOverlay();
//       Overlay.of(context).insert(_menuOverlay!);
//     } else {
//       _menuOverlay?.remove();
//       _menuOverlay = null;
//     }
//   }

//   OverlayEntry _createMenuOverlay() {
//     return OverlayEntry(
//       builder: (context) => Positioned(
//         width: 200,
//         child: CompositedTransformFollower(
//           link: _layerLink,
//           showWhenUnlinked: false,
//           offset: const Offset(0, -170), 
//           child: Material(
//             elevation: 4,
//             borderRadius: BorderRadius.circular(8),
//             child: Container(
//               color: Colors.white,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _buildMenuItem(Icons.camera_alt, "Camera", () {
//                     Get.find<ChatscreenController>().pickImage(ImageSource.camera);
//                     _toggleMenu();
//                   }),
//                   _buildMenuItem(Icons.videocam, "Video", () {
//                     print("Video selected");
//                     _toggleMenu();
//                   }),
//                   _buildMenuItem(Icons.audiotrack, "Audio", () {
//                     print("Audio selected");
//                     _toggleMenu();
//                   }),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuItem(IconData icon, String label, VoidCallback onTap) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.black),
//       title: Text(label, style: const TextStyle(color: Colors.black)),
//       onTap: onTap,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CompositedTransformTarget(
//       link: _layerLink,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, -1),
//             ),
//           ],
//         ),
//         child: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: const Color.fromARGB(235, 222, 222, 222),
//             border: Border.all(
//               color: const Color.fromARGB(255, 162, 162, 162),
//               width: 1.5,
//             ),
//           ),
//           child: Row(
//             children: [
//               GestureDetector(
//                 onTap: _toggleMenu,
//                 child: SvgPicture.asset(
//                   'assets/img/add.svg',
//                   width: 24,
//                   height: 24,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Container(
//                   height: 35,
//                   padding: const EdgeInsets.symmetric(horizontal: 2),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 255, 255, 255),
//                     border: Border.all(
//                       color: const Color.fromARGB(255, 162, 162, 162),
//                       width: 1.5,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: TextField(
//                     controller: widget.controller,
//                     decoration: const InputDecoration(
//                       hintText: 'Ketik pesan...',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               GestureDetector(
//                 onTap: widget.onSend,
//                 child: SvgPicture.asset(
//                   'assets/img/send_chat.svg',
//                   width: 24,
//                   height: 24,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _menuOverlay?.remove();
//     super.dispose();
//   }
// }
