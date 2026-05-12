class SearchProductModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final String imagePath;
  final bool isWishlisted;

  const SearchProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.imagePath,
    this.isWishlisted = false,
  });
}