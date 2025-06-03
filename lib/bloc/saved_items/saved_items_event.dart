part of 'saved_items_bloc.dart';

@immutable
abstract class SavedItemsEvent extends Equatable {
  const SavedItemsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSavedItems extends SavedItemsEvent {}

class AddSavedItem extends SavedItemsEvent {
  final SavedProductDto product;

  const AddSavedItem(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveSavedItem extends SavedItemsEvent {
  final String productId;

  const RemoveSavedItem(this.productId);

  @override
  List<Object?> get props => [productId];
}
