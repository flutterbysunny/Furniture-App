import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_theme.dart';

class Screen3MockupWidget extends StatelessWidget {
  const Screen3MockupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _PhoneMockup(
      child: _WishlistScreenContent(),
    );
  }
}

class _PhoneMockup extends StatelessWidget {
  final Widget child;
  const _PhoneMockup({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 420,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
        border: Border.all(color: const Color(0xFF1A1A1A), width: 6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: child,
      ),
    );
  }
}

class _WishlistScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'name': 'Arm Chair', 'price': '\$180.00', 'rating': '4.9'},
      {'name': 'Sofa Chair', 'price': '\$120.00', 'rating': '5.0'},
      {'name': 'Wood Chair', 'price': '\$110.00', 'rating': '4.9'},
      {'name': 'Grey Chair', 'price': '\$200.00', 'rating': '5.0'},
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status bar
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('9:41',
                    style: GoogleFonts.poppins(
                        fontSize: 9, fontWeight: FontWeight.w600)),
                const Row(
                  children: [
                    Icon(Icons.signal_cellular_alt, size: 10),
                    SizedBox(width: 3),
                    Icon(Icons.wifi, size: 10),
                    SizedBox(width: 3),
                    Icon(Icons.battery_full, size: 10),
                  ],
                ),
              ],
            ),
          ),
          // Notch
          Center(
            child: Container(
              width: 60,
              height: 14,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 6),
          // Appbar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new,
                      size: 10, color: AppColors.black),
                ),
                const Spacer(),
                Text('My Wishlist',
                    style: GoogleFonts.poppins(
                        fontSize: 10, fontWeight: FontWeight.w700)),
                const Spacer(),
                const SizedBox(width: 22),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Filter chips
          SizedBox(
            height: 22,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _FilterChip(label: 'All', isActive: false),
                const SizedBox(width: 5),
                _FilterChip(label: 'Chair', isActive: true),
                const SizedBox(width: 5),
                _FilterChip(label: 'Sofa', isActive: false),
                const SizedBox(width: 5),
                _FilterChip(label: 'Lamp', isActive: false),
                const SizedBox(width: 5),
                _FilterChip(label: 'Cupboard', isActive: false),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.82,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return _WishlistCard(
                    name: items[index]['name']!,
                    price: items[index]['price']!,
                    rating: items[index]['rating']!,
                    colorSeed: index,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  const _FilterChip({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: isActive ? AppColors.appColor : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isActive
            ? null
            : Border.all(color: AppColors.lightGrey, width: 1),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 7,
          color: isActive ? AppColors.white : AppColors.grey,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}

class _WishlistCard extends StatelessWidget {
  final String name;
  final String price;
  final String rating;
  final int colorSeed;

  const _WishlistCard({
    required this.name,
    required this.price,
    required this.rating,
    required this.colorSeed,
  });

  @override
  Widget build(BuildContext context) {
    final bgColors = [
      const Color(0xFFF5F0EA),
      const Color(0xFFEAEEF5),
      const Color(0xFFF5EAF0),
      const Color(0xFFEAF5EE),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: bgColors[colorSeed % bgColors.length],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.chair,
                      size: 38,
                      color: AppColors.appColor.withOpacity(0.55),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_border,
                        size: 10, color: Colors.redAccent),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: GoogleFonts.poppins(
                        fontSize: 7.5, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(price,
                        style: GoogleFonts.poppins(
                            fontSize: 7,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500)),
                    Row(
                      children: [
                        const Icon(Icons.star,
                            size: 8, color: AppColors.starColor),
                        Text(rating,
                            style: GoogleFonts.poppins(
                                fontSize: 6.5, color: AppColors.grey)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}