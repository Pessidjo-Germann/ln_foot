import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/cart/cart_bloc.dart';
import 'package:ln_foot/bloc/order/order_bloc.dart';
import 'package:ln_foot/screen/checkout_screen.dart';
import 'package:ln_foot/screen/home_screen.dart';
import 'package:ln_foot/widgets/product_details/add_to_cart_section.dart';
import 'package:lnFoot_api/api.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/cart/cart_item_list.dart';
import '../widgets/cart/cart_summary.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCart());
  }

  void _handleIncreaseQuantity(String itemId) {
    final bloc = context.read<CartBloc>();
    if (bloc.state is CartLoaded) {
      final state = bloc.state as CartLoaded;
      final item = state.items.firstWhere((item) => item.product.id == itemId);
      bloc.add(UpdateCartItemQuantity(
        productId: itemId,
        quantity: item.quantity + 1,
      ));
    }
  }
  bool isLoading = false;
  void _handleDecreaseQuantity(String itemId) {
    final bloc = context.read<CartBloc>();
    if (bloc.state is CartLoaded) {
      final state = bloc.state as CartLoaded;
      final item = state.items.firstWhere((item) => item.product.id == itemId);
      if (item.quantity > 1) {
        bloc.add(UpdateCartItemQuantity(
          productId: itemId,
          quantity: item.quantity - 1,
        ));
      }
    }
  }

  void _handleRemoveItem(String itemId) {
    context.read<CartBloc>().add(RemoveFromCart(itemId));
  }

  List<CartItem> _convertCartItems(List<CartItem> items) {
    return items
        .map((item) => CartItem(
              product: item.product,
              color: item.color,
              size: item.size,
              quantity: item.quantity,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        if (cartState is CartLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (cartState is CartLoaded) {
          const double shipping = 00;
          const double discount = 00;
          final double total = cartState.total + shipping - discount;
          return BlocListener<OrderBloc, OrderState>(
            listener: (context, state) {
              if (state is OrderCreated) {
                setState(() {
                  isLoading = false;
                });
                context.read<CartBloc>().add(ClearCart());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CheckoutScreen(orderDto: state.order)));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Commande créée avec succès'),
                    backgroundColor: Colors.green));
              } else if (state is OrderError) {
                setState(() {
                  isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message), backgroundColor: Colors.red));
              }else if (state is OrderLoading) {
                setState(() {
                  isLoading = true;
                });
              }
            },
            child: Scaffold(
              appBar: CustomAppBar(
                title: 'Mon panier',
                showBackButton: true,
                onBackButtonPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen())),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
              body: Column(children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CartItemList(
                          items: _convertCartItems(cartState.items),
                          onIncreaseQuantity: _handleIncreaseQuantity,
                          onDecreaseQuantity: _handleDecreaseQuantity,
                          onRemoveItem: _handleRemoveItem,
                        ),
                        const Divider(height: 1, thickness: 0.4),
                        CartSummary(
                          subtotal: cartState.total,
                          shipping: shipping,
                          discount: discount,
                          total: total,
                        ),
                      ],
                    ),
                  ),
                ),
                AddToCartSection(
                  title: 'Passer à la caisse',
                  isLoading: isLoading,
                  canAddToCart: cartState.items.isNotEmpty,
                  onAddToCart: () {
                    if (cartState.items.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Votre panier est vide'),
                          backgroundColor: Colors.orange));
                      return;
                    }

                    final orderItems = cartState.items
                        .map((item) => OrderItemDto(
                            quantity: item.quantity,
                            size: item.size,
                            price: item.product.price,
                            productVariantId: item.product.id))
                        .toList();

                    final orderData = OrderDto(
                      status: 'pending',
                      orderDate: DateTime.now(),
                      orderItems: orderItems,
                    );
                    debugPrint(orderData.toString());
                    context
                        .read<OrderBloc>()
                        .add(CreateOrder(orderData: orderData));
                  },
                ),
              ]),
            ),
          );
        }

        return const Scaffold(
          body: Center(
            child: Text('Une erreur est survenue lors du chargement du panier'),
          ),
        );
      },
    );
  }
}
