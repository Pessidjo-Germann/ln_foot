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

  ProductBloc({required ProductControllerApi productApi, required ProductVariantControllerApi productVariantApi})
      : _productApi = productApi, _productVariantApi = productVariantApi,
        super(ProductInitial()) {
    on<LoadAllProducts>(_onLoadAllProducts);
    on<LoadProductById>(_onLoadProductById);
   // on<CreateProduct>(_onCreateProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
    on<LoadProductVariantById>(_onLoadProductVariantsByProductId);
  }

  Future<void> _onLoadAllProducts(
      LoadAllProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await _productApi.getAllProducts();
      debugPrint('Products: $products');
      emit(ProductsLoaded(products ?? []));
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
}
