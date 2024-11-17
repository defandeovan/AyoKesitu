import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  //TODO: Implement PaymentController
  late AudioPlayer audioPlayer;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer();
  }

  Future<void> playSuccessAudio(String path) async {
    // musik
    try{
      await audioPlayer.play(AssetSource(path));
      print('Audio playing...');
    }catch(e){
      print("erorrrrrr : $e");

    }

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
