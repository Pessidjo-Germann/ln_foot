import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lnFoot_api/api.dart';
import 'package:http/http.dart';
import 'package:ln_foot/constants/error_messages.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductControllerApi _productApi;
  final ProductVariantControllerApi _productVariantApi;
  List<ProductDto> _allProducts = [];
  String _searchQuery = "";
  String? _currentSelectedCategoryName;

  ProductBloc({required ProductControllerApi productApi, required ProductVariantControllerApi productVariantApi})
      : _productApi = productApi, _productVariantApi = productVariantApi,
        super(ProductInitial()) {
    _currentSelectedCategoryName = null; // Initialize here
    on<LoadAllProducts>(_onLoadAllProducts);
    on<LoadProductById>(_onLoadProductById);
   // on<CreateProduct>(_onCreateProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
    on<LoadProductVariantById>(_onLoadProductVariantsByProductId);
    on<FilterProductsByCategory>(_onFilterProductsByCategory);
    on<ClearProductFilter>(_onClearProductFilter);
    on<SearchProducts>(_onSearchProducts); // Register SearchProducts
  }

  void _applyFiltersAndEmit(Emitter<ProductState> emit, {List<ProductDto>? baseProductList}) {
    List<ProductDto> productsToFilter = List.from(baseProductList ?? _allProducts);

    if (_currentSelectedCategoryName != null && _currentSelectedCategoryName!.isNotEmpty) {
      productsToFilter = productsToFilter
          .where((product) => product.categoryNames.contains(_currentSelectedCategoryName))
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      productsToFilter = productsToFilter
          .where((product) =>
              (product.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
              (product.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false))
          .toList();
    }
    
    emit(ProductLoading()); 
    emit(ProductsLoaded(productsToFilter, selectedCategoryName: _currentSelectedCategoryName, searchQuery: _searchQuery));
  }

  Future<void> _onLoadAllProducts(
      LoadAllProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await _productApi.getAllProducts();
      _allProducts = products ?? [];
      _currentSelectedCategoryName = null; 
      _searchQuery = ""; 
      _applyFiltersAndEmit(emit);
    } on ApiException catch (e) {
      emit(ProductError(ErrorMessages.productUpdateFailed));
    } catch (e) {
      emit(ProductError(ErrorMessages.unknownError));
    }
  }

  Future<void> _onLoadProductVariantsByProductId(
      LoadProductVariantById event, Emitter<ProductState> emit) async {
        emit(ProductLoading());
        try {
          final productVariants = await _productVariantApi.getProductVariants(event.productId);
          debugPrint('Product Variants: $productVariants');
          emit(ProductVariantsLoaded(productVariants!));
        } on ApiException catch (e) {
          emit(ProductError(ErrorMessages.productUpdateFailed));
        } catch (e) {
          emit(ProductError(ErrorMessages.productUpdateFailed));
        }
      }

  Future<void> _onLoadProductById(
      LoadProductById event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final product = await _productApi.getProductById(event.productId);
      if (product != null) {
        emit(ProductLoaded(product));
      } else {
        emit(ProductError('Produit introuvable.'));
      }
    } catch (e) {
      emit(ProductError('An unexpected error occurred:  ${e.toString()}'));
    }
  }

  // Future<void> _onCreateProduct(
  //     CreateProduct event, Emitter<ProductState> emit) async {
  //   emit(ProductLoading());
  //   try {
  //     final createdProduct = await _productApi.createProduct(
      
  //       name: event.name,
  //       description: event.description,
  //       stockQuantity: event.stockQuantity,
  //       sizes: event.sizes,
  //     );
  //     if (createdProduct != null) {
  //       emit(ProductCreated(createdProduct));
  //     } else {
  //       emit(ProductError(ErrorMessages.productLoadFailed));
  //     }
  //   } on ApiException catch (e) {
  //     emit(ProductError(ErrorMessages.productLoadFailed));
  //   } catch (e) {
  //     emit(ProductError(ErrorMessages.unknownError));
  //   }
  // }

  Future<void> _onUpdateProduct(
      UpdateProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final updatedProduct = await _productApi.updateProduct(
        event.productId,
        productDto: event.productData,
      );
      if (updatedProduct != null) {
        emit(ProductUpdated(updatedProduct));
      } else {
        emit(ProductError(ErrorMessages.productUpdateFailed));
      }
    } on ApiException catch (e) {
      emit(ProductError(ErrorMessages.productUpdateFailed));
    } catch (e) {
      emit(ProductError(ErrorMessages.unknownError));
    }
  }

  Future<void> _onDeleteProduct(
      DeleteProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      await _productApi.deleteProduct(event.productId);
      emit(ProductDeleted());
    } on ApiException catch (e) {
      emit(ProductError(ErrorMessages.productUpdateFailed));
    } catch (e) {
      emit(ProductError(ErrorMessages.unknownError));
    }
  }

  Future<void> _onFilterProductsByCategory(
      FilterProductsByCategory event, Emitter<ProductState> emit) async {
    _currentSelectedCategoryName = event.categoryName;
    _applyFiltersAndEmit(emit);
  }

  Future<void> _onClearProductFilter(
      ClearProductFilter event, Emitter<ProductState> emit) async {
    _currentSelectedCategoryName = null;
    _applyFiltersAndEmit(emit);
  }

  Future<void> _onSearchProducts(SearchProducts event, Emitter<ProductState> emit) async {
    _searchQuery = event.query;
    _applyFiltersAndEmit(emit);
  }
}
