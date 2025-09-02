import 'package:lnFoot_api/api.dart';

class SavedProductDto {
  final ProductDto product;
  final String? selectedVariantId;
  final String? variantImageUrl;

  SavedProductDto({
    required this.product,
    required this.selectedVariantId,
    required this.variantImageUrl,
  });

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'selectedVariantId': selectedVariantId,
        'variantImageUrl': variantImageUrl,
      };
  factory SavedProductDto.fromJson(Map<String, dynamic> json) {
    // Validate that required fields exist
    if (json['product'] == null) {
      throw FormatException('Missing required field: product');
    }

    final product = ProductDto.fromJson(json['product']);
    if (product == null) {
      throw FormatException('Invalid product data');
    }

    return SavedProductDto(
      product: product,
      selectedVariantId: json['selectedVariantId'],
      variantImageUrl: json['variantImageUrl'],
    );
  }
}
