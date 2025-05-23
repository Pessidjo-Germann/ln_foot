part of 'network_bloc.dart';

abstract class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object> get props => [];
}

class NetworkOnline extends NetworkState {}

class NetworkOffline extends NetworkState {}
