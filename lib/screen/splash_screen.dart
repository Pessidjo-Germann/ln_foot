import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/auth/auth_bloc.dart';
import 'package:ln_foot/screen/home_screen.dart';
import 'package:ln_foot/screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    // Déclenche la vérification du token stocké au démarrage
    context.read<AuthBloc>().add(CheckTokenStored());
  }

  void _navigateOnce(Widget page) {
    if (_navigated) return;
    _navigated = true;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.secondary;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            _navigateOnce(const HomeScreen());
          } else if (state is Unauthenticated) {
            _navigateOnce(const OnboardingScreen());
          }
        },
        child: Center(
          child: Image.asset(
            'images/LNFOOT2 1.png',
            width: 150,
          ),
        ),
      ),
    );
  }
}
