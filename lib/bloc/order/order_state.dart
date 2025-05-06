part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

// State for when multiple orders are loaded
class OrdersLoaded extends OrderState {
  final List<OrderDto> orders;

  const OrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

// State for when a single order is loaded
class OrderLoaded extends OrderState {
  final OrderDto order;

  const OrderLoaded(this.order);

  @override
  List<Object?> get props => [order];
}

// State for successful order creation
class OrderCreated extends OrderState {
  final OrderDto order;

  const OrderCreated(this.order);

  @override
  List<Object?> get props => [order];
}

// State for successful order update
class OrderUpdated extends OrderState {
  final OrderDto order;

  const OrderUpdated(this.order);

  @override
  List<Object?> get props => [order];
}

// State for successful order deletion
class OrderDeleted extends OrderState {}

// State for errors
class OrderError extends OrderState {
  final String message;

  const OrderError(this.message);

  @override
  List<Object?> get props => [message];
}
