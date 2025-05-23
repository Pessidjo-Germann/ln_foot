import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ln_foot/bloc/auth/auth_bloc.dart';
import 'package:ln_foot/screen/home_screen.dart';

import 'package:ln_foot/widgets/custom_app_bar.dart';
import 'package:ln_foot/widgets/custom_button.dart';

class LoginOptionsScreen extends StatefulWidget {
  // Nouveau constructeur sans apiClient
   LoginOptionsScreen({super.key});

  @override
  State<LoginOptionsScreen> createState() => _LoginOptionsScreenState();
}

class _LoginOptionsScreenState extends State<LoginOptionsScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(() {
            isLoading = true;
          });
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Connexion en cours...')),
            );
        } else if (state is Authenticated) {
          setState(() {
            isLoading = false;
          });
          //  ScaffoldMessenger.of(context)
          //   ..hideCurrentSnackBar()
          //   ..showSnackBar(
          //     SnackBar(content: Text('Erreur de connexion: ${state.user}')),
          //   );
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (Route<dynamic> route) => false,
          );
        } else if (state is AuthenticatedWithToken) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
           
        } else if (state is AuthError) {
          // Afficher le message d'erreur
          debugPrint('AuthError: ${state.message}');
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Erreur de connexion: ${state.message}')),
            );
          // Si l'erreur est critique (par exemple, refresh token expiré),
          // AuthBloc aura déjà émis Unauthenticated et AuthWrapper aura redirigé vers cette page.
        } else if (state is Unauthenticated) {
          // Si on est déjà sur l'écran de login et on reçoit Unauthenticated,
          // cela confirme qu'on doit rester ici. On peut cacher un éventuel snackbar de chargement.
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'Connexion sur LNSHOP',
          showBackButton: false,
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Image.asset(
                  'images/Add to Cart-cuate 1.png',
                ),
                const SizedBox(height: 32),
                CustomButton(
                  isLoading: isLoading,
                  text: 'Connexion par mail',
                  onPressed: () {
                    context.read<AuthBloc>().add(LoginRequested());
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
