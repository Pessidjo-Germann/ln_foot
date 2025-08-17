import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:ln_foot/screen/home_screen.dart';

class DeepLinkService {
  static DeepLinkService? _instance;
  static DeepLinkService get instance => _instance ??= DeepLinkService._();
  
  DeepLinkService._();

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  // Initialize deep link handling
  Future<void> initialize(BuildContext context) async {
    // Handle app launch from deep link
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      _handleDeepLink(context, initialUri);
    }

    // Handle deep links while app is running
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (Uri uri) => _handleDeepLink(context, uri),
      onError: (err) {
        debugPrint('Deep link error: $err');
      },
    );
  }

  // Handle incoming deep links
  void _handleDeepLink(BuildContext context, Uri uri) {
    debugPrint('Received deep link: $uri');
    
    switch (uri.host) {
      case 'payment':
        _handlePaymentReturn(context, uri);
        break;
      case 'callback':
        _handleAuthCallback(context, uri);
        break;
      default:
        // Navigate to home for unhandled links
        _navigateToHome(context);
    }
  }

  // Handle payment return from payment service
  void _handlePaymentReturn(BuildContext context, Uri uri) {
    final status = uri.queryParameters['status'];
    final orderId = uri.queryParameters['orderId'];
    final paymentId = uri.queryParameters['paymentId'];

    debugPrint('Payment return - Status: $status, OrderId: $orderId, PaymentId: $paymentId');

    // Navigate to appropriate screen based on payment status
    if (status == 'success') {
      _showPaymentSuccessDialog(context, orderId);
    } else if (status == 'failed' || status == 'cancelled') {
      _showPaymentFailedDialog(context, status);
    } else {
      _navigateToHome(context);
    }
  }

  // Handle auth callback (existing functionality)
  void _handleAuthCallback(BuildContext context, Uri uri) {
    debugPrint('Auth callback received: $uri');
    // Your existing auth handling logic
  }

  // Show success dialog and navigate to orders
  void _showPaymentSuccessDialog(BuildContext context, String? orderId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 64,
          ),
          title: const Text('Paiement réussi !'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Votre paiement a été traité avec succès.'),
              if (orderId != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Commande #$orderId',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToHome(context);
              },
              child: const Text('Continuer'),
            ),
          ],
        );
      },
    );
  }

  // Show failure dialog
  void _showPaymentFailedDialog(BuildContext context, String? status) {
    final isFailure = status == 'failed';
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Icon(
            isFailure ? Icons.error : Icons.cancel,
            color: isFailure ? Colors.red : Colors.orange,
            size: 64,
          ),
          title: Text(isFailure ? 'Paiement échoué' : 'Paiement annulé'),
          content: Text(
            isFailure 
              ? 'Une erreur est survenue lors du traitement de votre paiement.'
              : 'Vous avez annulé le paiement.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToHome(context);
              },
              child: const Text('Retour'),
            ),
          ],
        );
      },
    );
  }

  // Navigate to home and clear stack
  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  // Dispose resources
  void dispose() {
    _linkSubscription?.cancel();
  }

  // Generate payment return URLs for your payment service
  static String getPaymentSuccessUrl() {
    return 'com.lnfoot://payment?status=success&orderId={orderId}&paymentId={paymentId}';
  }

  static String getPaymentFailureUrl() {
    return 'com.lnfoot://payment?status=failed&orderId={orderId}';
  }

  static String getPaymentCancelUrl() {
    return 'com.lnfoot://payment?status=cancelled&orderId={orderId}';
  }

  // Alternative HTTP URLs (if your payment service supports them)
  static String getHttpPaymentSuccessUrl() {
    return 'https://lnfoot.com/payment/success?orderId={orderId}&paymentId={paymentId}';
  }

  static String getHttpPaymentFailureUrl() {
    return 'https://lnfoot.com/payment/failed?orderId={orderId}';
  }

  static String getHttpPaymentCancelUrl() {
    return 'https://lnfoot.com/payment/cancelled?orderId={orderId}';
  }
}