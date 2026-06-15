import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/models/shipping_address_model.dart';
import '../../app/utils/app_colors.dart';

class ShippingAddressController extends GetxController {
  // Temp selection — apply tappone se checkout me jaayega
  final tempSelectedId = ''.obs;

  final addresses = <ShippingAddressModel>[
    const ShippingAddressModel(
      id: '1',
      label: 'Home',
      fullAddress: '1901 Thornridge Cir. Shiloh, Hawaii 81063',
    ),
    const ShippingAddressModel(
      id: '2',
      label: 'Office',
      fullAddress: '4517 Washington Ave. Manchester, Kentucky 39495',
    ),
    const ShippingAddressModel(
      id: '3',
      label: "Parent's House",
      fullAddress: '8502 Preston Rd. Inglewood, Maine 98380',
    ),
    const ShippingAddressModel(
      id: '4',
      label: "Friend's House",
      fullAddress: '2464 Royal Ln. Mesa, New Jersey 45463',
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Get current selected id passed from CheckoutController
    final args = Get.arguments;
    if (args is String) {
      tempSelectedId.value = args;
    } else {
      tempSelectedId.value = addresses.first.id;
    }
  }

  void selectAddress(String id) => tempSelectedId.value = id;

  void applyAddress() {
    // Return selected id back to Checkout screen
    Get.back(result: tempSelectedId.value);
  }

  void addNewAddress() {
    // TODO: Navigate to Add New Address form
    Get.snackbar(
      'Coming Soon',
      'Add New Address feature is coming soon.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.appColor,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void goBack() => Get.back();
}