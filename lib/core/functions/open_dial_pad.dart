import 'package:url_launcher/url_launcher.dart';

openDialPad({String? phoneNumber= ""}) async {
  Uri url = Uri(scheme: "tel", path: phoneNumber);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    print("Can't open dial pad.");
  }
}