import 'package:flutter/animation.dart';
import 'package:furniture_app/app/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animController;

  // Logo circle scale
  late Animation<double> scaleAnim;
  // Logo circle fade
  late Animation<double> fadeAnim;
  // Text slide from right
  late Animation<Offset> textSlideAnim;
  // Text fade
  late Animation<double> textFadeAnim;
  // Decorative circles fade
  late Animation<double> bgCircleFadeAnim;

  @override
  void onInit() {
    super.onInit();
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    bgCircleFadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animController,
        curve: const Interval(0.2, 0.65, curve: Curves.elasticOut),
      ),
    );

    fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animController,
        curve: const Interval(0.2, 0.5, curve: Curves.easeIn),
      ),
    );

    textSlideAnim =
        Tween<Offset>(begin: const Offset(0.4, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: animController,
            curve: const Interval(0.55, 0.9, curve: Curves.easeOutCubic),
          ),
        );

    textFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animController,
        curve: const Interval(0.55, 0.9, curve: Curves.easeIn),
      ),
    );

    animController.forward();

    // Navigate after animation + small delay
    Future.delayed(const Duration(milliseconds: 2800), () {
      Get.toNamed(AppRoutes.onboardingScreen);
      // Get.offNamed('/home'); // ← uncomment & replace with your route
    });
  }

  @override
  void onClose() {
    animController.dispose();
    super.onClose();
  }
}