// import 'dart:io';

// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:project_flutter/app/modules/chatscreen/views/ChatBubble.dart';
// import 'package:project_flutter/app/routes/app_pages.dart';
// import 'package:video_player/video_player.dart';

// class ChatscreenController extends GetxController {
//   final ImagePicker _picker = ImagePicker();
//   final box = GetStorage();

//   var selectedImagePath = ''.obs;
//   var isImageLoading = false.obs;

//   var selectedVideoPath = ''.obs;
//   var isVideoPlaying = false.obs;
//   VideoPlayerController? videoPlayerController;
//   var messages = <ChatBubble>[].obs;

//   final count = 0.obs;

//   @override
//   void onInit() {
//     super.onInit();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }

//   Future<void> pickImage(ImageSource source) async {
//     try {
//       isImageLoading.value = true;
//       final XFile? pickedFile = await _picker.pickImage(source: source);
//       if (pickedFile != null) {
//         selectedImagePath.value = pickedFile.path;
//         messages.add(
//           ChatBubble(
//             text: '',
//             time: DateFormat('hh:mm a').format(DateTime.now()),
//             isMe: true,
//             imagePath: pickedFile.path,
//           ),
//         );
//         Get.to(Routes.CHATSCREEN);
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//     } finally {
//       isImageLoading.value = false;
//     }
//   }

//   Future<void> pickVideo(ImageSource source) async {
//     try {
//       isImageLoading.value = true;
//       final XFile? pickedFile = await _picker.pickVideo(source: source);
//       if (pickedFile != null) {
//         selectedVideoPath.value = pickedFile.path;
//         box.write('videoPath', pickedFile.path);

//         videoPlayerController =
//             VideoPlayerController.file(File(pickedFile.path))
//               ..initialize().then((_) {
//                 videoPlayerController!.play();
//                 isVideoPlaying.value = true;
//                 update();
//               });
//       } else {
//         print('No video selected');
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       isImageLoading.value = false;
//     }
//   }

//   void _loadStoreData() {
//     selectedImagePath.value = box.read('imagePath') ?? '';
//     selectedVideoPath.value = box.read('videoPath') ?? '';
//     if (selectedVideoPath.value.isNotEmpty) {
//       videoPlayerController =
//           VideoPlayerController.file(File(selectedVideoPath.value))
//             ..initialize().then((_) {
//               videoPlayerController!.play();
//               isVideoPlaying.value = true;
//               update();
//             });
//     }
//   }

//   void play() {
//     videoPlayerController?.play();
//     isVideoPlaying.value = true;
//     update();
//   }

//   void pause() {
//     videoPlayerController?.pause();
//     isVideoPlaying.value = false;
//     update();
//   }

//   void togglePlayPause() {
//     if (videoPlayerController != null) {
//       if (videoPlayerController!.value.isPlaying) {
//         videoPlayerController!.pause();
//         isVideoPlaying.value = false;
//       } else {
//         videoPlayerController!.play();
//         isVideoPlaying.value = true;
//       }
//       update();
//     }
//   }
// }
