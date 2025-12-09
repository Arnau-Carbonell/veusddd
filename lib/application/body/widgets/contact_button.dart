import 'package:flutter/material.dart';

class ContactButton extends StatefulWidget {
  final VoidCallback onTap;

  const ContactButton({required this.onTap, super.key});

  @override
  State<ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<ContactButton> {
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
                  ? Colors.black.withOpacity(0.8)
                  : Colors.white.withOpacity(0.6),
              width: 1,
            ),
            boxShadow: _isHovering
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.mail_outline,
                color: Colors.black,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                "Contacte",
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