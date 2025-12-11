import 'package:flutter/material.dart';

class StepXavi extends StatefulWidget {
  final Size size;
  const StepXavi({super.key, required this.size});

  @override
  State<StepXavi> createState() => _StepXaviState();
}

class _StepXaviState extends State<StepXavi>
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
    final h = widget.size.height;

    double titleFont = w * 0.04;
    double bodyFont = w * 0.02;

    titleFont = titleFont.clamp(24, 60);
    bodyFont = bodyFont.clamp(14, 32);

    return Container(
      color: Colors.black.withValues(alpha: 0.7),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.02,
          vertical: h * 0.14,
        ),
        child: Row(
          children: [
            SizedBox(
              width: w * 0.45,
              child: Center(
                child: FadeTransition(
                  opacity: _fade,
                  child: SlideTransition(
                    position: _slide,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Xavi Mira",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: titleFont,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: h * 0.02),
                        Text(
                          "Actor i cantant amb més de 30 anys d'experiències en cine i televisió.\n"
                              "Protagonista de musicals com 'La Familia Addams' (PTM a millor actor de musical) "
                              "o T'estime ets Perfecte ja et Canviaré (Premi Butaca a millor actor de musical)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: bodyFont,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: w * 0.03),
            Image.asset(
              'assets/images/xavi.jpeg',
              width: w * 0.45,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
