import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  void sendResetLink() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      isLoading.value = false;

      // TODO: Navigate to OTP / confirmation screen
      // Get.toNamed('/otp-verification');

      Get.snackbar(
        'Email Sent!',
        'Password reset link has been sent to ${emailController.text.trim()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF3B6B5E),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      );
    }
  }

  void goBack() => Get.back();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}