import 'package:flutter/material.dart';

class StepDescription extends StatefulWidget {
  final Size size;
  const StepDescription({super.key, required this.size});

  @override
  State<StepDescription> createState() => _StepDescriptionState();
}

class _StepDescriptionState extends State<StepDescription>
    with SingleTickerProviderStateMixin {
  late AnimationController _anim;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    _slide = Tween(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _anim, curve: Curves.easeOut),
    );

    _fade = CurvedAnimation(parent: _anim, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.size.width;

    double fontSize = w * 0.02;
    fontSize = fontSize.clamp(16, 36);

    double paddingH = w * 0.02;
    double imageWidth = w * 0.45;
    double textWidth = w * 0.45;

    return Container(
      color: Colors.black.withValues(alpha: 0.7),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingH),
        child: Row(
          children: [
            Image.asset(
              'assets/images/mans.jpg',
              width: imageWidth,
              fit: BoxFit.cover,
            ),

            SizedBox(width: w * 0.03),

            SizedBox(
              width: textWidth,
              child: Center(
                child: FadeTransition(
                  opacity: _fade,
                  child: SlideTransition(
                    position: _slide,
                    child: Text(
                      "Un viatge musical que travessa fronteres i emocions."
                          "\nDe l'arrel alcoiana fins a les grans veus universals: Ovidi Montllor, Camilo Sesto, Nino Bravo, Elton John, Sinatra..."
                          "\nXavi Mira posa veu i ànima a melodies que han fet història, mentre Filippo Fanó acarona el piano amb sensibilitat i elegància.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
