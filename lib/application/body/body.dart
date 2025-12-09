import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veusddd/application/body/steps/step_video.dart';
import 'package:veusddd/application/body/widgets/contact_button.dart';
import 'package:video_player/video_player.dart';

import 'steps/step_start.dart';
import 'steps/step_description.dart';
import 'steps/step_xavi.dart';
import 'steps/step_filippo.dart';
import 'steps/step_contact.dart';

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
    if (_pageController.page!.round() >= 5) return;

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
                StepStart(),
                StepDescription(),
                StepXavi(),
                StepFilippo(),
                StepVideo(),
                StepContact()
              ],
            ),
          ),
        ),

        Positioned(
          top: 32,
          right: 32,
          child: Row(
            children: [
              CustomButton(
                text: 'Descarregar dossier',
                onTap: () async {
                  await launchUrl(Uri.parse('files/DOSSIER_PRINT.pdf'), mode: LaunchMode.platformDefault);
                },
                icon: Icons.picture_as_pdf_outlined,
              ),
              SizedBox(width: 1.w,),
              CustomButton(
                text: 'Contacte',
                onTap: () {
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(
                      5,
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                icon: Icons.mail_outline,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
