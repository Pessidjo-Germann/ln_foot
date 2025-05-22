import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lnFoot_api/api.dart';
 
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryControllerApi categoryControllerApi;
  List<CategoryDto> _cachedCategories = []; // Added cache field

  CategoryBloc({required this.categoryControllerApi})
      : super(CategoryInitial()) {
    on<LoadAllCategories>(_onLoadAllCategories);
    on<LoadCategoryById>(_onLoadCategoryById);
    on<CreateCategory>(_onCreateCategory);
    on<UpdateCategory>(_onUpdateCategory);
    on<DeleteCategory>(_onDeleteCategory);
  }

  Future<void> _onLoadAllCategories(
      LoadAllCategories event, Emitter<CategoryState> emit) async {
    // Check for cache usage
    if (!event.forceRefresh && _cachedCategories.isNotEmpty) {
      emit(CategoriesLoaded(_cachedCategories));
      return;
    }

    // Proceed with fetching if not using cache or if forcing refresh
    emit(CategoryLoading());
    try {
      final categories = await categoryControllerApi.getAllCategories();
      _cachedCategories = categories ?? []; // Update cache
      emit(CategoriesLoaded(_cachedCategories));
    } on ApiException catch (e) {
      emit(CategoryError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(CategoryError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onLoadCategoryById(
      LoadCategoryById event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final category =
          await categoryControllerApi.getCategoryById(event.categoryId);
      if (category != null) {
        emit(CategoryLoaded(category));
      } else {
        emit(const CategoryError('Category not found.'));
      }
    } on ApiException catch (e) {
      emit(CategoryError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(CategoryError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onCreateCategory(
      CreateCategory event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final createdCategory = await categoryControllerApi.createCategory(
        event.categoryData,
      );
      if (createdCategory != null) {
        emit(CategoryCreated(createdCategory));
        // Optionnel : Recharger toutes les catégories après la création
        // add(LoadAllCategories());
      } else {
        emit(const CategoryError('Category creation failed silently.'));
      }
    } on ApiException catch (e) {
      emit(CategoryError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(CategoryError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateCategory(
      UpdateCategory event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final updatedCategory = await categoryControllerApi.updateCategory(
        event.categoryId,
        event.categoryData,
      );
      if (updatedCategory != null) {
        emit(CategoryUpdated(updatedCategory));
        // Optionnel : Recharger toutes les catégories après la mise à jour
        // add(LoadAllCategories());
      } else {
        emit(const CategoryError('Category update failed silently.'));
      }
    } on ApiException catch (e) {
      emit(CategoryError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(CategoryError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteCategory(
      DeleteCategory event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      await categoryControllerApi.deleteCategory(event.categoryId);
      emit(CategoryDeleted());
      // Optionnel : Recharger toutes les catégories après la suppression
      // add(LoadAllCategories());
    } on ApiException catch (e) {
      emit(CategoryError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(CategoryError('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
