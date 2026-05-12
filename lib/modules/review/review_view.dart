import 'package:flutter/material.dart';
import 'package:furniture_app/modules/review/review_controller.dart';
import 'package:get/get.dart';
import '../../app/utils/app_colors.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/review_widgets/review_tile.dart';
import '../../app/widgets/review_widgets/star_row.dart';

class ReviewView extends GetView<ReviewController> {
  const ReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          buildAppBar(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: buildRatingSummary(),
                ),
                SliverToBoxAdapter(
                  child: buildSearchBar(),
                ),
                SliverToBoxAdapter(
                  child: buildFilterChips(),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 8,),),
                buildReviewList(),
                SliverToBoxAdapter(child: SizedBox(height: 100,),),
              ],
            ),
          ),
          buildBottomBar()

          // ── Write Review Button ──
        ],
      ),
    );
  }

  // ── AppBar ──────────────────────────────────────────────────────────────────

  Widget buildAppBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
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
            const Expanded(
              child: Text('Review',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }

  // ── Rating Summary ──────────────────────────────────────────────────────────

  Widget buildRatingSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: big rating
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.overallRating.toString(),
                style: const TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1),
              ),
              const SizedBox(height: 6),
              StarRow(rating: controller.overallRating, size: 22),
              const SizedBox(height: 6),
              Text(
                '(${controller.totalReviews} Reviews)',
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(width: 24),

          // Right: bar breakdown
          Expanded(
            child: Column(
              children: [5, 4, 3, 2, 1].map((star) {
                final frac = controller.ratingBreakdown[star] ?? 0.0;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Text('$star',
                          style: const TextStyle(
                              fontSize: 11, color: Colors.grey)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: frac,
                            minHeight: 6,
                            backgroundColor: const Color(0xFFEEEEEE),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.appColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ── Search Bar ──────────────────────────────────────────────────────────────

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Container(
        height: 46,
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
                onChanged: controller.onSearchChanged,
                decoration: const InputDecoration(
                  hintText: 'Search in reviews',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Filter Chips ────────────────────────────────────────────────────────────

  Widget buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        height: 36,
        child: Obx(() => ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            // Filter dropdown chip
            GestureDetector(
              onTap: () {}, // TODO: show filter options
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F2F2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.tune_rounded, size: 14, color: Colors.black54),
                    SizedBox(width: 4),
                    Text('Filter',
                        style: TextStyle(fontSize: 13, color: Colors.black87)),
                    SizedBox(width: 2),
                    Icon(Icons.keyboard_arrow_down_rounded,
                        size: 16, color: Colors.black54),
                  ],
                ),
              ),
            ),

            // Filter options
            ...controller.filters.map((f) {
              final isSelected = controller.selectedFilter.value == f;
              return GestureDetector(
                onTap: () => controller.selectFilter(f),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.appColor
                        : const Color(0xFFF3F2F2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      f,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        )),
      ),
    );
  }

  // ── Review List ─────────────────────────────────────────────────────────────

  Widget buildReviewList() {
    return Obx(() {
      final reviews = controller.filteredReviews;
      if (reviews.isEmpty) {
        return const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Center(
              child: Text('No reviews found',
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
            ),
          ),
        );
      }
      return SliverList(
        delegate: SliverChildBuilderDelegate(
              (_, i) => ReviewTile(review: reviews[i]),
          childCount: reviews.length,
        ),
      );
    });
  }

  // ── Bottom Bar ──────────────────────────────────────────────────────────────

  Widget buildBottomBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      child: CustomButton(
        text: 'Write Review',
        borderRadius: 50,
        onPressed: controller.writeReview,
      ),
    );
  }
}

