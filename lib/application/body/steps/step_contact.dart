import 'package:flutter/material.dart';
import '../../../src/email/send_email.dart';

class StepContact extends StatefulWidget {
  final Size size;
  const StepContact({super.key, required this.size});

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
    final w = widget.size.width;
    final h = widget.size.height;

    double titleFont = w * 0.035;
    double inputFont = w * 0.018;
    double buttonFont = w * 0.018;

    titleFont = titleFont.clamp(28, 50);
    inputFont = inputFont.clamp(14, 22);
    buttonFont = buttonFont.clamp(14, 22);

    double verticalSpacing = h * 0.03;
    double inputHeight = h * 0.065;
    double buttonHeight = h * 0.07;

    return Container(
      color: Colors.black.withValues(alpha:0.7),
      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "CONTACTE",
                  style: TextStyle(
                    fontSize: titleFont,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: verticalSpacing),

                SizedBox(
                  height: inputHeight,
                  child: TextFormField(
                    controller: _name,
                    style: TextStyle(color: Colors.white, fontSize: inputFont),
                    decoration: _inputDecoration("Assumpte", inputFont),
                    validator: (v) =>
                    v == null || v.isEmpty ? "Introdueix l'assumpte" : null,
                  ),
                ),
                
                TextFormField(
                  controller: _message,
                  style: TextStyle(color: Colors.white, fontSize: inputFont),
                  maxLines: 4,
                  decoration: _inputDecoration("Missatge", inputFont),
                  validator: (v) =>
                  v == null || v.isEmpty ? "Escriu un missatge" : null,
                ),

                SizedBox(height: verticalSpacing),

                SizedBox(
                  width: double.infinity,
                  height: buttonHeight,
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
                    child: Text(
                      "ENVIAR MISSATGE",
                      style: TextStyle(
                        fontSize: buttonFont,
                        fontWeight: FontWeight.bold,
                      ),
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

  InputDecoration _inputDecoration(String hint, double fontSize) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white54, fontSize: fontSize),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.08),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
