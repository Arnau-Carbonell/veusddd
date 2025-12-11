import 'package:flutter/material.dart';

class StepStart extends StatefulWidget {
  final Size size;
  const StepStart({super.key, required this.size});

  @override
  State<StepStart> createState() => _StepStartState();
}

class _StepStartState extends State<StepStart>
    with TickerProviderStateMixin {
  late AnimationController _anim;
  late Animation<double> _fade;

  late AnimationController _iconController;
  late Animation<Offset> _iconSlide;

  @override
  void initState() {
    super.initState();

    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _fade = CurvedAnimation(parent: _anim, curve: Curves.easeOut);

    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _iconSlide =
        Tween(
          begin: const Offset(0, -0.15),
          end: const Offset(0, 0.10),
        ).animate(
          CurvedAnimation(parent: _iconController, curve: Curves.easeInOut),
        );
  }

  @override
  void dispose() {
    _anim.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.size.width;
    final h = widget.size.height;

    double titleFont = w * 0.04;
    double bodyFont = w * 0.01;

    titleFont = titleFont.clamp(24, 60);
    bodyFont = bodyFont.clamp(14, 32);
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: Colors.black.withValues(alpha: 0.45)),

        FadeTransition(
          opacity: _fade,
          child: Padding(
            padding: EdgeInsets.only(top: h * 0.25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "VEUS D'ACÍ, D'ALLÀ I DE MÉS ENLLÀ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: titleFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: h * 0.02),
                Text(
                  'Baixa per a continuar',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: bodyFont,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: h * 0.01),
                SlideTransition(
                  position: _iconSlide,
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
