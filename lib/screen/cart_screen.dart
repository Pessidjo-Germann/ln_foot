import 'package:flutter/material.dart';
import 'package:ln_foot/screen/home_screen.dart';
import 'package:ln_foot/widgets/product_details/add_to_cart_section.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/cart/cart_item_list.dart';
import '../widgets/cart/cart_summary.dart';
import '../widgets/cart/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  // Keep as StatelessWidget for now
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
        // Create a new CartItem with increased quantity
        final updatedItem = CartItem(
          id: cartItems[itemIndex].id,
          image: cartItems[itemIndex].image,
          name: cartItems[itemIndex].name,
          size: cartItems[itemIndex].size,
          price: cartItems[itemIndex].price,
          quantity: cartItems[itemIndex].quantity + 1,
        );

        // Replace the old item with the updated one
        cartItems[itemIndex] = updatedItem;
      }
    });
  }

  void _handleDecreaseQuantity(String itemId) {
    setState(() {
      final itemIndex = cartItems.indexWhere((item) => item.id == itemId);
      if (itemIndex != -1 && cartItems[itemIndex].quantity > 1) {
        // Create a new CartItem with decreased quantity
        final updatedItem = CartItem(
          id: cartItems[itemIndex].id,
          image: cartItems[itemIndex].image,
          name: cartItems[itemIndex].name,
          size: cartItems[itemIndex].size,
          price: cartItems[itemIndex].price,
          quantity: cartItems[itemIndex].quantity - 1,
        );

        // Replace the old item with the updated one
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
    // Placeholder data - replace with actual cart data logic
    // Added unique IDs for Dismissible keys

    // Calculate totals based on the CartItem list
    final double subtotal =
        cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
    const double shipping = 20.00; // Example value
    const double discount = 10.00; // Example value
    final double total = subtotal + shipping - discount;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Mon panier',
        showBackButton: true,
        onBackButtonPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen())),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none_outlined),
            onPressed: () {
              // TODO: Navigate to notifications or handle tap
            },
          ),
        ],
      ),
      body: Column(children: [
        Expanded(
          // Use SingleChildScrollView directly to allow content scrolling if needed
          child: SingleChildScrollView(
            child: Column(
              children: [
                CartItemList(
                  items: cartItems,
                  onIncreaseQuantity: _handleIncreaseQuantity,
                  onDecreaseQuantity: _handleDecreaseQuantity,
                  onRemoveItem: _handleRemoveItem, // Added trailing comma
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
            // showReviewsAll(context, (scrollController) {
            //   return RemoveCartItemDialog(item: item, onConfirm: () {});
            // });
          },
        ),
      ]),
      // Checkout Button
    );
  }
}
