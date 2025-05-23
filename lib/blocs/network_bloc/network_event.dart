part of 'network_bloc.dart';

abstract class NetworkEvent extends Equatable {
  const NetworkEvent();

  @override
  List<Object> get props => [];
}

class NetworkStatusChanged extends NetworkEvent {
  final List<ConnectivityResult> connectivityResult;

  const NetworkStatusChanged(this.connectivityResult);

  @override
  List<Object> get props => [connectivityResult];
}
