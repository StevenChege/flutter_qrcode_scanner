import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

const double kDefaultPadding = 50.0;

const Duration kSnackBarDuration = Duration(seconds: 7);

const Color kTextColor = Color.fromARGB(255, 66, 66, 66);

const Color kBlue = Color(0xFFD9FFFC);

const Color overlayColor = Color.fromARGB(115, 16, 26, 31);

const String torchImage = 'assets/lampy.png';

const String offTorchImage = 'assets/lamp_off.png';

const String galleryImage = 'assets/gallery.png';

const String cameraImage = 'assets/switch-camera.png';

const String downloadImage = 'assets/download.png';

const String launchUrlImage = 'assets/launch.png';

const String copyUrlImage = 'assets/copy.png';

final OutlineInputBorder kDefaultOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: kTextColor,
    width: .8,
  ),
);

void launchURL(String _url) async {
  final Uri _uri = Uri.parse('https:$_url');

  await canLaunchUrl(_uri)
      ? await launchUrl(_uri, mode: LaunchMode.externalApplication)
      : throw Get.snackbar(_uri.toString(),
          '🤖 Could not launch $_url, enter a valid url format',
          duration: kSnackBarDuration);
}
