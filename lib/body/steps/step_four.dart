import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StepFour extends StatefulWidget {
  const StepFour({super.key});

  @override
  State<StepFour> createState() => _StepFourState();
}

class _StepFourState extends State<StepFour>
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
            Image.asset('assets/images/filippo.jpg', width: 45.w,),
            SizedBox(width: 3.w),
            SizedBox(
              width: 45.w,
              child: Center(
                child: FadeTransition(
                  opacity: _fade,
                  child: SlideTransition(
                    position: _slide,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Filippo Fanó",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),),
                        SizedBox(height: 2.h,),
                        const Text(
                          "Descripció Filippo",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
