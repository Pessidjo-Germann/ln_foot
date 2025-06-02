import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date and currency formatting
import 'package:lnFoot_api/api.dart'; // For PaymentResponseDto
import 'package:ln_foot/screen/home_screen.dart'; // For navigation
import 'package:ln_foot/widgets/custom_button.dart'; // For the button
import 'package:ln_foot/theme/app_theme.dart'; // For kAppOrangeColor or other theme colors

class OrderConfirmationScreen extends StatelessWidget {
  final PaymentResponseDto paymentResponse;
  final String customerName;
  final double totalAmount;

  const OrderConfirmationScreen({
    super.key,
    required this.paymentResponse,
    required this.customerName,
    required this.totalAmount,
  });

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('dd/MM/yyyy HH:mm')
        .format(date); // Adjust format as needed
  }

  String _formatCurrency(double amount) {
    // Adjust for your specific currency and locale if needed
    return NumberFormat.currency(locale: 'fr_FR', symbol: 'XAF').format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation de Commande'),
        automaticallyImplyLeading: false, // No back button
        centerTitle: true,
        backgroundColor:
            Theme.of(context).primaryColor, // Or your app's theme color
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Make children take full width
          children: <Widget>[
            Icon(
              Icons.check_circle_outline,
              color: kAppOrangeColor, // Or Colors.green
              size: 80.0,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Paiement En cours !',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kAppOrangeColor, // Or Colors.green
                  ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Merci pour votre achat, $customerName !',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24.0),
            Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Récapitulatif de la Commande',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Divider(height: 20, thickness: 1),
                    // _buildInfoRow(context, 'ID de la Commande:', paymentResponse.orderId ?? 'N/A'),
                    //  _buildInfoRow(context, 'ID du Paiement:', paymentResponse.paymentId ?? 'N/A'),
                    _buildInfoRow(context, 'Statut du Paiement:',
                        paymentResponse.status ?? 'N/A'),
                    _buildInfoRow(context, 'Date:',
                        _formatDate(paymentResponse.createdAt)),
                    _buildInfoRow(
                        context, 'Montant Total:', _formatCurrency(totalAmount),
                        isAmount: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            CustomButton(
              text: 'OK',
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (Route<dynamic> route) => false, // Clears all routes
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value,
      {bool isAmount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: Text(label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500))),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: isAmount ? FontWeight.bold : FontWeight.normal,
                    color:
                        isAmount ? kAppOrangeColor : null, // Highlight amount
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
