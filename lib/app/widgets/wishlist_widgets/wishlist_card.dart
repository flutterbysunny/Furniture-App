import 'package:flutter/material.dart';
import 'package:furniture_app/app/utils/app_image.dart';
import 'package:get/get.dart';

import '../../../modules/my_wishlist/my_wishlist_controller.dart';
import '../../models/wishlist_model.dart';
import '../../utils/app_colors.dart';

class WishlistCard extends GetView<WishlistController> {
  final WishlistItemModel item;

  const WishlistCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onProductTap(item),
      child: ClipRRect(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImageBox(context),
            SizedBox(height: 16,),
            buildNameAndRating(),
            SizedBox(height: 2,),
            buildPrice(),
            SizedBox(height: 4,)

          ],
        ),
      ),
    );
  }

  // ── Image Box ──────────────────────────────────────────────────────────────

  Widget buildImageBox(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          buildProductImage(),
          buildHeartButton(context),
        ],
      ),
    );
  }

  Widget buildProductImage() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F2F2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          item.imagePath,
          height: 250,
          fit: BoxFit.contain,
          loadingBuilder: (_, child, prog) {
            if (prog == null) return child;
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF3B6B5E),
                strokeWidth: 2,
              ),
            );
          },
          errorBuilder: (_, __, ___) => const Center(
            child: Icon(Icons.chair, size: 60, color: Color(0xFFCCCCCC)),
          ),
        ),
      ),
    );
  }

  Widget buildHeartButton(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10,
      child: GestureDetector(
        onTap: () => _confirmRemove(context, item),
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppColors.appColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.appColor.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              AppImages.likeSelected,
              height: 14,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }

  // ── Name & Rating ──────────────────────────────────────────────────────────

  Widget buildNameAndRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildProductName(),
        buildRating(),
      ],
    );
  }

  Widget buildProductName() {
    return Expanded(
      child: Text(
        item.name,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget buildRating() {
    return Row(
      children: [
        const Icon(Icons.star_rounded, color: Colors.orange, size: 14),
        const SizedBox(width: 2),
        Text(
          item.rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  // ── Price ──────────────────────────────────────────────────────────────────

  Widget buildPrice() {
    return Text(
      '\$${item.price.toStringAsFixed(2)}',
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  // ── Confirm Remove Bottom Sheet ────────────────────────────────────────────

  void _confirmRemove(BuildContext context, WishlistItemModel item) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildSheetHandle(),
            const SizedBox(height: 20),
            buildSheetTitle(),
            const SizedBox(height: 20),
            buildItemPreview(),
            const SizedBox(height: 24),
            buildSheetButtons(),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  Widget buildSheetHandle() {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: const Color(0xFFDDDDDD),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget buildSheetTitle() {
    return const Text(
      'Remove from Wishlist?',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  // ── Item Preview ───────────────────────────────────────────────────────────

  Widget buildItemPreview() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          buildPreviewImage(),
          const SizedBox(width: 14),
          buildPreviewInfo(),
        ],
      ),
    );
  }

  Widget buildPreviewImage() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F2F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          item.imagePath,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) =>
          const Icon(Icons.chair, size: 36, color: Color(0xFFAAAAAA)),
        ),
      ),
    );
  }

  Widget buildPreviewInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPreviewName(),
          const SizedBox(height: 4),
          buildPreviewCategory(),
          const SizedBox(height: 6),
          buildPreviewPrice(),
        ],
      ),
    );
  }

  Widget buildPreviewName() {
    return Text(
      item.name,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget buildPreviewCategory() {
    return Text(
      item.category,
      style: const TextStyle(fontSize: 12, color: Colors.grey),
    );
  }

  Widget buildPreviewPrice() {
    return Text(
      '\$${item.price.toStringAsFixed(2)}',
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  // ── Sheet Buttons ──────────────────────────────────────────────────────────

  Widget buildSheetButtons() {
    return Row(
      children: [
        Expanded(child: buildCancelButton()),
        const SizedBox(width: 14),
        Expanded(child: buildRemoveButton()),
      ],
    );
  }

  Widget buildCancelButton() {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F2F2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.appColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRemoveButton() {
    return GestureDetector(
      onTap: () {
        Get.back();
        controller.removeFromWishlist(item);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.appColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Center(
          child: Text(
            'Yes, Remove',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}