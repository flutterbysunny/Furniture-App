import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/models/cart_item_model.dart';
import '../../app/utils/app_colors.dart';
import '../../app/widgets/remove_from_cartSheet.dart';

class MyCartController extends GetxController {
  final promoController = TextEditingController();
  final promoApplied = false.obs;
  final promoDiscount = 35.0.obs;
  final deliveryFee = 25.0;

  final cartItems = <CartItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Dummy data — replace with actual cart data from your store/API
    cartItems.assignAll([
      CartItemModel(
        id: '1',
        name: 'Arm Chair',
        category: 'Chair',
        unitPrice: 180.00,
        imagePath:
        'https://static.vecteezy.com/system/resources/thumbnails/040/452/833/small/ai-generated-armchair-furniture-isolated-on-transparent-background-free-png.png',
      ),
      CartItemModel(
        id: '2',
        name: 'Sofa Chair',
        category: 'Chair',
        unitPrice: 120.00,
        imagePath:
        'https://dehraflicks.com/wp-content/uploads/2025/12/scandinavian-chair-png.png',
      ),
      CartItemModel(
        id: '3',
        name: 'Wood Chair',
        category: 'Chair',
        unitPrice: 110.00,
        imagePath:
        'https://static.vecteezy.com/system/resources/thumbnails/039/630/990/small/ai-generated-blue-leather-armchair-sofa-isolated-transparent-background-free-png.png',
      ),
      CartItemModel(
        id: '4',
        name: 'Grey Chair',
        category: 'Chair',
        unitPrice: 95.00,
        imagePath:
        'https://static.vecteezy.com/system/resources/thumbnails/039/652/230/small/ai-generated-soft-armchair-soft-chair-soft-sofa-stylish-armchair-luxurious-armchair-luxurious-chair-soft-armchair-transparent-background-png.png',
      ),
    ]);
  }

  // ── Quantity ──────────────────────────────────────────────────────────────

  void increment(CartItemModel item) {
    item.quantity.value++;
    cartItems.refresh(); // trigger subtotal recalculation
  }

  void decrement(CartItemModel item) {
    if (item.quantity.value > 1) {
      item.quantity.value--;
      cartItems.refresh();
    } else {
      confirmDelete(item);
    }
  }

  // ── Delete ────────────────────────────────────────────────────────────────

  void deleteItem(CartItemModel item) {
    cartItems.removeWhere((e) => e.id == item.id);
  }

  void confirmDelete(CartItemModel item) {
    Get.bottomSheet(
      RemoveFromCartSheet(item: item),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  // ── Promo Code ────────────────────────────────────────────────────────────

  void applyPromo() {
    final code = promoController.text.trim().toUpperCase();
    if (code == 'SAVE35') {
      promoApplied.value = true;
      promoDiscount.value = 35.0;
      Get.snackbar('Promo Applied!', 'You saved \$35.00',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.appColor,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12);
    } else if (code.isEmpty) {
      Get.snackbar('Enter Code', 'Please enter a promo code.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12);
    } else {
      promoApplied.value = false;
      promoDiscount.value = 0;
      Get.snackbar('Invalid Code', 'Promo code is not valid.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12);
    }
  }

  // ── Price Calculations ────────────────────────────────────────────────────

  double get subTotal =>
      cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get discount => promoApplied.value ? promoDiscount.value : 0.0;

  double get totalCost => subTotal + deliveryFee - discount;

  // ── Checkout ──────────────────────────────────────────────────────────────

  void proceedToCheckout() {
    if (cartItems.isEmpty) {
      Get.snackbar('Cart Empty', 'Please add items to cart first.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12);
      return;
    }
    // TODO: Get.toNamed('/checkout');
  }

  void goBack() => Get.back();

  @override
  void onClose() {
    promoController.dispose();
    super.onClose();
  }
}