import 'package:flutter/material.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_wifi_off,
              size: 80,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 24),
            const Text(
              'Pas de connexion Internet',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Veuillez vérifier votre connexion et réessayer',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Vous pouvez déclencher une vérification de la connexion ici si nécessaire
                // Par exemple: context.read<NetworkBloc>().add(CheckNetworkConnectivity());
              },
              child: const Text('Réessayer'),
            ),
          ],
        ),
      ),
    );
  }
}
