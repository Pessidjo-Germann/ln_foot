part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<ProductDto> products;

  const ProductsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductVariantsLoaded extends ProductState {
  final List<ProductVariantDto> variants;

  const ProductVariantsLoaded(this.variants);
}

class ProductVariantLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final ProductDto product;

  const ProductLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductCreated extends ProductState {
  final ProductDto product;

  const ProductCreated(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductUpdated extends ProductState {
  final ProductDto product;

  const ProductUpdated(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductDeleted extends ProductState {}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
