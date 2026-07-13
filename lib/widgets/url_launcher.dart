import 'package:url_launcher/url_launcher.dart';

launchUrlCustom(String webSite) async {
  String url = webSite;
  if (await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}
void launchWhatsApp({required String phone, required String message}) async {
  final Uri url = Uri.parse("https://wa.me/$phone?text=${Uri.encodeComponent(message)}");

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}


Future<void> openGoogleMaps(dynamic latitude,dynamic longitude) async {

  // Google Maps URL schemes
  final String url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

  // Alternative simpler version:
  // final String url = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';

  final Uri uri = Uri.parse(url);

  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    print('Error opening Google Maps: $e');
    // Fallback: Open in browser
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
  }
}