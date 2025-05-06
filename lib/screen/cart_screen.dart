import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/order/order_bloc.dart';
import 'package:ln_foot/screen/checkout_screen.dart';
import 'package:ln_foot/widgets/product_details/add_to_cart_section.dart';
import 'package:lnFoot_api/api.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/cart/cart_item_list.dart';
import '../widgets/cart/cart_summary.dart';
import '../widgets/cart/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartItem> cartItems;

  @override
  void initState() {
    super.initState();

    cartItems = [
      CartItem(
        id: 'item1',
        image: 'images/product1.png',
        name: 'Maillot Cameroun',
        size: 'XL',
        price: 15000,
        quantity: 1,
      ),
      CartItem(
        id: 'item2',
        image: 'images/product2.png',
        name: 'Godasse Nike',
        size: '42',
        price: 25000,
        quantity: 2,
      ),
      CartItem(
        id: 'item3',
        image: 'images/product3.png',
        name: 'Godasse Adidas',
        size: '41',
        price: 26000,
        quantity: 1,
      ),
    ];
  }

  void _handleIncreaseQuantity(String itemId) {
    setState(() {
      final itemIndex = cartItems.indexWhere((item) => item.id == itemId);
      if (itemIndex != -1) {
        final updatedItem = CartItem(
          id: cartItems[itemIndex].id,
          image: cartItems[itemIndex].image,
          name: cartItems[itemIndex].name,
          size: cartItems[itemIndex].size,
          price: cartItems[itemIndex].price,
          quantity: cartItems[itemIndex].quantity + 1,
        );

        cartItems[itemIndex] = updatedItem;
      }
    });
  }

  void _handleDecreaseQuantity(String itemId) {
    setState(() {
      final itemIndex = cartItems.indexWhere((item) => item.id == itemId);
      if (itemIndex != -1 && cartItems[itemIndex].quantity > 1) {
        final updatedItem = CartItem(
          id: cartItems[itemIndex].id,
          image: cartItems[itemIndex].image,
          name: cartItems[itemIndex].name,
          size: cartItems[itemIndex].size,
          price: cartItems[itemIndex].price,
          quantity: cartItems[itemIndex].quantity - 1,
        );

        cartItems[itemIndex] = updatedItem;
      }
    });
  }

  void _handleRemoveItem(String itemId) {
    setState(() {
      cartItems.removeWhere((item) => item.id == itemId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double subtotal =
        cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
    const double shipping = 20.00;
    const double discount = 10.00;
    final double total = subtotal + shipping - discount;

    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderCreated) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const CheckoutScreen()));
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Commande créée avec succès'),
              backgroundColor: Colors.green));
        } else if (state is OrderError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message), backgroundColor: Colors.red));
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Mon panier',
          showBackButton: true,
          onBackButtonPressed: () => Navigator.pop(context),
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
                    items: cartItems,
                    onIncreaseQuantity: _handleIncreaseQuantity,
                    onDecreaseQuantity: _handleDecreaseQuantity,
                    onRemoveItem: _handleRemoveItem,
                  ),
                  const Divider(height: 1, thickness: 0.4),
                  CartSummary(
                    subtotal: subtotal,
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
            onAddToCart: () {
              if (cartItems.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Votre panier est vide'),
                    backgroundColor: Colors.orange));
                return;
              }

              final orderItems = cartItems
                  .map((item) => OrderItemDto(
                        coloredProductId: item.id,
                        quantity: item.quantity,
                        size: item.size,
                      ))
                  .toList();

              final orderData = OrderDto(
                orderItems: orderItems,
              );

              context.read<OrderBloc>().add(CreateOrder(orderData: orderData));
            },
          ),
        ]),
      ),
    );
  }
}
