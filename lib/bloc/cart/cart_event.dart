part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final ProductDto product;
  final String size;
  final String color;
  final int quantity;

  const AddToCart({
    required this.product,
    required this.size,
    required this.color,
    this.quantity = 1,
  });

  @override
  List<Object?> get props => [product, size, color, quantity];
}

class RemoveFromCart extends CartEvent {
  final String productId;
  final String size;
  final String color;

  const RemoveFromCart({
    required this.productId,
    required this.size,
    required this.color,
  });

  @override
  List<Object?> get props => [productId, size, color];
}

class UpdateCartItemQuantity extends CartEvent {
  final String productId;
  final String size;
  final String color;
  final int quantity;

  const UpdateCartItemQuantity({
    required this.productId,
    required this.size,
    required this.color,
    required this.quantity,
  });

  @override
  List<Object?> get props => [productId, size, color, quantity];
}

class ClearCart extends CartEvent {}
