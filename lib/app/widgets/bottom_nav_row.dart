// ─────────────────────────────────────────────
// BottomNavRow
// ─────────────────────────────────────────────

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class BottomNavRow extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  const BottomNavRow({
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildBackButton(),
        buildDots(),
        buildNextButton(),
      ],
    );
  }

  /// Back arrow button — hidden on last page
  Widget buildBackButton() {
    if (currentPage == totalPages - 1) {
      return const SizedBox(width: 54);
    }

    return GestureDetector(
      onTap: onPrev,
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.appSoftColor, width: 1.5),
          color: AppColors.white,
        ),
        child: const Icon(
          Icons.arrow_back,
          color: AppColors.black,
          size: 22,
        ),
      ),
    );
  }

  /// Animated page indicator dots
  Widget buildDots() {
    return Row(
      children: List.generate(
        totalPages,
            (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: i == currentPage ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: i == currentPage ? AppColors.appColor : AppColors.lightGrey,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  /// Forward arrow button (always visible)
  Widget buildNextButton() {
    return GestureDetector(
      onTap: onNext,
      child: Container(
        width: 54,
        height: 54,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.appColor,
        ),
        child: const Icon(
          Icons.arrow_forward,
          color: AppColors.white,
          size: 22,
        ),
      ),
    );
  }
}