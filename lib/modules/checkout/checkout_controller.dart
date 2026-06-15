import 'package:flutter/material.dart';
import 'package:furniture_app/app/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../app/models/cart_item_model.dart';
import '../../app/models/shipping_address_model.dart';
import '../../app/utils/app_colors.dart';
import '../../app/widgets/checkout_widgets/shipping_sheet.dart';

class CheckoutController extends GetxController {
  final isLoading = false.obs;

  // ── Shipping Address ───────────────────────────────────────────────────────
  final selectedAddressId = '1'.obs;

  // ✅ sharedAddresses — same list jo ShippingAddressController use karta hai
  List<ShippingAddressModel> get addresses => sharedAddresses;

  // ✅ orElse — no element crash fix
  ShippingAddressModel get selectedAddress => addresses.firstWhere(
        (a) => a.id == selectedAddressId.value,
    orElse: () => addresses.first,
  );

  // ── Shipping Types ─────────────────────────────────────────────────────────
  final shippingTypes = <ShippingTypeModel>[
    const ShippingTypeModel(
      id: '1',
      name: 'Economy',
      estimatedArrival: '25 September 2023',
      price: 0.00,
    ),
    const ShippingTypeModel(
      id: '2',
      name: 'Standard',
      estimatedArrival: '20 September 2023',
      price: 10.00,
    ),
    const ShippingTypeModel(
      id: '3',
      name: 'Express',
      estimatedArrival: '17 September 2023',
      price: 25.00,
    ),
  ];
  final selectedShippingId = '1'.obs;

  ShippingTypeModel get selectedShipping => shippingTypes.firstWhere(
        (s) => s.id == selectedShippingId.value,
    orElse: () => shippingTypes.first,
  );

  // ── Order Items ────────────────────────────────────────────────────────────
  final orderItems = <CartItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is List<CartItemModel>) {
      orderItems.assignAll(args);
    } else {
      orderItems.assignAll([
        CartItemModel(
          id: '1', name: 'Arm Chair', category: 'Chair',
          unitPrice: 180.00,
          imagePath: 'https://static.vecteezy.com/system/resources/thumbnails/040/452/833/small/ai-generated-armchair-furniture-isolated-on-transparent-background-free-png.png',
        ),
        CartItemModel(
          id: '2', name: 'Sofa Chair', category: 'Chair',
          unitPrice: 120.00,
          imagePath: 'https://dehraflicks.com/wp-content/uploads/2025/12/scandinavian-chair-png.png',
        ),
        CartItemModel(
          id: '3', name: 'Wood Chair', category: 'Chair',
          unitPrice: 110.00,
          imagePath: 'https://static.vecteezy.com/system/resources/thumbnails/039/630/990/small/ai-generated-blue-leather-armchair-sofa-isolated-transparent-background-free-png.png',
        ),
      ]);
    }
  }

  // ✅ Shipping address screen pe navigate, result wapas lo
  Future<void> changeAddress() async {
    final result = await Get.toNamed(
      AppRoutes.shippingAddressScreen,
      arguments: selectedAddressId.value,
    );
    if (result != null && result is String) {
      selectedAddressId.value = result;
    }
  }

  // Shipping type bottom sheet
  void changeShipping() {
    Get.bottomSheet(
      ShippingSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void selectShipping(String id) {
    selectedShippingId.value = id;
    Get.back();
  }

  Future<void> continueToPayment() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
    Get.snackbar(
      'Proceeding to Payment',
      'Redirecting to payment gateway...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.appColor,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.payment_outlined, color: Colors.white),
    );
    Get.toNamed(AppRoutes.paymentScreen);

  }



  void goBack() => Get.back();
}