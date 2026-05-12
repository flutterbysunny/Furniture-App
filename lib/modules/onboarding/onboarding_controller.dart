import 'package:flutter/material.dart';
import 'package:furniture_app/app/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../app/models/onboarding_model.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingModel> pages = [
    OnboardingModel(
      title: 'Seamless Shopping',
      titleColored: '',
      titleEnd: 'Experience',
      description:
      'Discover thousands of premium furniture pieces curated for your dream home, all in one place.',
      screenIndex: 0,
    ),
    OnboardingModel(
      title: 'Find Your Perfect',
      titleColored: 'Home Style',
      titleEnd: '',
      description:
      'Browse by category, filter by style and budget. Your perfect furniture match is just a tap away.',
      screenIndex: 1,
    ),
    OnboardingModel(
      title: 'Wishlist: Where Your',
      titleColored: "Home's Dreams",
      titleEnd: 'Begin',
      description:
      'Save your favourite pieces to your wishlist and revisit them whenever you are ready to buy.',
      screenIndex: 2,
    ),
  ];

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to home or login
      Get.offAllNamed(AppRoutes.welcomeScreen);
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipOnboarding() {
    Get.offAllNamed(AppRoutes.dashboard);
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}