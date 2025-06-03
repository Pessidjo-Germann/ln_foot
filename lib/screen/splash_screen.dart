import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnFoot_api/api.dart';
import 'package:ln_foot/bloc/auth/auth_bloc.dart';
import 'package:ln_foot/screen/home_screen.dart';
import 'package:ln_foot/screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  final ApiClient apiClient;
  const SplashScreen({super.key, required this.apiClient});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _navigated = false;
  Timer? _timeoutTimer;

  @override
  void initState() {
    super.initState();
    // Déclenche la vérification du token stocké au démarrage
    context.read<AuthBloc>().add(CheckTokenStored());

    // Timer de sécurité au cas où l'auth ne répond pas
    _timeoutTimer = Timer(const Duration(seconds: 10), () {
      if (!_navigated && mounted) {
        _navigateOnce(OnboardingScreen(apiClient: widget.apiClient));
      }
    });
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  void _navigateOnce(Widget page) {
    if (_navigated) return;
    _navigated = true;
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => page),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.secondary;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated || state is AuthenticatedWithToken) {
            _navigateOnce(const HomeScreen());
          } else if (state is AuthError || state is Unauthenticated) {
            if (state is AuthError) {
              debugPrint('AuthError: ${state.message}');
            }
            _navigateOnce(OnboardingScreen(apiClient: widget.apiClient));
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/LNFOOT2 1.jpg',
                width: 150,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
