import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ln_foot/bloc/auth/auth_bloc.dart';
import 'package:ln_foot/screen/home_screen.dart';

import 'package:ln_foot/widgets/custom_app_bar.dart';
import 'package:ln_foot/widgets/custom_button.dart';

class LoginOptionsScreen extends StatelessWidget {
  // Retire la propriété apiClient car elle n'est plus nécessaire ici
  // final ApiClient apiClient;
  // const LoginOptionsScreen({super.key, required this.apiClient}); // Retire apiClient du constructeur aussi
  const LoginOptionsScreen({super.key}); // Nouveau constructeur sans apiClient

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Connexion en cours...')),
            );
        } else if (state is Authenticated) {
          //  ScaffoldMessenger.of(context)
          //   ..hideCurrentSnackBar()
          //   ..showSnackBar(
          //     SnackBar(content: Text('Erreur de connexion: ${state.user}')),
          //   );
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (Route<dynamic> route) => false,
          );

          // NE PAS NAVIGUER ICI. Le AuthWrapper s'en charge.
          // context.read<AuthBloc>().add(CheckToken()); // Cette ligne est inutile et doit être retirée
        } else if (state is AuthenticatedWithToken) {
          // Similaire à Authenticated. Le AuthWrapper gère la navigation.
          // Cette condition est moins probable si Authenticated est toujours émis en premier.
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          // NE PAS NAVIGUER ICI.
          // apiClient.setAuthToken(state.token); // Cette ligne est redondante, la supprimer
          // Navigator.of(context).pushAndRemoveUntil(...) // La navigation est gérée par AuthWrapper
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
