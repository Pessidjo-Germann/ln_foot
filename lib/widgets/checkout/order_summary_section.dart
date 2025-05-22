import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lnFoot_api/api.dart'; // For currency formatting

class OrderSummarySection extends StatelessWidget {
  final List<OrderItemDto> orderItems;
  final double shippingFee = 0; // Frais de livraison gratuits par défaut

  const OrderSummarySection({
    super.key,
    required this.orderItems,
  });

  double get subtotal {
    return orderItems.fold(0, (sum, item) => sum + (item.price ?? 0) * (item.quantity ?? 1));
  }

  double get total => subtotal + shippingFee;

  // Helper to format currency (adjust locale and symbol as needed)
  String _formatCurrency(double amount) {
    // Consider making the locale and symbol configurable or get from app settings
    final format = NumberFormat.currency(locale: 'fr_FR', symbol: 'FCFA', decimalDigits: 2);
    return format.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        const Text(
          'Récapitulatif de la commande',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        // Summary Rows
        _buildSummaryRow(context, 'Sous-total', _formatCurrency(subtotal)),
        _buildSummaryRow(context, 'Frais de livraison', _formatCurrency(shippingFee)),
        const Divider(height: 24, thickness: 0.4, color: Colors.black12),
        _buildSummaryRow(context, 'Total', _formatCurrency(total), isTotal: true),
      ],
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value, {bool isTotal = false}) {
    final textTheme = Theme.of(context).textTheme;
    final labelStyle = textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700);
    final valueStyle = isTotal
        ? textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)
        : textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: labelStyle),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}
