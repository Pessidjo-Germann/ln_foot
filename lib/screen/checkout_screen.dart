import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnFoot_api/api.dart';
import 'package:ln_foot/bloc/order/order_bloc.dart';

import 'package:ln_foot/user_session_manager.dart';
import 'package:ln_foot/widgets/custom_app_bar.dart';
import 'package:ln_foot/widgets/custom_button.dart';
// Import the newly created widgets
import 'package:ln_foot/widgets/checkout/address_section.dart';
import 'package:ln_foot/widgets/checkout/payment_method_section.dart';
import 'package:ln_foot/widgets/checkout/order_summary_section.dart';
// import 'package:ln_foot/widgets/checkout/payment_success_dialog.dart'; // No longer needed
import 'package:ln_foot/screen/order_confirmation_screen.dart'; // Import OrderConfirmationScreen

class CheckoutScreen extends StatefulWidget {
  final OrderDto orderDto;
  const CheckoutScreen({super.key, required this.orderDto});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserInfo();
  }

  Map<String, dynamic> _userInfo = {};

  Future<void> _loadUserInfo() async {
    final data = await UserSessionManager.getUserInfo();
    setState(() {
      _userInfo = data!;
    });
  }

  // Default selection
  bool _initialized = false;
  bool isLoading = false;
  String phone = '';
  String nom = '';
  String email = '';
  String address = '';
  void _initUserData(Map<String, dynamic> user) {
    if (_initialized) return;
    nom = user['name'] ?? '';
    email = user['email'] ?? '';

    phone = user['phone_number'] ?? '';

    _initialized = true;
  }

  // void _showSuccessDialog() { // Removed
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false, // Prevent closing by tapping outside
  //     builder: (BuildContext context) {
  //       // Use the dedicated PaymentSuccessDialog widget
  //       return PaymentSuccessDialog(
  //         onTrackOrderPressed: () {
  //           // TODO: Implement actual navigation to order tracking screen
  //           print("Navigate to track order screen");
  //         },
  //       );
  //     },
  //   );
  // }

  double _calculateTotalAmount() {
    if (widget.orderDto.orderItems.isEmpty) {
      return 0.0;
    }
    return widget.orderDto.orderItems.fold(0.0, (sum, item) {
      return sum + ((item.price ?? 0.0) * (item.quantity ?? 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    _initUserData(_userInfo);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Vérification',
        onBackButtonPressed: Navigator.of(context).pop,
        actions: [
          IconButton(
            icon: const Icon(
                Icons.notifications_none_outlined), // Placeholder icon
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use AddressSection Widget
            AddressSection(
              name: nom,
              email: email,
              address: address,
              onChangePressed: () {
                // Cette fonction n'est plus nécessaire mais conservée pour la rétrocompatibilité
              },
              onAddressUpdated: (newName, newEmail, newAddress) {
                setState(() {
                  nom = newName;
                  email = newEmail;
                  address = newAddress;
                });
              },
            ),
            const SizedBox(height: 24),

            // Use PaymentMethodSection Widget
            PaymentMethodSection(
              onPhoneUpdated: (phone) {
                setState(() {
                  this.phone = phone;
                });
              },
            ),
            const SizedBox(height: 24),

            // Use OrderSummarySection Widget
            OrderSummarySection(
             orderItems: widget.orderDto.orderItems,// Example data
            ),
            const SizedBox(height: 30), // Space before bottom button
          ],
        ),
      ),
      bottomNavigationBar: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderConfirmed) {
            setState(() {
              isLoading = false;
            });
            
            // Calculate total amount
            final double totalAmount = _calculateTotalAmount(); 
            // final String customerName = nom; // 'nom' is already available

            // Navigate to OrderConfirmationScreen
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => OrderConfirmationScreen(
                  paymentResponse: state.paymentResponse,
                  customerName: nom, // 'nom' from _CheckoutScreenState
                  totalAmount: totalAmount,
                ),
              ),
              (Route<dynamic> route) => false, // Clear all routes before pushing confirmation
            );

          } else if (state is OrderError) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is OrderLoading) {
            setState(() {
              isLoading = true;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomButton(
            text: 'Passer la commande',
            isLoading: isLoading,
            onPressed: () {
              debugPrint("""
                  OrderDto: ${widget.orderDto.id!}
                  Customer: ${Customer(name: nom, phone: "+237$phone", email: email).toJson()}
                  """);

              context.read<OrderBloc>().add(ConfirmOrder(
                  orderId: widget.orderDto.id!,
                  customer:
                      Customer(name: nom, phone: "+237$phone", email: email)));
            },
          ),
        ),
      ),
    );
  }

  // --- Placeholder build methods removed ---
}
