import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class StarterController extends GetxController {
  late VideoPlayerController controller;

  initVideoPlayer() {
    controller = VideoPlayerController.asset("assets/videos/gemini.mp4")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      });
    controller.play();
    controller.setLooping(true);
  }

  onDispose() {
    controller.dispose();
  }


}
