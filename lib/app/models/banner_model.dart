import 'package:flutter/cupertino.dart';

class BannerModel {
  final String title;
  final String subtitle;
  final String buttonText;
  final Color bgColor;
  final String imagePath;

  const BannerModel({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.bgColor,
    required this.imagePath,
  });
}
