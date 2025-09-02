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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
          Text(
            'Déconnexion',
            textAlign: TextAlign.center,
            style:
                textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          const Divider(thickness: 0.4),
          const SizedBox(height: 16.0),
          Text(
            isLoggingOut
                ? 'Déconnexion en cours...'
                : 'Etes vous sur de vouloir vous déconnecter ?',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge,
          ),
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
          const SizedBox(height: 14.0),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Annulé',
                  onPressed: isLoggingOut ? () {} : onCancel,
                  buttonColor: Colors.grey[200],
                  textColor: isLoggingOut ? Colors.grey : Colors.black87,
                ),
              ),
              const SizedBox(width: 6.0),
              Expanded(
                child: CustomButton(
                  text: isLoggingOut ? 'Déconnexion...' : 'Oui, Déconnexion',
                  onPressed: isLoggingOut ? () {} : onConfirm,
                  buttonColor: isLoggingOut ? Colors.grey : Colors.red,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

void showLogoutDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    
    backgroundColor: Colors.transparent,
    builder: (BuildContext bc) {
      return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return LoginOptionsScreen();
            }));
          } else if (state is AuthError) {
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
                if (state is! AuthLoggingOut) {
                  context.read<AuthBloc>().add(LogoutRequested());
                }
              },
              onCancel: () {
                if (state is! AuthLoggingOut) {
                  Navigator.of(context).pop();
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
