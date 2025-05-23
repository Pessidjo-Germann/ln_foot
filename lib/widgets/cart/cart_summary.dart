import 'package:flutter/material.dart';
 
class CartSummary extends StatelessWidget {
  final double subtotal;
  final double shipping;
  final double discount;
  final double total;

  const CartSummary({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.total,
  });

  // Helper for currency formatting (adjust locale and symbol as needed)
  String _formatCurrency(double amount) {
    // Using a simple approach here. Consider using a dedicated currency formatting package
    // or Intl for more robust localization. Assuming FCFA for now.
    // final format = NumberFormat.currency(locale: 'fr_FR', symbol: 'FCFA', decimalDigits: 0);
    // return format.format(amount);
    // Simple formatting for now:
    return amount.toStringAsFixed(2); // Match the image format ($XX.XX)
                                          // The image uses $, but the item price uses FCFA.
                                          // Using $ for consistency with the summary in the image.
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          _buildSummaryRow(
            context,
            label: 'Sous-total',
            value: 'FCFA${_formatCurrency(subtotal)}',
          ),
          _buildSummaryRow(
            context,
            label: 'Frais de livraison',
            value: 'FCFA ${_formatCurrency(shipping)}',
          ),
          _buildSummaryRow(
            context,
            label: 'Rabais',
            // Display discount as negative
            value: discount > 0 ? '-FCFA ${_formatCurrency(discount)}' : 'FCFA 0.00',
          ),
          const Divider(height: 16, thickness: 0.4),
          _buildSummaryRow(
            context,
            label: 'Total',
            value: 'FCFA ${_formatCurrency(total)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  // Helper method moved inside the class
  Widget _buildSummaryRow(BuildContext context, {required String label, required String value, bool isTotal = false}) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
    );
    final labelStyle = textStyle?.copyWith(color: Colors.grey[700]);
    final valueStyle = textStyle?.copyWith(color: Colors.black);


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
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
