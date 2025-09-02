import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lnFoot_api/api.dart';
import 'package:ln_foot/bloc/order/order_bloc.dart';
import 'package:ln_foot/model/order_status.dart';
import 'package:ln_foot/theme/app_theme.dart';
import 'package:ln_foot/widgets/custom_app_bar.dart';
import 'package:ln_foot/widgets/custom_button.dart';
import 'package:ln_foot/user_session_manager.dart';
import 'package:ln_foot/service/deep_link_service.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderDto order;

  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  Map<String, dynamic>? _userInfo;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final data = await UserSessionManager.getUserInfo();
    setState(() {
      _userInfo = data;
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  String _formatCurrency(num? amount) {
    if (amount == null) return '0 XAF';
    return NumberFormat.currency(locale: 'fr_FR', symbol: 'XAF').format(amount);
  }

  Future<void> _proceedToPayment() async {
    if (_userInfo == null) return;

    setState(() {
      _isLoading = true;
    });

    final customer = Customer(
      name: _userInfo!['name'] ?? '',
      email: _userInfo!['email'] ?? '',
      phone: _userInfo!['phone_number'] ?? '',
    );

    context.read<OrderBloc>().add(
      ConfirmOrder(
        orderId: widget.order.id!,
        customer: customer,
        callbackUrl: DeepLinkService.getPaymentCallbackUrl(),
      ),
    );
  }

  Future<void> _openPaymentUrl(String paymentUrl) async {
    final uri = Uri.parse(paymentUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderStatus = parseOrderStatus(widget.order.status);
    
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Détails de la commande',
        showBackButton: true,
        onBackButtonPressed: () => Navigator.pop(context),
      ),
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderConfirmed) {
            setState(() {
              _isLoading = false;
            });
            
            if (state.paymentResponse.paymentPageUrl != null &&
                state.paymentResponse.paymentPageUrl!.isNotEmpty) {
              _openPaymentUrl(state.paymentResponse.paymentPageUrl!);
            }
          } else if (state is OrderError) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is OrderLoading) {
            setState(() {
              _isLoading = true;
            });
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Status Card
              _buildStatusCard(orderStatus),
              const SizedBox(height: 20),
              
              // Order Info Card
              _buildOrderInfoCard(),
              const SizedBox(height: 20),
              
              // Order Items Card
              _buildOrderItemsCard(),
              const SizedBox(height: 20),
              
              // Total Card
              _buildTotalCard(),
              const SizedBox(height: 30),
              
              // Action Buttons
              _buildActionButtons(orderStatus),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard(OrderStatus status) {
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case OrderStatus.created:
      case OrderStatus.paymentPending:
        statusColor = Colors.orange;
        statusIcon = Icons.pending;
        break;
      case OrderStatus.paid:
      case OrderStatus.processing:
        statusColor = Colors.blue;
        statusIcon = Icons.autorenew;
        break;
      case OrderStatus.shipped:
        statusColor = Colors.purple;
        statusIcon = Icons.local_shipping;
        break;
      case OrderStatus.delivered:
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case OrderStatus.cancelled:
      case OrderStatus.failed:
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(statusIcon, color: statusColor, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Statut de la commande',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    status.displayName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informations de la commande',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
           // _buildInfoRow('ID de commande', widget.order.id ?? 'N/A'),
            _buildInfoRow('Date de commande', _formatDate(widget.order.orderDate)),
            if (widget.order.deliveryAddress != null)
              _buildInfoRow('Adresse de livraison', widget.order.deliveryAddress!),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Articles commandés',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            ...widget.order.orderItems.map((item) => _buildOrderItem(item)),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(OrderItemDto item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.shopping_bag, color: Colors.grey[400]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Article', // You might want to fetch product name
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (item.size != null)
                  Text(
                    'Taille: ${item.size}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                Text(
                  'Quantité: ${item.quantity ?? 1}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Text(
            _formatCurrency(item.price),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Récapitulatif',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            if (widget.order.deliveryFee != null)
              _buildInfoRow('Frais de livraison', _formatCurrency(widget.order.deliveryFee)),
            _buildInfoRow(
              'Total',
              _formatCurrency(widget.order.totalAmount),
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isTotal ? kAppOrangeColor : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(OrderStatus status) {
    return Column(
      children: [
        // Payment button for unpaid orders
        if (status.requiresPayment)
          CustomButton(
            text: 'Procéder au paiement',
            isLoading: _isLoading,
            onPressed: _proceedToPayment,
          ),
        
        if (status.requiresPayment)
          const SizedBox(height: 16),
        
        // Cancel button for cancellable orders
        if (status.canBeCancelled)
          OutlinedButton(
            onPressed: () {
              // TODO: Implement cancel order functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fonctionnalité d\'annulation à implémenter'),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              side: const BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              'Annuler la commande',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}