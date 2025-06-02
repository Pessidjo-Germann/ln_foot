import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lnFoot_api/api.dart';

part 'cart_event.dart';
part 'cart_state.dart';

const String _cartItemsKey = 'cart_items';

class CartItem extends Equatable {
  final ProductDto product;
  final String size;
  final String color;
  final int quantity;

  const CartItem({
    required this.product,
    required this.size,
    required this.color,
    required this.quantity,
  });

  double get total => product.price.toDouble() * quantity;

  CartItem copyWith({
    ProductDto? product,
    String? size,
    String? color,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      size: size ?? this.size,
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'size': size,
        'color': color,
        'quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        product: ProductDto.fromJson(json['product'])!,
        size: json['size'],
        color: json['color'],
        quantity: json['quantity'],
      );

  @override
  List<Object?> get props => [product, size, color, quantity];
}

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartItemQuantity>(_onUpdateQuantity);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _onLoadCart(
    LoadCart event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartItemsJson = prefs.getStringList(_cartItemsKey) ?? [];
      final items = cartItemsJson
          .map((itemJson) => CartItem.fromJson(jsonDecode(itemJson)))
          .toList();
      _emitLoadedState(emit, items);
    } catch (e) {
      emit(CartError('Erreur lors du chargement du panier: ${e.toString()}'));
    }
  }

  Future<void> _onAddToCart(
    AddToCart event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      try {
        final currentState = state as CartLoaded;
        final updatedItems = List<CartItem>.from(currentState.items);

        // Vérifier si le produit existe déjà avec la même taille et couleur
        final existingItemIndex = updatedItems.indexWhere((item) =>
            item.product.id == event.product.id &&
            item.size == event.size &&
            item.color == event.color);

        if (existingItemIndex != -1) {
          // Mettre à jour la quantité si l'article existe déjà
          final existingItem = updatedItems[existingItemIndex];
          updatedItems[existingItemIndex] = existingItem.copyWith(
            quantity: existingItem.quantity + event.quantity,
          );
        } else {
          // Ajouter un nouvel article
          updatedItems.add(CartItem(
            product: event.product,
            size: event.size,
            color: event.color,
            quantity: event.quantity,
          ));
        }

        await _saveCartItems(updatedItems);
        _emitLoadedState(emit, updatedItems);
      } catch (e) {
        emit(CartError('Erreur lors de l\'ajout au panier: ${e.toString()}'));
      }
    }
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      try {
        final currentState = state as CartLoaded;
        final updatedItems = currentState.items
            .where((item) => !(item.product.id == event.productId &&
                item.size == event.size &&
                item.color == event.color))
            .toList();
        await _saveCartItems(updatedItems);
        _emitLoadedState(emit, updatedItems);
      } catch (e) {
        emit(CartError(
            'Erreur lors de la suppression du panier: ${e.toString()}'));
      }
    }
  }

  Future<void> _onUpdateQuantity(
    UpdateCartItemQuantity event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      try {
        final currentState = state as CartLoaded;
        final updatedItems = currentState.items.map((item) {
          if (item.product.id == event.productId &&
              item.size == event.size &&
              item.color == event.color) {
            return item.copyWith(quantity: event.quantity);
          }
          return item;
        }).toList();

        // Supprimer l'article si la quantité est 0
        updatedItems.removeWhere((item) => item.quantity <= 0);

        await _saveCartItems(updatedItems);
        _emitLoadedState(emit, updatedItems);
      } catch (e) {
        emit(CartError(
            'Erreur lors de la mise à jour de la quantité: ${e.toString()}'));
      }
    }
  }

  Future<void> _onClearCart(
    ClearCart event,
    Emitter<CartState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_cartItemsKey, []);
      _emitLoadedState(emit, []);
    } catch (e) {
      emit(CartError(
          'Erreur lors de la suppression du panier: ${e.toString()}'));
    }
  }

  Future<void> _saveCartItems(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final cartItemsJson =
        items.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_cartItemsKey, cartItemsJson);
  }

  void _emitLoadedState(Emitter<CartState> emit, List<CartItem> items) {
    final total = items.fold<double>(
        0, (sum, item) => sum + item.product.price.toDouble() * item.quantity);
    emit(CartLoaded(items: items, total: total));
  }
}
