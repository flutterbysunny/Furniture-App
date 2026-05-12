import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../modules/review/review_controller.dart';
import '../custom_button.dart';

class WriteReviewSheet extends GetView<ReviewController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: const Color(0xFFDDDDDD),
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),

            const SizedBox(height: 16),

            const Text('Write a Review',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),

            const SizedBox(height: 16),

            // Star selector
            const Text('Your Rating',
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 8),
            Obx(() => Row(
              children: List.generate(5, (i) {
                final filled = i < controller.writeRating.value;
                return GestureDetector(
                  onTap: () => controller.setWriteRating(i + 1),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Icon(
                      filled ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: Colors.orange,
                      size: 36,
                    ),
                  ),
                );
              }),
            )),

            const SizedBox(height: 16),

            // Comment field
            const Text('Your Review',
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF3F2F2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                controller: controller.writeComment,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Share your experience...',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Submit button
            Obx(() => CustomButton(
              text: 'Submit Review',
              borderRadius: 50,
              isLoading: controller.isSubmitting.value,
              onPressed: controller.submitReview,
            )),
          ],
        ),
      ),
    );
  }
}