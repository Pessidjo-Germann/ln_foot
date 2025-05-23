import 'package:flutter/material.dart';
 
class OfflinePage extends StatelessWidget {
  const OfflinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.wifi_off,
                size: 100,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 24),
              Text(
                'You are offline',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Please check your internet connection and try again.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Retry Connection'),
                onPressed: () {
                  // Attempt to re-check connectivity by adding an event to NetworkBloc
                  // This assumes NetworkBloc handles a manual check or re-triggers its current check.
                  // For a more direct re-check, NetworkBloc might need a specific event.
                  // For now, we can try re-adding the last known event or a generic "CheckConnectivity" event.
                  // A simple way is to re-trigger the initial check logic if available.
                  // The NetworkBloc currently has _checkInitialConnectivity which is private.
                  // We can add a new event to NetworkBloc for this.
                  // For now, let's just print a message.
                  // A more robust solution would be to add a specific event like "ManualCheckRequested" to NetworkBloc.

                  // Example: Dispatch an event to NetworkBloc if it's set up to handle it.
                  // BlocProvider.of<NetworkBloc>(context).add(NetworkCheckRequested());
                  // Since NetworkBloc re-checks on listen, we can just print a message for now.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Checking for connection... (Not implemented yet)')),
                  );
                  // Actual retry logic to be implemented, possibly by interacting with NetworkBloc
                  // or a specific app refresh mechanism.
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
