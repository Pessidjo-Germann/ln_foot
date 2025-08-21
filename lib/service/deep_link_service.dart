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
    final reference = uri.queryParameters['reference'];
    final ref = uri.queryParameters['ref'];

    debugPrint('Payment return - Status: $status, Reference: $reference, Ref: $ref');

    // Navigate to appropriate screen based on payment status
    if (status == 'complete' || status == 'success') {
      _showPaymentSuccessDialog(context, ref, reference);
    } else if (status == 'failed' || status == 'cancelled' || status == 'error') {
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
  void _showPaymentSuccessDialog(BuildContext context, String? ref, String? reference) {
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
              if (ref != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Commande #$ref',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
              if (reference != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Référence: $reference',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
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
  // Provide a simple callback URL - the payment service will add the query parameters
  static String getPaymentCallbackUrl() {
    return 'com.lnfoot://payment';
  }

  // Alternative HTTP URL (if your payment service supports them)
  static String getHttpPaymentCallbackUrl() {
    return 'https://lnfoot.com/payment/callback';
  }

  // The payment service will automatically add query parameters like:
  // Success: com.lnfoot://payment?reference=uyi&status=complete&ref=order_123
  // Failed:  com.lnfoot://payment?reference=uyi&status=failed&ref=order_123
  // Cancelled: com.lnfoot://payment?reference=uyi&status=cancelled&ref=order_123
}