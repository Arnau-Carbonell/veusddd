import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StepThree extends StatefulWidget {
  const StepThree({super.key});

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree>
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
                        const Text("Xavi Mira",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),),
                        SizedBox(height: 2.h,),
                        const Text(
                          "Descripció Xavi",
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
            SizedBox(width: 3.w),
            Image.asset('assets/images/xavi.jpg', width: 45.w,),
          ],
        ),
      ),
    );
  }
}
