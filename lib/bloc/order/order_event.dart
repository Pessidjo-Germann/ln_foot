part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

// Event to load all orders (potentially for admin)
class LoadAllOrders extends OrderEvent {
  final String
      userId; // Assuming admin needs to specify user, or maybe not needed depending on API

  const LoadAllOrders({required this.userId});

  @override
  List<Object?> get props => [userId];
}

// Event to load orders for the current user
class LoadUserOrders extends OrderEvent {
  final String userId;

  const LoadUserOrders({required this.userId});

  @override
  List<Object?> get props => [userId];
}

// Event to load a single order by ID
class LoadOrderById extends OrderEvent {
  final String orderId;

  const LoadOrderById({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

// Event to create a new order
class CreateOrder extends OrderEvent {
  final OrderDto orderData;

  const CreateOrder({required this.orderData});

  @override
  List<Object?> get props => [orderData];
}

// Event to update an existing order
class UpdateOrder extends OrderEvent {
  final String orderId;
  final OrderDto orderData;

  const UpdateOrder({required this.orderId, required this.orderData});

  @override
  List<Object?> get props => [orderId, orderData];
}

// Event to delete an order
class DeleteOrder extends OrderEvent {
  final String orderId;

  const DeleteOrder({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}
