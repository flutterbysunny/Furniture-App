class WishlistItemModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final String imagePath;

  const WishlistItemModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.imagePath,
  });
}