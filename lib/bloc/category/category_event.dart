part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllCategories extends CategoryEvent {
  final bool forceRefresh;
  
  const LoadAllCategories({this.forceRefresh = false});
  
  @override
  List<Object?> get props => [forceRefresh];
}

class LoadCategoryById extends CategoryEvent {
  final String categoryId;

  const LoadCategoryById(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class CreateCategory extends CategoryEvent {
  final CategoryDto categoryData;

  const CreateCategory({required this.categoryData});

  @override
  List<Object?> get props => [categoryData];
}

class UpdateCategory extends CategoryEvent {
  final String categoryId;
  final CategoryDto categoryData;

  const UpdateCategory({required this.categoryId, required this.categoryData});

  @override
  List<Object?> get props => [categoryId, categoryData];
}

class DeleteCategory extends CategoryEvent {
  final String categoryId;

  const DeleteCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
