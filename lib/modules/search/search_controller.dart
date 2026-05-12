import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../app/models/product_model.dart';
import '../../app/models/search_product_model.dart';

class ProductSearchController extends GetxController {
  final searchController = TextEditingController();
  final searchFocus = FocusNode();

  final searchQuery = ''.obs;
  final isSearching = false.obs;
  final hasSearched = false.obs;

  // Recent data (stored locally — replace with SharedPreferences for persistence)
  final recentSearches = <String>[].obs;
  final recentViews = <SearchProductModel>[].obs;

  // Wishlist toggle
  final wishlistIds = <String>{}.obs;

  // All dummy products (replace with API)
  final _allProducts = [
    const SearchProductModel(
      id: '1', name: 'Arm Chair', category: 'Chair',
      price: 180.00, rating: 4.9,
      imagePath: 'https://static.vecteezy.com/system/resources/thumbnails/040/452/833/small/ai-generated-armchair-furniture-isolated-on-transparent-background-free-png.png',
    ),
    const SearchProductModel(
      id: '2', name: 'Sofa Chair', category: 'Chair',
      price: 120.00, rating: 5.0,
      imagePath: 'https://dehraflicks.com/wp-content/uploads/2025/12/scandinavian-chair-png.png',
    ),
    const SearchProductModel(
      id: '3', name: 'Wood Chair', category: 'Chair',
      price: 110.00, rating: 4.9,
      imagePath: 'https://static.vecteezy.com/system/resources/thumbnails/039/630/990/small/ai-generated-blue-leather-armchair-sofa-isolated-transparent-background-free-png.png',
    ),
    const SearchProductModel(
      id: '4', name: 'Grey Chair', category: 'Chair',
      price: 200.00, rating: 5.0,
      imagePath: 'https://static.vecteezy.com/system/resources/thumbnails/039/652/230/small/ai-generated-soft-armchair-soft-chair-soft-sofa-stylish-armchair-luxurious-armchair-luxurious-chair-soft-armchair-transparent-background-png.png',
    ),
    const SearchProductModel(
      id: '5', name: 'Modern Sofa', category: 'Sofa',
      price: 340.00, rating: 4.7,
      imagePath: 'https://static.vecteezy.com/system/resources/thumbnails/034/629/711/small/chic-scandinavian-style-sofa-in-beige-with-clean-lines-and-plush-cushions-set-on-natural-wood-legs-couch-on-transparent-background-cut-out-furniture-front-view-ai-generated-png.png',
    ),
    const SearchProductModel(
      id: '6', name: 'Sofa Chair', category: 'Chair',
      price: 180.00, rating: 4.9,
      imagePath: 'https://static.vecteezy.com/system/resources/thumbnails/039/652/230/small/ai-generated-soft-armchair-soft-chair-soft-sofa-stylish-armchair-luxurious-armchair-luxurious-chair-soft-armchair-transparent-background-png.png',
    ),
    const SearchProductModel(
      id: '7', name: 'Wood Chair', category: 'Chair',
      price: 130.00, rating: 5.0,
      imagePath: 'https://static.vecteezy.com/system/resources/thumbnails/039/630/990/small/ai-generated-blue-leather-armchair-sofa-isolated-transparent-background-free-png.png',
    ),
    const SearchProductModel(
      id: '8', name: 'Floor Lamp', category: 'Lamp',
      price: 89.00, rating: 4.5,
      imagePath: 'https://static.vecteezy.com/system/resources/previews/053/408/641/non_2x/floor-lamp-on-transparent-background-free-png.png',
    ),
    const SearchProductModel(
      id: '9', name: 'Vintage Sofa', category: 'Sofa',
      price: 420.00, rating: 4.8,
      imagePath: 'https://freepngimg.com/download/aquarium/47383-2-sleeper-sofa-images-png-file-hd.png',
    ),
  ];

  final searchResults = <SearchProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Pre-load some recent searches for demo
    recentSearches.assignAll(['Sofa  Chair', 'Arm Chair', 'Wood Chair']);
    recentViews.assignAll([
      _allProducts[0], _allProducts[1], _allProducts[2], _allProducts[3],
    ]);

    Future.delayed(const Duration(milliseconds: 300), () {
      searchFocus.requestFocus();
    });
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    if (query.trim().isEmpty) {
      hasSearched.value = false;
      searchResults.clear();
    }
  }

  void onSearchSubmit(String query) async {
    final q = query.trim();
    if (q.isEmpty) return;

    isSearching.value = true;
    await Future.delayed(const Duration(milliseconds: 500)); // simulate API

    // Filter products
    final results = _allProducts
        .where((p) =>
    p.name.toLowerCase().contains(q.toLowerCase()) ||
        p.category.toLowerCase().contains(q.toLowerCase()))
        .toList();

    searchResults.assignAll(results);
    hasSearched.value = true;
    isSearching.value = false;

    // Save to recent searches
    _addToRecentSearch(q);
  }

  void _addToRecentSearch(String query) {
    recentSearches.remove(query); // avoid duplicates
    recentSearches.insert(0, query);
    if (recentSearches.length > 5) recentSearches.removeLast();
  }

  void onRecentSearchTap(String query) {
    searchController.text = query;
    searchQuery.value = query;
    onSearchSubmit(query);
  }

  void removeRecentSearch(String query) {
    recentSearches.remove(query);
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    hasSearched.value = false;
    searchResults.clear();
    searchFocus.requestFocus();
  }

  void toggleWishlist(String id) {
    if (wishlistIds.contains(id)) {
      wishlistIds.remove(id);
    } else {
      wishlistIds.add(id);
    }
  }

  void onProductTap(SearchProductModel product) {
    // Add to recent views
    recentViews.removeWhere((e) => e.id == product.id);
    recentViews.insert(0, product);
    if (recentViews.length > 6) recentViews.removeLast();

    // Navigate to product detail
    final p = ProductModel(
      name: product.name,
      price: product.price,
      imagePath: product.imagePath,
    );
    Get.toNamed('/product_details_screen', arguments: p);
  }

  void goBack() => Get.back();

  @override
  void onClose() {
    searchController.dispose();
    searchFocus.dispose();
    super.onClose();
  }
}