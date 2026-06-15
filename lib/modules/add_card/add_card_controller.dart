import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/models/card_model.dart';

class AddCardController extends GetxController {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final saveCard = true.obs;
  final isLoading = false.obs;

  // Live preview
  final previewName = 'Card Holder Name'.obs;
  final previewNumber = '0000 0000 0000 0000'.obs;
  final previewExpiry = 'MM/YY'.obs;

  void onNameChanged(String v) =>
      previewName.value = v.isEmpty ? 'Card Holder Name' : v;

  void onNumberChanged(String v) {
    final clean = v.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < clean.length && i < 16; i++) {
      if (i != 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(clean[i]);
    }
    final formatted = buffer.toString();
    previewNumber.value =
    formatted.isEmpty ? '0000 0000 0000 0000' : formatted.padRight(19, ' ').trimRight();
  }

  void onExpiryChanged(String v) =>
      previewExpiry.value = v.isEmpty ? 'MM/YY' : v;

  Future<void> addCard() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 800));
    isLoading.value = false;

    final card = CardModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      holderName: nameController.text.trim(),
      cardNumber: numberController.text.trim(),
      expiryDate: expiryController.text.trim(),
      cvv: cvvController.text.trim(),
    );

    Get.back(result: card);
  }

  void goBack() => Get.back();

  @override
  void onClose() {
    nameController.dispose();
    numberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.onClose();
  }
}