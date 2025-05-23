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
        listener: (context, state) async{
          if (state is Authenticated) {
            context.read<AuthBloc>().add(CheckToken());
          }else if(state is AuthenticatedWithToken ){
            // Set the token in the ApiClient
            // widget.apiClient.setAuthToken(state.token);
            // Navigate to HomeScreen
            _navigateOnce(const HomeScreen());
          }
          else if (state is AuthError) {
            // Show error message
            debugPrint('AuthError: ${state.message}');
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text('Erreur de connexion: ${state.message}')),
              );
          _navigateOnce(OnboardingScreen(
              apiClient: widget.apiClient,
            ));
          } 
          
          
           else if (state is Unauthenticated) {
            _navigateOnce(OnboardingScreen(
              apiClient: widget.apiClient,
            ));
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
