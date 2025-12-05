import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:veusddd/body/steps/step_five.dart';
import 'package:veusddd/body/steps/step_four.dart';
import 'package:veusddd/body/steps/step_one.dart';
import 'package:veusddd/body/steps/step_three.dart';
import 'package:veusddd/body/steps/step_two.dart';
import 'package:video_player/video_player.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final PageController _pageController = PageController();
  bool _isAnimating = false;
  late VideoPlayerController _video;
  @override
  void initState() {
    super.initState();
    _video = VideoPlayerController.asset('assets/videos/trailer.mp4')
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) {
        setState(() {});
        _video.play();
      });
  }
  @override
  void dispose() {
    super.dispose();
    _video.dispose();

  }

  void _nextPage() async {
    if (_isAnimating) return;
    if (!_pageController.hasClients) return;
    if (_pageController.page!.round() >= 4) return;

    _isAnimating = true;

    await _pageController.nextPage(
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(milliseconds: 900), () {
      _isAnimating = false;
    });
  }

  void _prevPage() async {
    if (_isAnimating) return;
    if (!_pageController.hasClients) return;
    if (_pageController.page!.round() <= 0) return;

    _isAnimating = true;

    await _pageController.previousPage(
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(milliseconds: 900), () {
      _isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _video.value.isInitialized
            ? FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _video.value.size.width,
            height: _video.value.size.height,
            child: VideoPlayer(_video),
          ),
        )
            : const Center(child: CircularProgressIndicator()),
        Listener(
          onPointerSignal: (event) {
            if (event is PointerScrollEvent) {
              if (event.scrollDelta.dy > 0) {
                _nextPage();
              } else if (event.scrollDelta.dy < 0) {
                _prevPage();
              }
            }
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: const [
                StepOne(),
                StepTwo(),
                StepThree(),
                StepFour(),
                StepFive()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
