import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  NetworkBloc({required Connectivity connectivity})
      : _connectivity = connectivity,
        super(NetworkOffline()) { // Initial state can be determined by a check or default to offline
    on<NetworkStatusChanged>(_onNetworkStatusChanged);

    // Subscribe to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      add(NetworkStatusChanged(result));
    });

    // Optionally, check initial connectivity status
    _checkInitialConnectivity();
  }

  void _checkInitialConnectivity() async {
    final List<ConnectivityResult> connectivityResult = await _connectivity.checkConnectivity();
    add(NetworkStatusChanged(connectivityResult));
  }

  void _onNetworkStatusChanged(NetworkStatusChanged event, Emitter<NetworkState> emit) {
    // Helper to check if any of the results indicate an online state
    bool isOnline(List<ConnectivityResult> results) {
      return results.contains(ConnectivityResult.mobile) ||
             results.contains(ConnectivityResult.wifi) ||
             results.contains(ConnectivityResult.ethernet) ||
             results.contains(ConnectivityResult.vpn);
    }

    if (isOnline(event.connectivityResult)) {
      emit(NetworkOnline());
    } else if (event.connectivityResult.contains(ConnectivityResult.none)) {
      emit(NetworkOffline());
    } else {
      // Handle other cases like bluetooth or 'other' as offline, or log them.
      // For simplicity, mapping to NetworkOffline here.
      // You could also introduce an NetworkUnknown state if needed.
      print('NetworkBloc: Unhandled connectivity result - ${event.connectivityResult}, defaulting to Offline.');
      emit(NetworkOffline());
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
