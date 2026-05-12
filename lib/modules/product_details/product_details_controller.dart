import 'package:flutter/material.dart';
import 'package:furniture_app/app/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../app/models/product_model.dart';
import '../../app/utils/app_colors.dart';

class ProductDetailController extends GetxController {
  late ProductModel product;

  final selectedImageIndex = 0.obs;
  final selectedColorIndex = 0.obs;
  final isExpanded = false.obs;
  final isFavorite = false.obs;
  final isAddingToCart = false.obs;
  final galleryImages = <String>[].obs;

  // ── 360° Mode ─────────────────────────────────────────────────────────────
  final is360Mode = false.obs;
  final frames360 = <String>[].obs;

  // ── Color options ──────────────────────────────────────────────────────────
  final colorNames = ['Teal', 'Black', 'Brown', 'Purple', 'Olive'];
  final colors = const [
    Color(0xFF3B6B5E),
    Color(0xFF1A1A1A),
    Color(0xFF7B3F3F),
    Color(0xFF6A5ACD),
    Color(0xFF556B2F),
  ];

  static const int maxVisibleThumbnails = 5;

  // ── Currently selected color (reactive) ───────────────────────────────────
  Color get selectedColor => colors[selectedColorIndex.value];
  String get selectedColorName => colorNames[selectedColorIndex.value];

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args is ProductModel) {
      product = args;
    } else {
      product = const ProductModel(
        name: 'Modern Sofa Chair',
        price: 120.00,
        imagePath:
        'https://dehraflicks.com/wp-content/uploads/2025/12/scandinavian-chair-png.png',
      );
    }

    // Gallery images — real app mein alag alag angles ki images hongi
    galleryImages.assignAll(List.generate(6, (_) => product.imagePath));

    // ── 360° Frames ──────────────────────────────────────────────────────────
    // Real app mein: backend se 36 alag angle URLs aayenge
    // e.g. https://cdn.example.com/chair/frame_00.png ... frame_35.png
    //
    // Demo ke liye same image 36 baar use kar rahe hain.
    // Aap apne backend ke actual 36 angle URLs yahan replace karo:
    frames360.assignAll(_buildFrameUrls(product.imagePath));
  }

  /// ── Real app mein is function ko replace karna ──
  /// Yahan actual 36 frame URLs return karo.
  /// e.g. List.generate(36, (i) => 'https://cdn.example.com/chair/frame_${i.toString().padLeft(2,'0')}.png')
  List<String> _buildFrameUrls(String baseImagePath) {
    return List.generate(36, (_) => baseImagePath);
  }

  int get extraImageCount {
    final extra = galleryImages.length - maxVisibleThumbnails;
    return extra > 0 ? extra : 0;
  }

  // ── Actions ───────────────────────────────────────────────────────────────
  void onThumbnailTap(int index) {
    // 360° mode mein thumbnails kaam nahi karte
    if (is360Mode.value) return;
    selectedImageIndex.value = index;
  }

  void onColorSelect(int index) => selectedColorIndex.value = index;
  void toggleExpanded() => isExpanded.value = !isExpanded.value;
  void toggleFavorite() => isFavorite.value = !isFavorite.value;
  void goBack() => Get.back();

  void toggle360Mode() {
    is360Mode.value = !is360Mode.value;
    // 360° mode se bahar aate waqt pehla thumbnail select karo
    if (!is360Mode.value) {
      selectedImageIndex.value = 0;
    }
  }

  Future<void> addToCart() async {
    isAddingToCart.value = true;

    await Future.delayed(const Duration(milliseconds: 800));

    isAddingToCart.value = false;

    Get.snackbar(
      'Added to Cart!',
      '${product.name} has been added to your cart.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.appColor,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
      duration: const Duration(seconds: 2),
    );

    // 👇 Snackbar ke baad delay deke redirect
    Future.delayed(const Duration(seconds: 2), () {
      Get.toNamed(AppRoutes.myCartScreen); // apna cart page yaha daalo
    });
  }
}