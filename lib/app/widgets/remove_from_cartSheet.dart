import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/models/cart_item_model.dart';
import '../../app/utils/app_colors.dart';
import '../../modules/my_cart/my_cart_controller.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Ye file my_cart_view.dart ke end me add karo (same file me)
// Ya alag file bana ke import karo
// ─────────────────────────────────────────────────────────────────────────────

class RemoveFromCartSheet extends GetView<MyCartController> {
  final CartItemModel item;

  const RemoveFromCartSheet({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Handle bar ──
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFDDDDDD),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 20),

          // ── Title ──
          const Text(
            'Remove from Cart?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 24),

          // ── Item Card ──
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Product Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F2F2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      item.imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.chair,
                        size: 40,
                        color: Color(0xFFAAAAAA),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // Name + Category + Price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item.category,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => Text(
                        '\$${item.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )),
                    ],
                  ),
                ),

                // Quantity (read-only style to match image)
                Obx(() => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _QtyBtn(
                      icon: Icons.remove,
                      bgColor: const Color(0xFFF3F2F2),
                      iconColor: Colors.black54,
                      onTap: () => controller.decrement(item),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${item.quantity.value}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    _QtyBtn(
                      icon: Icons.add,
                      bgColor: AppColors.appColor,
                      iconColor: Colors.white,
                      onTap: () => controller.increment(item),
                    ),
                  ],
                )),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // ── Action Buttons ──
          Row(
            children: [
              // Cancel
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F2F2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3B6B5E),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Yes, Remove
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                    controller.deleteItem(item);
                  },
                  child: Container(
                    height: 52,
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Small qty button helper ──────────────────────────────────────────────────

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _QtyBtn({
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: iconColor),
      ),
    );
  }
}