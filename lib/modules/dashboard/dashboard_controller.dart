import 'package:flutter/material.dart';
import 'package:furniture_app/modules/my_wishlist/my_wishlist_view.dart';
import 'package:get/get.dart';
import '../home/home_view.dart';
import '../my_cart/my_cart_view.dart';

class DashboardController extends GetxController {
  final currentIndex = 0.obs;

  void onNavTap(int index) => currentIndex.value = index;

  // Tab screens list
  final List<Widget> tabs = [
    const HomeScreen(),           // Tab 0 - Home
    // MyCartView(),
    const _PlaceholderTab(icon: Icons.shopping_bag_outlined, label: 'Cart'),
    MyWishlistView(),
    // const _PlaceholderTab(icon: Icons.favorite_outline, label: 'Wishlist'),
    const _PlaceholderTab(icon: Icons.chat_bubble_outline, label: 'Messages'),
    const _PlaceholderTab(icon: Icons.person_outline, label: 'Profile'),
  ];
}


// ─── Placeholder Tab ──────────────────────────────────────────────────────────

class _PlaceholderTab extends StatelessWidget {
  final IconData icon;
  final String label;

  const _PlaceholderTab({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 52, color: const Color(0xFF3B6B5E)),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}