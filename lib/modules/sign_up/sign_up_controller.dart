import 'package:flutter/material.dart';
import 'package:furniture_app/app/routes/app_routes.dart';
import 'package:get/get.dart';

// ─── Controller ───────────────────────────────────────────────────────────────

class SignUpController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isAgreed = false.obs;

  void signUp() async {
    if (!isAgreed.value) {
      Get.snackbar(
        'Terms & Conditions',
        'Please agree to the Terms & Conditions to continue.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      isLoading.value = false;
      Get.offNamed(AppRoutes.profileScreen);
      // TODO: Navigate or show success
    }
  }

  void onTermsTap() {
    // TODO: Navigate to Terms & Conditions screen
  }

  void signUpWithApple() {}
  void signUpWithGoogle() {}
  void signUpWithFacebook() {}

  void goToSignIn() {
    Get.offNamed(AppRoutes.signInScreen);
    // or: Get.toNamed('/sign-in');
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
