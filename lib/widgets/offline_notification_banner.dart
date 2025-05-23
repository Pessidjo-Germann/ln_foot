import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/blocs/network_bloc/network_bloc.dart';

class OfflineNotificationBanner extends StatelessWidget {
  const OfflineNotificationBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is NetworkOffline) {
          return MaterialBanner(
            padding: const EdgeInsets.all(8),
            content: const Text(
              'You are currently offline. Please check your internet connection.',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red.shade700,
            leading: const Icon(Icons.signal_wifi_off, color: Colors.white),
            actions: const [
              // Optionally, add an action like a dismiss button if needed,
              // but for a network banner, it usually stays until online.
              SizedBox.shrink(), // Placeholder if no actions are desired
            ],
          );
        } else {
          // When online or in any other state, show nothing.
          // Using MaterialBanner with visible: false or SizedBox.shrink()
          // MaterialBanner needs to be a descendant of Scaffold to use showMaterialBanner.
          // For direct inclusion, we can return an empty container.
          return const SizedBox.shrink();
        }
      },
    );
  }
}
