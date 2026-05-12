import 'package:flutter/widgets.dart';

class CategoryModel {
  final String name;
  final String image; // 🔥 change from IconData to String

  const CategoryModel({
    required this.name,
    required this.image,
  });
}