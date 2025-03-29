
class Product {
  final String imageUrl;
  final String name; // Keep name if you might use it later or elsewhere
  final String category;
  final double price;
  final double? oldPrice;
  final double rating;
  final int reviewCount;
  final bool isFavorite;

  const Product({
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.price,
    this.oldPrice,
    required this.rating,
    required this.reviewCount,
    this.isFavorite = false,
  });
}
