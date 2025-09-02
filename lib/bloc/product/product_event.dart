part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllProducts extends ProductEvent {
  final bool forceRefresh;
  
  const LoadAllProducts({this.forceRefresh = false});
  
  @override
  List<Object?> get props => [forceRefresh];
}

class LoadProductById extends ProductEvent {
  final String productId;

  const LoadProductById(this.productId);

  @override
  List<Object?> get props => [productId];
}

class SearchProducts extends ProductEvent {
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterProductsByCategory extends ProductEvent {
  final String categoryName;

  const FilterProductsByCategory(this.categoryName);

  @override
  List<Object?> get props => [categoryName];
}

class ClearProductFilter extends ProductEvent {}

class LoadProductVariantById extends ProductEvent {
  final String productId;

  const LoadProductVariantById(this.productId);
}


// Note: createProduct in API uses named parameters and multipart form data.
// We might need a more complex DTO or pass individual parameters here.
// For simplicity, let's pass required fields and the optional file.
class CreateProduct extends ProductEvent {
  final num price;
  final List<String> categoryNames;
  final String? id;
  final String? imageUrl;
  final MultipartFile?
      file; // Assuming MultipartFile is available/imported where needed
  final String? name;
  final String? description;
  final int? stockQuantity;
  final List<String>? sizes;

  const CreateProduct({
    required this.price,
    required this.categoryNames,
    this.id,
    this.imageUrl,
    this.file,
    this.name,
    this.description,
    this.stockQuantity,
    this.sizes,
  });

  @override
  List<Object?> get props => [
        price,
        categoryNames,
        id,
        imageUrl,
        file,
        name,
        description,
        stockQuantity,
        sizes,
      ];
}

class UpdateProduct extends ProductEvent {
  final String productId;
  final ProductDto productData; // API uses ProductDto for update

  const UpdateProduct({required this.productId, required this.productData});

  @override
  List<Object?> get props => [productId, productData];
}

class DeleteProduct extends ProductEvent {
  final String productId;

  const DeleteProduct(this.productId);

  @override
  List<Object?> get props => [productId];
}
