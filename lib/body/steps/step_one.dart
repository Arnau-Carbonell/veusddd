import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class StepOne extends StatefulWidget {
  const StepOne({super.key});

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne>
    with SingleTickerProviderStateMixin {
  late AnimationController _anim;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _fade = CurvedAnimation(parent: _anim, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Filtro gris
        Container(color: Colors.black.withOpacity(0.45)),

        // Texto animado
        FadeTransition(
          opacity: _fade,
          child: Padding(
            padding: EdgeInsets.only(top: 25.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "VEUS D'ACÍ, D'ALLÀ I DE MÉS ENLLÀ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Baixa per a continuar',
                  style: TextStyle(color: Colors.white70, fontSize: 20, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 4),
                Icon(Icons.arrow_downward_rounded, color: Colors.white,)
              ],
            ),
          ),
        )
      ],
    );
  }
}
