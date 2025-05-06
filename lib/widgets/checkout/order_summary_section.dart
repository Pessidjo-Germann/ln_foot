import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For currency formatting

class OrderSummarySection extends StatelessWidget {
  final double subtotal;
  final double shippingFee;
  final double discount;
  final double total;

  const OrderSummarySection({
    super.key,
    required this.subtotal,
    required this.shippingFee,
    required this.discount,
    required this.total,
  });

  // Helper to format currency (adjust locale and symbol as needed)
  String _formatCurrency(double amount) {
    // Consider making the locale and symbol configurable or get from app settings
    final format = NumberFormat.currency(locale: 'fr_FR', symbol: '\$', decimalDigits: 2);
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
        _buildSummaryRow(context, 'Total', _formatCurrency(subtotal)),
        _buildSummaryRow(context, 'Frais de livraison', _formatCurrency(shippingFee)),
        _buildSummaryRow(context, 'Rabais', '-${_formatCurrency(discount)}'), // Show discount as negative
        const Divider(height: 24,thickness: 0.4, color: Colors.black12),
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
