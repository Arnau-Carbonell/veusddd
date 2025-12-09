import 'package:flutter/material.dart';

import '../../../src/email/send_email.dart';

class StepContact extends StatefulWidget {
  const StepContact({super.key});

  @override
  State<StepContact> createState() => _StepContactState();
}

class _StepContactState extends State<StepContact> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _message = TextEditingController();

  Future<void> _sendEmail() async {
    await EmailService.sendEmail(
      subject: _name.text,
      message: _message.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.7),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "CONTACTE",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),

                TextFormField(
                  controller: _name,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration("Assumpte"),
                  validator: (v) =>
                  v == null || v.isEmpty ? "Introdueix l'assumpte" : null,
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _message,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 4,
                  decoration: _inputDecoration("Missatge"),
                  validator: (v) =>
                  v == null || v.isEmpty ? "Escriu un missatge" : null,
                ),

                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _sendEmail();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text(
                      "ENVIAR MISSATGE",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.08),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
