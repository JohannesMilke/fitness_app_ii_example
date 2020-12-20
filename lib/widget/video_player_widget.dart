import 'package:fitness_app_ii_example/model/exercise.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Exercise exercise;
  final VoidCallback onInitialized;

  const VideoPlayerWidget({
    @required this.exercise,
    @required this.onInitialized,
  });

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(widget.exercise.videoUrl)
      ..initialize().then((value) {
        controller.setLooping(true);
        controller.play();

        widget.exercise.controller = controller;
        widget.onInitialized();
      });
  }

  @override
  Widget build(BuildContext context) => SizedBox.expand(
        child: controller.value.initialized
            ? VideoPlayer(controller)
            : Center(child: CircularProgressIndicator()),
      );
}
