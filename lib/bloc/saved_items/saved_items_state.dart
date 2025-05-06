part of 'saved_items_bloc.dart';

@immutable
abstract class SavedItemsState extends Equatable {
  const SavedItemsState();

  @override
  List<Object?> get props => [];
}

class SavedItemsInitial extends SavedItemsState {}

class SavedItemsLoading extends SavedItemsState {}

class SavedItemsLoaded extends SavedItemsState {
  final List<ProductDto> items;

  const SavedItemsLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class SavedItemsError extends SavedItemsState {
  final String message;

  const SavedItemsError(this.message);

  @override
  List<Object?> get props => [message];
}
