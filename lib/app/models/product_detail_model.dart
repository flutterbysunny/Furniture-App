import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ─── Product Detail Model ─────────────────────────────────────────────────────

class ProductDetailModel {
  final String id;
  final String category;
  final String name;
  final double price;
  final double rating;
  final String description;
  final List<String> imagePaths; // all gallery images
  final List<Color> availableColors;

  const ProductDetailModel({
    required this.id,
    required this.category,
    required this.name,
    required this.price,
    required this.rating,
    required this.description,
    required this.imagePaths,
    required this.availableColors,
  });
}