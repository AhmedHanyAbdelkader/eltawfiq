import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

launchWhatsAppUri({required String whatsappNumber}) async {
  final link = WhatsAppUnilink(
    phoneNumber: whatsappNumber,
    text: "Hey! ",
  );
  //await launch(link.asUri().toString());
  await launchUrlString('$link');
}

String formatPhoneNumber(String phoneNumber) {
  // Add the country code
  String formattedNumber = '+20';
  // Remove any leading zeros
  phoneNumber = phoneNumber.replaceAll(RegExp(r'^0+'), '');
  // Add hyphen after country code
  formattedNumber += '-';
  // Insert hyphen after the third digit
  formattedNumber += phoneNumber.substring(0, 2);
  formattedNumber += phoneNumber.substring(2);
  return formattedNumber;
}

void launchEmailApp({
  required String toEmail,
  String? subject,
  String? body,
}) async {
  final emailLaunchUri = 'mailto:$toEmail?';
  final List<String> queryParams = [];

  if (subject != null) {
    queryParams.add('subject=${Uri.encodeComponent(subject)}');
  }

  if (body != null) {
    queryParams.add('body=${Uri.encodeComponent(body)}');
  }

  final String queryString = queryParams.join('&');
  final String uri = emailLaunchUri + queryString;

  try {
    await launch(uri);
  } catch (e) {
    if (kDebugMode) {
      print('Error launching email: $e');
    }
    throw 'Could not launch email';
  }
}

Future<void> launchMapUrl(String locationLink) async {
  final url = locationLink;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> launchFacebookUrl(fbUrl) async {
  try {
    if (!await launchUrl(Uri.parse(fbUrl), mode: LaunchMode.platformDefault)) {
      throw Exception('Could not launch');
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}


void makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    throw 'Could not launch $launchUri';
  }
}
