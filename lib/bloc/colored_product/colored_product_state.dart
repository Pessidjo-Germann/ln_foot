part of 'colored_product_bloc.dart';

abstract class ColoredProductState extends Equatable {
  const ColoredProductState();

  @override
  List<Object?> get props => [];
}

class ColoredProductInitial extends ColoredProductState {}

class ColoredProductLoading extends ColoredProductState {}

class ColoredProductsLoaded extends ColoredProductState {
  final List<ColoredProductDto> coloredProducts;

  const ColoredProductsLoaded(this.coloredProducts);

  @override
  List<Object?> get props => [coloredProducts];
}

class ColoredProductLoaded extends ColoredProductState {
  final ColoredProductDto coloredProduct;

  const ColoredProductLoaded(this.coloredProduct);

  @override
  List<Object?> get props => [coloredProduct];
}

class ColoredProductCreated extends ColoredProductState {
  final ColoredProductDto coloredProduct;

  const ColoredProductCreated(this.coloredProduct);

  @override
  List<Object?> get props => [coloredProduct];
}

class ColoredProductUpdated extends ColoredProductState {
  final ColoredProductDto coloredProduct;

  const ColoredProductUpdated(this.coloredProduct);

  @override
  List<Object?> get props => [coloredProduct];
}

class ColoredProductDeleted extends ColoredProductState {}

class ColoredProductError extends ColoredProductState {
  final String message;

  const ColoredProductError(this.message);

  @override
  List<Object?> get props => [message];
}
