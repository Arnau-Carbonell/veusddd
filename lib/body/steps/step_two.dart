import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StepTwo extends StatefulWidget {
  const StepTwo({super.key});

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo>
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
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.7),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 1.w),
        child: Row(
          children: [
            Image.asset('assets/images/mans.jpg', width: 45.w,),
            SizedBox(width: 3.w),
            SizedBox(
              width: 45.w,
              child: Center(
                child: FadeTransition(
                  opacity: _fade,
                  child: SlideTransition(
                    position: _slide,
                    child: const Text(
                      "Un viatge musical que travessa fronteres i emocions."
                          "\nDe l'arrel alcoiana fins a les grans veus universals: Ovidi Montllor, Camilo Sesto, Nino Bravo, Elton John, Sinatra..."
                      "\nXavi Mira posa veu i ànima a melodies que han fet història, mentre Filippo Fanó acarona el piano amb sensibilitat i elegància.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
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
