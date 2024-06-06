import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class StarterController extends GetxController {
  late VideoPlayerController controller;

  initVideoPlayer() async
  {
    controller = VideoPlayerController.asset("assets/videos/gemini.mp4")
      ..initialize().then((_) {});
    controller.play();
    controller.setLooping(true);
  }

  onDispose() {
    controller.dispose();
  }
}
