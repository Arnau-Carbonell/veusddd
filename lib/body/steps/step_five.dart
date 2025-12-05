import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StepFive extends StatefulWidget {
  const StepFive({super.key});

  @override
  State<StepFive> createState() => _StepFiveState();
}

class _StepFiveState extends State<StepFive> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _message = TextEditingController();

  Future<void> _sendEmail() async {
    final subject = Uri.encodeComponent(
      "Contacto desde la web - ${_name.text}",
    );

    final body = Uri.encodeComponent(
      "Nombre: ${_name.text}\n"
          "Email: ${_email.text}\n\n"
          "Mensaje:\n${_message.text}",
    );

    final Uri emailUri = Uri.parse(
      "mailto:distribucio@veusdd.es?subject=$subject&body=$body",
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo abrir el cliente de correo")),
      );
    }
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

                // ✅ NOMBRE
                TextFormField(
                  controller: _name,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration("Nom"),
                  validator: (v) =>
                  v == null || v.isEmpty ? "Introdueix el teu nom" : null,
                ),
                const SizedBox(height: 16),

                // ✅ EMAIL
                TextFormField(
                  controller: _email,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration("Email"),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Introdeix el teu email";
                    if (!v.contains("@")) return "Email no válido";
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // ✅ MENSAJE
                TextFormField(
                  controller: _message,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 4,
                  decoration: _inputDecoration("Missatge"),
                  validator: (v) =>
                  v == null || v.isEmpty ? "Escriu un missatge" : null,
                ),

                const SizedBox(height: 32),

                // ✅ BOTÓN ENVIAR
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
      fillColor: Colors.white.withOpacity(0.08),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
