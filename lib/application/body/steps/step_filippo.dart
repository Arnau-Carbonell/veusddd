import 'package:flutter/material.dart';

class StepFilippo extends StatefulWidget {
  final Size size;
  const StepFilippo({super.key, required this.size});

  @override
  State<StepFilippo> createState() => _StepFilippoState();
}

class _StepFilippoState extends State<StepFilippo>
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
    double bodyFont  = w * 0.02;

    titleFont = titleFont.clamp(24, 60);
    bodyFont = bodyFont.clamp(14, 32);

    return Container(
      color: Colors.black.withValues(alpha:0.7),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.02,
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/images/filippo.jpg',
              width: w * 0.45,
              fit: BoxFit.cover,
            ),

            SizedBox(width: w * 0.03),

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
                          "Filippo Fanò",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: titleFont,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: h * 0.02),

                        Text(
                          "Llicenciat superior en piano Cum Laude al Conservatori de Perugia (Itàlia) i Diploma en Direcció d’Orquestra a l’ESMUC\n"
                              "Ha compost, interpretat i dirigit desenes de formacions en l'àmbit teatral on destaca la seva activitat com a pianista i Director Musical en alguns dels musicals més importants a Catalunya i Espanya com The Wild Party, La Familia Addams o A Chorus Line.",
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
          ],
        ),
      ),
    );
  }
}
