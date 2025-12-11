import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class StepVideo extends StatefulWidget {
  final Size size;
  const StepVideo({super.key, required this.size});

  @override
  State<StepVideo> createState() => _StepVideoState();
}

class _StepVideoState extends State<StepVideo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController.fromVideoId(
      videoId: 'KSljc0MQmTQ',
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = widget.size.width;
    double maxWidth = screenWidth * 0.9;
    double height = maxWidth * 9 / 16;

    return Container(
      color: Colors.black.withValues(alpha: 0.7),
      child: Center(
        child: SizedBox(
          width: maxWidth,
          height: height,
          child: YoutubePlayer(
            controller: _controller,
            aspectRatio: 16 / 9,
          ),
        ),
      ),
    );
  }
}
