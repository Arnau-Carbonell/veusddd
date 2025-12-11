import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String text;

  const CustomButton({required this.onTap, required this.icon, required this.text, super.key});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovering ? Colors.grey[200] : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: _isHovering
                  ? Colors.black.withValues(alpha:0.8)
                  : Colors.white.withValues(alpha:0.6),
              width: 1,
            ),
            boxShadow: _isHovering
                ? [
              BoxShadow(
                color: Colors.black.withValues(alpha:0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: Colors.black,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                widget.text,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}