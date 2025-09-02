part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoriesLoaded extends CategoryState {
  final List<CategoryDto> categories;

  const CategoriesLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoryLoaded extends CategoryState {
  final CategoryDto category;

  const CategoryLoaded(this.category);

  @override
  List<Object?> get props => [category];
}

class CategoryCreated extends CategoryState {
  final CategoryDto category;

  const CategoryCreated(this.category);

  @override
  List<Object?> get props => [category];
}

class CategoryUpdated extends CategoryState {
  final CategoryDto category;

  const CategoryUpdated(this.category);

  @override
  List<Object?> get props => [category];
}

class CategoryDeleted extends CategoryState {}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);

  @override
  List<Object?> get props => [message];
}
