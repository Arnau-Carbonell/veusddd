import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget{
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.black.withValues(alpha: 0.12),
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      toolbarHeight: 72,
      titleSpacing: 12,
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Veus d'ací, d'allà i de més enllà",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Color(0xef075bc2),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: BoxBorder.all(color: Colors.white)
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsetsGeometry.all(10),
                child: Row(
                  children: [
                    Text(
                        "Contacte",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 5,),
                    Icon(Icons.send_rounded, color: Colors.white,)
                  ],
                ),
              ),
            ),
          ),
        )

      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}
