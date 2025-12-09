import 'package:url_launcher/url_launcher.dart';

class EmailService {
  static Future<void> sendEmail({
    required String subject,
    required String message,
  }) async {
    final gmailUrl = Uri.parse(
        "https://mail.google.com/mail/?view=cm"
            "&to=distribucio@veusddd.es"
            "&su=$subject"
            "&body=$message"
    );

    await launchUrl(gmailUrl, mode: LaunchMode.externalApplication);

  }
}
