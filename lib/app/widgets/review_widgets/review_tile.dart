import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/app/widgets/review_widgets/star_row.dart';

import '../../models/review_model.dart';
import '../../utils/app_colors.dart';

class ReviewTile extends StatelessWidget {
  final ReviewModel review;

  const ReviewTile({required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: avatar + name + time
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(review.userAvatar),
                    backgroundColor: const Color(0xFFF3F2F2),
                  ),
                  if (review.isVerified)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: AppColors.appColor,
                          shape: BoxShape.circle,
                          border:
                          Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: const Icon(Icons.check,
                            size: 9, color: Colors.white),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(review.userName,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ),
              Text(review.timeAgo,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),

          const SizedBox(height: 10),

          // Comment
          Text(review.comment,
              style: const TextStyle(
                  fontSize: 13, color: Colors.grey, height: 1.5)),

          const SizedBox(height: 8),

          // Rating row
          Row(
            children: [
              StarRow(rating: review.rating, size: 16),
              const SizedBox(width: 6),
              Text(review.rating.toStringAsFixed(1),
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
            ],
          ),

          // Review images (if any)
          if (review.images.isNotEmpty) ...[
            const SizedBox(height: 10),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: review.images.length,
                itemBuilder: (_, i) => Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFF3F2F2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(review.images[i],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                            Icons.image_outlined,
                            color: Color(0xFFCCCCCC))),
                  ),
                ),
              ),
            ),
          ],

          const SizedBox(height: 12),
          const Divider(color: Color(0xFFF0F0F0), height: 1),
        ],
      ),
    );
  }
}
