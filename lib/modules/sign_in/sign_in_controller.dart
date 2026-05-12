import 'package:flutter/cupertino.dart';
import 'package:furniture_app/app/routes/app_routes.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  void signIn() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      isLoading.value = false;
      Get.offNamed(AppRoutes.profileScreen);
      // TODO: Navigate or show success
    }
  }

  void forgotPassword() {
    Get.toNamed(AppRoutes.forgotPasswordScreen);
    // TODO: Navigate to Forgot Password screen
  }

  void signInWithApple() {}
  void signInWithGoogle() {}
  void signInWithFacebook() {}

  void goToSignUp() {
    Get.offNamed(AppRoutes.signUpScreen);
    // TODO: Navigate to Sign Up screen
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}