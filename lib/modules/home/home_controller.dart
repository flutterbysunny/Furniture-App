import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/app/utils/app_image.dart';
import 'package:get/get.dart';

import '../../app/models/banner_model.dart';
import '../../app/models/category_model.dart';
import '../../app/models/product_model.dart';

class HomeController extends GetxController {
  final currentBanner = 0.obs;
  final PageController bannerPageController = PageController();

  final hours = 2.obs;
  final minutes = 12.obs;
  final seconds = 56.obs;
  bool _timerRunning = true;

  final selectedFilter = 'Newest'.obs;
  final filters = ['All', 'Newest', 'Popular', 'Bedroom', 'Living'];

  final favoriteIds = <int>{}.obs;

  final banners =  [
    BannerModel(
      title: 'New Collection',
      subtitle: 'Discount 50% for\nthe first transaction',
      buttonText: 'Shop Now',
      bgColor: Color(0xffd1d1d1).withValues(alpha: 0.2),
      imagePath: 'https://static.vecteezy.com/system/resources/thumbnails/039/630/990/small/ai-generated-blue-leather-armchair-sofa-isolated-transparent-background-free-png.png',
    ),
    BannerModel(
      title: 'Summer Sale',
      subtitle: 'Up to 40% off\non selected items',
      buttonText: 'Explore',
      bgColor: Color(0xffd1d1d1).withValues(alpha: 0.2),
      imagePath: 'https://static.vecteezy.com/system/resources/thumbnails/039/652/230/small/ai-generated-soft-armchair-soft-chair-soft-sofa-stylish-armchair-luxurious-armchair-luxurious-chair-soft-armchair-transparent-background-png.png',
    ),
    BannerModel(
      title: 'Best Sellers',
      subtitle: 'Top picks\nof the season',
      buttonText: 'View All',
      bgColor: Color(0xffd1d1d1).withValues(alpha: 0.2),
      imagePath: 'https://freepngimg.com/download/aquarium/47383-2-sleeper-sofa-images-png-file-hd.png',
    ),
  ];

  final categories =  [
    CategoryModel(name: 'Sofa', image: AppImages.sofaIcon),
    CategoryModel(name: 'Chair', image: AppImages.chairIcon),
    CategoryModel(name: 'Lamp', image: AppImages.lampIcon),
    CategoryModel(name: 'Cupboard', image: AppImages.cupboardIcon),
    CategoryModel(name: 'Bed', image: AppImages.bedIcon),
    CategoryModel(name: 'Table', image: AppImages.tableIcon),
  ];

  final products = const [
    ProductModel(name: 'Wooden Armchair', price: 180.00, imagePath: 'https://static.vecteezy.com/system/resources/thumbnails/040/452/833/small/ai-generated-armchair-furniture-isolated-on-transparent-background-free-png.png'),
    ProductModel(name: 'Checkered Chair', price: 120.00, imagePath: 'https://dehraflicks.com/wp-content/uploads/2025/12/scandinavian-chair-png.png'),
    ProductModel(name: 'Modern Sofa', price: 340.00, imagePath: 'https://static.vecteezy.com/system/resources/thumbnails/034/629/711/small/chic-scandinavian-style-sofa-in-beige-with-clean-lines-and-plush-cushions-set-on-natural-wood-legs-couch-on-transparent-background-cut-out-furniture-front-view-ai-generated-png.png'),
    ProductModel(name: 'Floor Lamp', price: 89.00, imagePath: 'https://static.vecteezy.com/system/resources/previews/053/408/641/non_2x/floor-lamp-on-transparent-background-free-png.png'),
  ];

  @override
  void onInit() {
    super.onInit();
    _startTimer();
    _startBannerAutoScroll();
  }

  void _startTimer() async {
    while (_timerRunning) {
      await Future.delayed(const Duration(seconds: 1));
      if (!_timerRunning) break;
      if (seconds.value > 0) {
        seconds.value--;
      } else if (minutes.value > 0) {
        minutes.value--;
        seconds.value = 59;
      } else if (hours.value > 0) {
        hours.value--;
        minutes.value = 59;
        seconds.value = 59;
      }
    }
  }

  void _startBannerAutoScroll() async {
    while (_timerRunning) {
      await Future.delayed(const Duration(seconds: 3));
      if (!_timerRunning || !bannerPageController.hasClients) continue;
      final next = (currentBanner.value + 1) % banners.length;
      bannerPageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void onBannerChanged(int index) => currentBanner.value = index;

  void toggleFavorite(int index) {
    if (favoriteIds.contains(index)) {
      favoriteIds.remove(index);
    } else {
      favoriteIds.add(index);
    }
  }

  void onLocationTap() => Get.toNamed('/location');
  void onNotificationTap() {}
  void onFilterTap() {}
  void onCategoryTap(int index) {}
  void onProductTap(int index) {
    Get.toNamed('/product_details_screen', arguments: products[index]);
  }
  void onSeeAllCategories() {}
  void onSeeAllFlashSale() {}

  @override
  void onClose() {
    _timerRunning = false;
    bannerPageController.dispose();
    super.onClose();
  }
}