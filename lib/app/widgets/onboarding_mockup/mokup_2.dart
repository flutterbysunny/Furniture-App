import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';

class Screen2MockupWidget extends StatelessWidget {
  const Screen2MockupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _PhoneMockup(
      child: _StyleScreenContent(),
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

class _StyleScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = [
      {'name': 'Modern Sofa', 'price': '\$450.00', 'rating': '4.8'},
      {'name': 'Arm Chair', 'price': '\$180.00', 'rating': '4.9'},
      {'name': 'Floor Lamp', 'price': '\$89.00', 'rating': '4.7'},
      {'name': 'Oak Table', 'price': '\$320.00', 'rating': '5.0'},
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status bar
            Container(
              color: AppColors.white,
              padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
            const SizedBox(height: 8),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Explore',
                          style: GoogleFonts.poppins(
                              fontSize: 7, color: AppColors.grey)),
                      Text('Furniture',
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.search,
                            size: 12, color: AppColors.black),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.tune,
                            size: 12, color: AppColors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Style filter chips
            SizedBox(
              height: 24,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _StyleChip(label: 'All', isActive: false),
                  const SizedBox(width: 5),
                  _StyleChip(label: 'Living Room', isActive: true),
                  const SizedBox(width: 5),
                  _StyleChip(label: 'Bedroom', isActive: false),
                  const SizedBox(width: 5),
                  _StyleChip(label: 'Office', isActive: false),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Product grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.82,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return _ProductCard(
                    name: products[index]['name']!,
                    price: products[index]['price']!,
                    rating: products[index]['rating']!,
                    colorSeed: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StyleChip extends StatelessWidget {
  final String label;
  final bool isActive;
  const _StyleChip({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.appColor : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
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

class _ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String rating;
  final int colorSeed;

  const _ProductCard({
    required this.name,
    required this.price,
    required this.rating,
    required this.colorSeed,
  });

  @override
  Widget build(BuildContext context) {
    final bgColors = [
      const Color(0xFFF0EDE8),
      const Color(0xFFE8EDF0),
      const Color(0xFFF0E8EC),
      const Color(0xFFE8F0EC),
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
                      colorSeed % 2 == 0 ? Icons.weekend : Icons.chair,
                      size: 36,
                      color: AppColors.appColor.withOpacity(0.6),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_border,
                        size: 10, color: AppColors.grey),
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
                        fontSize: 7, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(price,
                        style: GoogleFonts.poppins(
                            fontSize: 7,
                            color: AppColors.appColor,
                            fontWeight: FontWeight.w700)),
                    Row(
                      children: [
                        const Icon(Icons.star,
                            size: 8, color: AppColors.starColor),
                        Text(rating,
                            style: GoogleFonts.poppins(
                                fontSize: 6, color: AppColors.grey)),
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