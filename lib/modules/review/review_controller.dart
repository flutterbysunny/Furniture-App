import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/models/review_model.dart';
import '../../app/utils/app_colors.dart';
import '../../app/widgets/review_widgets/writes_review.dart';

class ReviewController extends GetxController {
  final searchController = TextEditingController();

  final searchQuery = ''.obs;
  final selectedFilter = 'Verified'.obs; // Verified, Latest, Detailed Reviews
  final filters = ['Verified', 'Latest', 'Detailed Reviews'];

  // Overall rating data
  final overallRating = 4.5;
  final totalReviews = 107;
  final ratingBreakdown = const {5: 0.75, 4: 0.60, 3: 0.25, 2: 0.10, 1: 0.05};

  // All reviews
  final allReviews = <ReviewModel>[
    ReviewModel(
      id: '1',
      userName: 'Dale Thiel',
      userAvatar: 'https://i.pravatar.cc/150?img=11',
      comment: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
      rating: 5.0,
      timeAgo: '11 months ago',
      isVerified: true,
      images: [],
    ),
    ReviewModel(
      id: '2',
      userName: 'Tiffany Nitzsche',
      userAvatar: 'https://i.pravatar.cc/150?img=5',
      comment: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
      rating: 5.0,
      timeAgo: '11 months ago',
      isVerified: true,
      images: [
        'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300',
        'https://images.unsplash.com/photo-1567538096630-e0c55bd6374c?w=300',
      ],
    ),
    ReviewModel(
      id: '3',
      userName: 'Marcus Reed',
      userAvatar: 'https://i.pravatar.cc/150?img=15',
      comment: 'Great quality product! Really happy with my purchase. Highly recommended.',
      rating: 4.0,
      timeAgo: '2 months ago',
      isVerified: false,
      images: [],
    ),
    ReviewModel(
      id: '4',
      userName: 'Sophie Chen',
      userAvatar: 'https://i.pravatar.cc/150?img=47',
      comment: 'Decent product but delivery was a bit late. Overall satisfied.',
      rating: 3.0,
      timeAgo: '3 months ago',
      isVerified: true,
      images: [
        'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=300',
      ],
    ),
    ReviewModel(
      id: '5',
      userName: 'James Wilson',
      userAvatar: 'https://i.pravatar.cc/150?img=33',
      comment: 'Amazing craftsmanship! Exactly as shown in the pictures. Very sturdy.',
      rating: 5.0,
      timeAgo: '5 months ago',
      isVerified: true,
      images: [],
    ),
  ];

  // Filtered + searched reviews
  List<ReviewModel> get filteredReviews {
    List<ReviewModel> result = List.from(allReviews);

    // Apply filter
    if (selectedFilter.value == 'Verified') {
      result = result.where((r) => r.isVerified).toList();
    } else if (selectedFilter.value == 'Latest') {
      // already in order, just return all
    } else if (selectedFilter.value == 'Detailed Reviews') {
      result = result.where((r) => r.comment.length > 60).toList();
    }

    // Apply search
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isNotEmpty) {
      result = result
          .where((r) =>
      r.userName.toLowerCase().contains(query) ||
          r.comment.toLowerCase().contains(query))
          .toList();
    }

    return result;
  }

  void onSearchChanged(String val) => searchQuery.value = val;

  void selectFilter(String filter) => selectedFilter.value = filter;

  void goBack() => Get.back();

  void writeReview() {
    Get.bottomSheet(
      WriteReviewSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  // ── Write review submit ──
  final writeRating = 0.obs;
  final writeComment = TextEditingController();
  final isSubmitting = false.obs;

  void setWriteRating(int star) => writeRating.value = star;

  Future<void> submitReview() async {
    if (writeRating.value == 0) {
      Get.snackbar('Rating Required', 'Please select a star rating.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12);
      return;
    }
    if (writeComment.text.trim().isEmpty) {
      Get.snackbar('Comment Required', 'Please write your review.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12);
      return;
    }

    isSubmitting.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isSubmitting.value = false;

    // Add to list
    allReviews.insert(
      0,
      ReviewModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userName: 'You',
        userAvatar: 'https://i.pinimg.com/1200x/21/14/cc/2114ccbf7aee656c6d7cda11b6c22771.jpg',
        comment: writeComment.text.trim(),
        rating: writeRating.value.toDouble(),
        timeAgo: 'Just now',
        isVerified: true,
      ),
    );

    writeComment.clear();
    writeRating.value = 0;
    searchQuery.refresh();

    Get.back();
    Get.snackbar('Review Submitted!', 'Thank you for your feedback.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.appColor,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.check_circle_outline, color: Colors.white));
  }

  @override
  void onClose() {
    searchController.dispose();
    writeComment.dispose();
    super.onClose();
  }
}