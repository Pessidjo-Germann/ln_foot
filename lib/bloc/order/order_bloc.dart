import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lnFoot_api/api.dart'; // Import depuis le package API lnFoot_api

import 'package:ln_foot/constants/error_messages.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  // Injection DIRECTE du contrôleur API
  final OrderControllerApi orderControllerApi;

  OrderBloc({required this.orderControllerApi}) : super(OrderInitial()) {
    on<LoadAllOrders>(_onLoadAllOrders);
    on<LoadUserOrders>(_onLoadUserOrders);
    on<LoadOrderById>(_onLoadOrderById);
    on<CreateOrder>(_onCreateOrder);
    on<UpdateOrder>(_onUpdateOrder);
    on<DeleteOrder>(_onDeleteOrder);
    on<ConfirmOrder>(_onConfirmOrder);
  }

  Future<void> _onLoadAllOrders(
      LoadAllOrders event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      // Note: L'API getAllOrders prend un userId. Assurez-vous que c'est le comportement attendu.
      final orders = await orderControllerApi.getAllOrders();
      emit(OrdersLoaded(orders ?? []));
    } on ApiException catch (e) {
      emit(OrderError(e.message??''));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> _onLoadUserOrders(
      LoadUserOrders event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      final orders = await orderControllerApi.getUserOrders();
      emit(OrdersLoaded(orders ?? []));
    } on ApiException catch (e) {
      emit(OrderError(e.message??''));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> _onConfirmOrder(
      ConfirmOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      final paymentResponse =
          await orderControllerApi.confirmOrder(event.orderId, event.customer);
      emit(OrderConfirmed(paymentResponse!));
    } on ApiException {
      emit(OrderError(ErrorMessages.orderUpdateFailed));
    } catch (e) {
      emit(OrderError(ErrorMessages.orderUpdateFailed));
    }
  }

  Future<void> _onLoadOrderById(
      LoadOrderById event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      final order = await orderControllerApi.getOrderById(event.orderId);
      if (order != null) {
        emit(OrderLoaded(order));
      } else {
        emit(const OrderError('Order not found.'));
      }
    } on ApiException {
      emit(OrderError(ErrorMessages.orderUpdateFailed));
    } catch (e) {
      emit(OrderError(ErrorMessages.unknownError));
    }
  }

  Future<void> _onCreateOrder(
      CreateOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      final createdOrder =
          await orderControllerApi.createOrder(event.orderData);
      if (createdOrder != null) {
        emit(OrderCreated(createdOrder));
        // Optionnel: Recharger les commandes de l'utilisateur après création
        // add(LoadUserOrders(userId: event.orderData.userId!)); // Assurez-vous que userId est disponible
      } else {
        emit(const OrderError('Order creation failed silently.'));
      }
    } on ApiException catch (e) {
      emit(OrderError(e.message??''));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> _onUpdateOrder(
      UpdateOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      final updatedOrder =
          await orderControllerApi.updateOrder(event.orderId, event.orderData);
      if (updatedOrder != null) {
        emit(OrderUpdated(updatedOrder));
        // Optionnel: Recharger les commandes de l'utilisateur après mise à jour
        // add(LoadUserOrders(userId: event.orderData.userId!)); // Assurez-vous que userId est disponible
      } else {
        emit(OrderError(ErrorMessages.orderUpdateFailed));
      }
    } on ApiException {
      emit(OrderError(ErrorMessages.orderUpdateFailed));
    } catch (e) {
      emit(OrderError(ErrorMessages.unknownError));
    }
  }

  Future<void> _onDeleteOrder(
      DeleteOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      await orderControllerApi.deleteOrder(event.orderId);
      emit(OrderDeleted());
      // Optionnel: Recharger les commandes de l'utilisateur après suppression
      // Il faudrait récupérer le userId d'une autre manière ici (peut-être depuis l'état actuel ou un service d'authentification)
    } on ApiException {
      emit(OrderError(ErrorMessages.orderUpdateFailed));
    } catch (e) {
      emit(OrderError(ErrorMessages.unknownError));
    }
  }
}
