import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/models/product_model.dart';
import '../../app/models/wishlist_model.dart';

class WishlistController extends GetxController {
  final selectedCategory = 'All'.obs;

  final categories = ['All', 'Chair', 'Sofa', 'Lamp', 'Cupboard', 'Bed', 'Table'].obs;

  final filteredItems = <WishlistItemModel>[].obs;

  final wishlistItems = <WishlistItemModel>[
    const WishlistItemModel(
      id: '1',
      name: 'Arm Chair',
      category: 'Chair',
      price: 180.00,
      rating: 4.9,
      imagePath:
      'https://static.vecteezy.com/system/resources/thumbnails/040/452/833/small/ai-generated-armchair-furniture-isolated-on-transparent-background-free-png.png',
    ),
    const WishlistItemModel(
      id: '2',
      name: 'Sofa Chair',
      category: 'Chair',
      price: 120.00,
      rating: 5.0,
      imagePath:
      'https://dehraflicks.com/wp-content/uploads/2025/12/scandinavian-chair-png.png',
    ),
    const WishlistItemModel(
      id: '3',
      name: 'Wood Chair',
      category: 'Chair',
      price: 110.00,
      rating: 4.9,
      imagePath:
      'https://static.vecteezy.com/system/resources/thumbnails/039/630/990/small/ai-generated-blue-leather-armchair-sofa-isolated-transparent-background-free-png.png',
    ),
    const WishlistItemModel(
      id: '4',
      name: 'Grey Chair',
      category: 'Chair',
      price: 200.00,
      rating: 5.0,
      imagePath:
      'https://static.vecteezy.com/system/resources/thumbnails/039/652/230/small/ai-generated-soft-armchair-soft-chair-soft-sofa-stylish-armchair-luxurious-armchair-luxurious-chair-soft-armchair-transparent-background-png.png',
    ),
    const WishlistItemModel(
      id: '5',
      name: 'Modern Sofa',
      category: 'Sofa',
      price: 180.00,
      rating: 4.7,
      imagePath:
      'https://static.vecteezy.com/system/resources/thumbnails/034/629/711/small/chic-scandinavian-style-sofa-in-beige-with-clean-lines-and-plush-cushions-set-on-natural-wood-legs-couch-on-transparent-background-cut-out-furniture-front-view-ai-generated-png.png',
    ),
    const WishlistItemModel(
      id: '6',
      name: 'Vintage Chair',
      category: 'Chair',
      price: 130.00,
      rating: 4.6,
      imagePath:
      'https://freepngimg.com/download/aquarium/47383-2-sleeper-sofa-images-png-file-hd.png',
    ),
    const WishlistItemModel(
      id: '7',
      name: 'Floor Lamp',
      category: 'Lamp',
      price: 89.00,
      rating: 4.5,
      imagePath:
      'https://static.vecteezy.com/system/resources/previews/053/408/641/non_2x/floor-lamp-on-transparent-background-free-png.png',
    ),
    const WishlistItemModel(
      id: '8',
      name: 'Oak Cupboard',
      category: 'Cupboard',
      price: 350.00,
      rating: 4.8,
      imagePath:
      'https://static.vecteezy.com/system/resources/thumbnails/040/452/833/small/ai-generated-armchair-furniture-isolated-on-transparent-background-free-png.png',
    ),
    const WishlistItemModel(
      id: '9',
      name: 'Oak Table',
      category: 'Table',
      price: 350.00,
      rating: 4.8,
      imagePath:
      'https://static.vecteezy.com/system/resources/thumbnails/050/704/742/small/modern-round-table-isolated-on-transparent-background-png.png',
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    filteredItems.assignAll(wishlistItems); // initially all items

    // ✅ Jab bhi selectedCategory ya wishlistItems change ho — auto update
    ever(selectedCategory, (_) => _applyFilter());
    ever(wishlistItems, (_) => _applyFilter());
  }

  void _applyFilter() {
    if (selectedCategory.value == 'All') {
      filteredItems.assignAll(wishlistItems);
    } else {
      filteredItems.assignAll(
        wishlistItems.where((item) => item.category == selectedCategory.value),
      );
    }
  }

  // Reactive filtered list
  // List<WishlistItemModel> get filteredItems {
  //   if (selectedCategory.value == 'All') return wishlistItems;
  //   return wishlistItems
  //       .where((item) => item.category == selectedCategory.value)
  //       .toList();
  // }

  void selectCategory(String cat) => selectedCategory.value = cat;

  void removeFromWishlist(WishlistItemModel item) {
    wishlistItems.removeWhere((e) => e.id == item.id);
    Get.snackbar(
      'Removed',
      '${item.name} removed from wishlist.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void onProductTap(WishlistItemModel item) {
    final product = ProductModel(
      name: item.name,
      price: item.price,
      imagePath: item.imagePath,
    );
    Get.toNamed('/product_details_screen', arguments: product);
  }

  void goBack() => Get.back();
}