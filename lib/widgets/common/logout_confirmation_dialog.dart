import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/auth/auth_bloc.dart';
import 'package:ln_foot/screen/login_options_screen.dart';
import '../custom_button.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final bool isLoggingOut;

  const LogoutConfirmationDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
    this.isLoggingOut = false,
  });

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery for responsive padding and potential theme access
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    // final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: theme.cardColor, // Or specific background color if needed
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Make column height fit content
        crossAxisAlignment:
            CrossAxisAlignment.stretch, // Stretch items horizontally
        children: [
          // Optional: Add a drag handle indicator
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),

          // Title
          Text(
            'Déconnexion',
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold), // Adjust style as needed
          ),
          const SizedBox(height: 16.0),

          // Divider
          const Divider(thickness: 0.4),
          const SizedBox(height: 16.0),

          // Confirmation Message
          Text(
            isLoggingOut 
                ? 'Déconnexion en cours...' 
                : 'Etes vous sur de vouloir vous déconnecter ?',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge, // Adjust style as needed
          ),
          
          // Indicateur de chargement si en cours de déconnexion
          if (isLoggingOut) ...[
            const SizedBox(height: 16.0),
            const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ],
          const SizedBox(height: 24.0),

          // Action Buttons
          Row(
            children: [
              // Cancel Button
              Expanded(
                child: CustomButton(
                  text: 'Annulé',
                  onPressed: isLoggingOut ? () {} : onCancel, // Désactiver si en cours
                  // Use light/grey style for cancel
                  buttonColor: Colors.grey[200],
                  textColor: isLoggingOut ? Colors.grey : Colors.black87,
                ),
              ),
              const SizedBox(width: 16.0), // Spacing between buttons

              // Confirm Button
              Expanded(
                child: CustomButton(
                  text: isLoggingOut ? 'Déconnexion...' : 'Oui, Déconnexion',
                  onPressed: isLoggingOut ? () {} : onConfirm, // Fonction vide si en cours
                  // Use primary/red style for confirm
                  buttonColor: isLoggingOut ? Colors.grey : Colors.red,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0), // Bottom padding
        ],
      ),
    );
  }
}

// Example Usage (How you might show it using showModalBottomSheet):

void showLogoutDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Important for content-sized bottom sheets
    backgroundColor: Colors.transparent, // Make sheet background transparent
    builder: (BuildContext bc) {
      return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return LoginOptionsScreen();
            }));
          } else if (state is AuthError) {
            // Afficher un message d'erreur mais continuer la déconnexion
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.orange,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return LogoutConfirmationDialog(
              onConfirm: () {
                // Ne fermer le dialog que si on n'est pas en cours de déconnexion
                if (state is! AuthLoggingOut) {
                  context.read<AuthBloc>().add(LogoutRequested());
                  // Ne pas fermer tout de suite pour montrer l'indicateur de chargement
                }
              },
              onCancel: () {
                // Permettre l'annulation seulement si on n'est pas en cours de déconnexion
                if (state is! AuthLoggingOut) {
                  Navigator.of(context).pop(); // Close bottom sheet
                }
              },
              isLoggingOut: state is AuthLoggingOut,
            );
          },
        ),
      );
    },
  );
}
