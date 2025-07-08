import 'package:url_launcher/url_launcher.dart';

class WhatsApp {
  static void openWhatsApp(String phoneNumber , String message) async {
  final Uri url = Uri.parse("https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch WhatsApp';
  }
}

}