import 'package:get/get.dart';

// ─── Cart Item Model ──────────────────────────────────────────────────────────

class CartItemModel {
  final String id;
  final String name;
  final String category;
  final double unitPrice;
  final String imagePath;
  final RxInt quantity;

  CartItemModel({
    required this.id,
    required this.name,
    required this.category,
    required this.unitPrice,
    required this.imagePath,
    int initialQty = 1,
  }) : quantity = initialQty.obs;

  double get totalPrice => unitPrice * quantity.value;
}