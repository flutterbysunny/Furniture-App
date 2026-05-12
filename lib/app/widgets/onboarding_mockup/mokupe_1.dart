import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';

class Screen1MockupWidget extends StatelessWidget {
  const Screen1MockupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _PhoneMockup(
      child: _HomeScreenContent(),
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

class _HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 8),
            // Location row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Location',
                          style: GoogleFonts.poppins(
                              fontSize: 7, color: AppColors.grey)),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 9, color: AppColors.appColor),
                          Text('New York, USA',
                              style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600)),
                          const Icon(Icons.keyboard_arrow_down, size: 9),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.notifications_none,
                        size: 13, color: AppColors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          const Icon(Icons.search,
                              size: 12, color: AppColors.grey),
                          const SizedBox(width: 4),
                          Text('Search Furniture...',
                              style: GoogleFonts.poppins(
                                  fontSize: 7, color: AppColors.grey)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.appColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.tune,
                        size: 13, color: AppColors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                height: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0EF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('New Collection',
                              style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700)),
                          Text('Discount 50%\nfor first buy',
                              style: GoogleFonts.poppins(
                                  fontSize: 6.5, color: AppColors.grey)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.appColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text('Shop Now',
                                style: GoogleFonts.poppins(
                                    fontSize: 6,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Image.network(
                        'https://i.imgur.com/IkQfKn7.png',
                        width: 55,
                        errorBuilder: (c, e, s) => Container(
                          width: 55,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD0E4E4),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.chair,
                              color: AppColors.appColor, size: 28),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Category
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Category',
                      style: GoogleFonts.poppins(
                          fontSize: 8, fontWeight: FontWeight.w700)),
                  Text('See All',
                      style: GoogleFonts.poppins(
                          fontSize: 7, color: AppColors.appColor)),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CategoryChip(icon: Icons.weekend, label: 'Sofa'),
                  _CategoryChip(icon: Icons.chair, label: 'Chair'),
                  _CategoryChip(icon: Icons.light, label: 'Lamp'),
                  _CategoryChip(icon: Icons.door_sliding, label: 'Cupboard'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Flash sale
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Flash Sale',
                      style: GoogleFonts.poppins(
                          fontSize: 8, fontWeight: FontWeight.w700)),
                  Row(
                    children: [
                      Text('Closing in ',
                          style: GoogleFonts.poppins(
                              fontSize: 6, color: AppColors.grey)),
                      _TimeBox(value: '02'),
                      Text(' : ',
                          style: GoogleFonts.poppins(
                              fontSize: 7, fontWeight: FontWeight.bold)),
                      _TimeBox(value: '12'),
                      Text(' : ',
                          style: GoogleFonts.poppins(
                              fontSize: 7, fontWeight: FontWeight.bold)),
                      _TimeBox(value: '56'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  _TabChip(label: 'All', isActive: false),
                  const SizedBox(width: 4),
                  _TabChip(label: 'Newest', isActive: true),
                  const SizedBox(width: 4),
                  _TabChip(label: 'Popular', isActive: false),
                  const SizedBox(width: 4),
                  _TabChip(label: 'Bedroom', isActive: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _CategoryChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: AppColors.appColor),
        ),
        const SizedBox(height: 3),
        Text(label,
            style: GoogleFonts.poppins(fontSize: 6.5, color: AppColors.black)),
      ],
    );
  }
}

class _TimeBox extends StatelessWidget {
  final String value;
  const _TimeBox({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      decoration: BoxDecoration(
        color: AppColors.appColor,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(value,
          style: GoogleFonts.poppins(
              fontSize: 6,
              color: AppColors.white,
              fontWeight: FontWeight.bold)),
    );
  }
}

class _TabChip extends StatelessWidget {
  final String label;
  final bool isActive;
  const _TabChip({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: isActive ? AppColors.appColor : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 6.5,
          color: isActive ? AppColors.white : AppColors.grey,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}