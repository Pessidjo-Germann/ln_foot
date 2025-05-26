import 'package:flutter/material.dart';
import 'package:lnFoot_api/api.dart';
import 'package:ln_foot/screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  final ApiClient apiClient;
  const SplashScreen({super.key, required this.apiClient});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 7), () {
      if (!_navigated && mounted) {
        _navigated = true;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => OnboardingScreen(apiClient: widget.apiClient),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.secondary;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Image.asset(
          'images/ln_foot.jpg',
          width: 150,
        ),
      ),
    );
  }
}
