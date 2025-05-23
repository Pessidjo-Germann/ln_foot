import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/blocs/network_bloc/network_bloc.dart';
import 'package:ln_foot/pages/offline_page.dart'; // Ensure this path is correct

class NetworkSensitiveNavigator {
  /// Checks the network state and navigates to [OfflinePage] if the device is offline.
  ///
  /// Returns `true` if navigation to the offline page occurred (i.e., device is offline),
  /// and `false` otherwise. This allows callers to conditionally stop further actions
  /// that require network connectivity.
  ///
  /// [context] must be a `BuildContext` that has access to `NetworkBloc` via `BlocProvider`.
  static bool navigateToOfflinePageIfNecessary(BuildContext context) {
    // Ensure NetworkBloc is available in the context
    // If not, this will throw an exception, which is a programming error
    // (NetworkBloc should be provided at a higher level in the widget tree).
    final networkState = context.read<NetworkBloc>().state;

    if (networkState is NetworkOffline) {
      // Check if the current route is already OfflinePage to prevent multiple pushes
      // This is a basic check; a more robust solution might involve checking route names
      // if you use named routes, or maintaining a flag in a service/bloc.
      bool isAlreadyOnOfflinePage = false;
      Navigator.popUntil(context, (route) {
        if (route.settings.name == '/offline' || (route is MaterialPageRoute && route.builder == (_) => const OfflinePage())) { // A simple check, might need refinement
          isAlreadyOnOfflinePage = true;
        }
        return true; // Continue popping, but we've captured the info
      });
      
      // A more direct way to check the top-most route without popping:
      // This requires ModalRoute.of(context) to be available and have settings.
      // final currentRoute = ModalRoute.of(context);
      // if (currentRoute?.settings.name == OfflinePage.routeName) { // Assuming OfflinePage has a routeName static const
      //   isAlreadyOnOfflinePage = true;
      // }


      if (!isAlreadyOnOfflinePage) {
         // It's often better to use pushReplacement to prevent building up a stack
         // if the user repeatedly attempts actions while offline.
         // Or, if OfflinePage should be a definitive block, pushAndRemoveUntil.
         // For now, using push to allow back navigation if that's desired from OfflinePage.
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const OfflinePage(),
            settings: const RouteSettings(name: '/offline'), // Assign a name for easier checking
          ),
        );
      }
      return true; // Navigated or already on offline page
    }
    return false; // Not offline, no navigation occurred
  }
}
