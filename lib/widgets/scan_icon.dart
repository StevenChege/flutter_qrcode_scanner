import 'package:flutter/material.dart';

class ScanIcons extends StatelessWidget {
  const ScanIcons({Key? key, required this.image}) : super(key: key);

  final String image;
  @override
  Widget build(BuildContext context) {
    return Image.asset(image, height: 30);
  }
}
