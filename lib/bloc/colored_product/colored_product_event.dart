part of 'colored_product_bloc.dart';

abstract class ColoredProductEvent extends Equatable {
  const ColoredProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadColoredProducts extends ColoredProductEvent {}

class LoadColoredProductById extends ColoredProductEvent {
  final String id;

  const LoadColoredProductById(this.id);

  @override
  List<Object?> get props => [id];
}

class CreateColoredProduct extends ColoredProductEvent {
  final ColoredProductDto coloredProductData;

  const CreateColoredProduct({required this.coloredProductData});

  @override
  List<Object?> get props => [coloredProductData];
}

class UpdateColoredProduct extends ColoredProductEvent {
  final String id;
  final ColoredProductDto coloredProductData;

  const UpdateColoredProduct(
      {required this.id, required this.coloredProductData});

  @override
  List<Object?> get props => [id, coloredProductData];
}

class DeleteColoredProduct extends ColoredProductEvent {
  final String id;

  const DeleteColoredProduct(this.id);

  @override
  List<Object?> get props => [id];
}
