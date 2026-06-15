import 'package:flutter/material.dart';
import 'package:furniture_app/app/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../app/models/card_model.dart';
import '../../app/utils/app_colors.dart';

class PaymentController extends GetxController {
  // 'cash' | 'paypal' | 'apple_pay' | 'google_pay' | card id
  final selectedMethodId = 'cash'.obs;
  final isLoading = false.obs;

  final savedCards = <CardModel>[].obs;

  void selectMethod(String id) => selectedMethodId.value = id;

  void goToAddCard() async {
    final result = await Get.toNamed(AppRoutes.cardScreen);
    if (result != null && result is CardModel) {
      savedCards.add(result);
      selectedMethodId.value = result.id;
    }
  }

  Future<void> confirmPayment() async {
    if (selectedMethodId.value.isEmpty) {
      Get.snackbar('Select Payment', 'Please select a payment method.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12);
      return;
    }
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
    // TODO: Get.toNamed('/order-success');
    Get.snackbar('Payment Confirmed!', 'Your order has been placed.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.appColor,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.check_circle_outline, color: Colors.white));
  }

  void goBack() => Get.back();
}