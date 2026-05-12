
import 'package:flutter/material.dart';
import 'package:furniture_app/modules/search/search_controller.dart';
import 'package:get/get.dart';

import '../../app/models/search_product_model.dart';
import '../../app/utils/app_colors.dart';

class SearchView extends GetView<ProductSearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            _buildSearchBar(),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.isSearching.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF3B6B5E),
                      strokeWidth: 2.5,
                    ),
                  );
                }
                if (controller.hasSearched.value) {
                  return _buildSearchResults();
                }
                return _buildRecentSection();
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ── Search Bar ──────────────────────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: controller.goBack,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFEEEEEE), width: 1.5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2))
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 16, color: Colors.black87),
            ),
          ),

          const SizedBox(width: 12),

          // Search input
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F2F2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 14),
                  const Icon(Icons.search_rounded, color: Colors.grey, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: controller.searchController,
                      focusNode: controller.searchFocus,
                      onChanged: controller.onSearchChanged,
                      onSubmitted: controller.onSearchSubmit,
                      textInputAction: TextInputAction.search,
                      decoration: const InputDecoration(
                        hintText: 'Search..',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 13),
                      ),
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),

                  // Clear X button
                  Obx(() => controller.searchQuery.value.isNotEmpty
                      ? GestureDetector(
                    onTap: controller.clearSearch,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.grey.shade400, width: 1.5),
                      ),
                      child: Icon(Icons.close,
                          size: 13, color: Colors.grey.shade500),
                    ),
                  )
                      : const SizedBox(width: 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Recent Section (before search) ─────────────────────────────────────────

  Widget _buildRecentSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Searches
          Obx(() => controller.recentSearches.isEmpty
              ? const SizedBox()
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Recent Search',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 12),
              ...controller.recentSearches.map(
                    (query) => _RecentSearchTile(query: query),
              ),
            ],
          )),

          const SizedBox(height: 20),

          // Recent Views
          Obx(() => controller.recentViews.isEmpty
              ? const SizedBox()
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Recent View',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 12),
              ...controller.recentViews.map(
                    (product) => _RecentViewTile(product: product),
              ),
            ],
          )),
        ],
      ),
    );
  }

  // ── Search Results ──────────────────────────────────────────────────────────

  Widget _buildSearchResults() {
    return Obx(() {
      final results = controller.searchResults;
      final query = controller.searchQuery.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Results for "$query"',
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  '${results.length * 17} Results Found',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColors.appColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Grid
          Expanded(
            child: results.isEmpty
                ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off_rounded,
                      size: 64, color: Color(0xFFCCCCCC)),
                  SizedBox(height: 12),
                  Text('No results found',
                      style:
                      TextStyle(fontSize: 15, color: Colors.grey)),
                ],
              ),
            )
                : GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: results.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (_, i) =>
                  _ProductCard(product: results[i]),
            ),
          ),
        ],
      );
    });
  }
}

// ─── Recent Search Tile ───────────────────────────────────────────────────────

class _RecentSearchTile extends GetView<ProductSearchController> {
  final String query;

  const _RecentSearchTile({required this.query});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.onRecentSearchTap(query),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(query,
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ),
            GestureDetector(
              onTap: () => controller.removeRecentSearch(query),
              child: const Icon(Icons.close, size: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Recent View Tile ─────────────────────────────────────────────────────────

class _RecentViewTile extends GetView<ProductSearchController> {
  final SearchProductModel product;

  const _RecentViewTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => controller.onProductTap(product),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                // Image
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F2F2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(product.imagePath,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(Icons.chair,
                            size: 36, color: Color(0xFFAAAAAA))),
                  ),
                ),
                const SizedBox(width: 14),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      const SizedBox(height: 3),
                      Text(product.category,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                      const SizedBox(height: 5),
                      Text('\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 1, color: Color(0xFFF0F0F0)),
      ],
    );
  }
}

// ─── Product Card (Search Results Grid) ──────────────────────────────────────

class _ProductCard extends GetView<ProductSearchController> {
  final SearchProductModel product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onProductTap(product),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                // Image
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F2F2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      product.imagePath,
                      fit: BoxFit.contain,
                      loadingBuilder: (_, child, prog) {
                        if (prog == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(
                              color: Color(0xFF3B6B5E), strokeWidth: 2),
                        );
                      },
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(Icons.chair,
                            size: 60, color: Color(0xFFCCCCCC)),
                      ),
                    ),
                  ),
                ),

                // Wishlist heart
                Positioned(
                  top: 10,
                  right: 10,
                  child: Obx(() {
                    final isWished =
                    controller.wishlistIds.contains(product.id);
                    return GestureDetector(
                      onTap: () => controller.toggleWishlist(product.id),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: isWished
                              ? AppColors.appColor
                              : AppColors.appColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.appColor.withOpacity(0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 2))
                          ],
                        ),
                        child: Icon(
                          isWished ? Icons.favorite : Icons.favorite,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Name + Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  product.name,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star_rounded,
                      color: Colors.orange, size: 14),
                  const SizedBox(width: 2),
                  Text(product.rating.toStringAsFixed(1),
                      style: const TextStyle(
                          fontSize: 12, color: Colors.black54)),
                ],
              ),
            ],
          ),

          const SizedBox(height: 2),

          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),

          const SizedBox(height: 4),
        ],
      ),
    );
  }
}