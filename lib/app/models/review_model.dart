class ReviewModel {
  final String id;
  final String userName;
  final String userAvatar; // network url
  final String comment;
  final double rating;
  final String timeAgo;
  final bool isVerified;
  final List<String> images; // optional review images

  const ReviewModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.comment,
    required this.rating,
    required this.timeAgo,
    this.isVerified = false,
    this.images = const [],
  });
}
