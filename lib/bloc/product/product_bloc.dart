import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lnFoot_api/api.dart';
import 'package:http/http.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  // Remplacer l'API par notre service de données fictives
  final ProductControllerApi _productApi = ProductControllerApi();

  ProductBloc() : super(ProductInitial()) {
    on<LoadAllProducts>(_onLoadAllProducts);
    on<LoadProductById>(_onLoadProductById);
    on<CreateProduct>(_onCreateProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
  }

  Future<void> _onLoadAllProducts(
      LoadAllProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await _productApi.getAllProducts();
      emit(ProductsLoaded(products ?? []));
    } catch (e) {
      emit(ProductError('An unexpected error occurred: ${e.toString()}'));
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

  Future<void> _onCreateProduct(
      CreateProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final createdProduct = await _productApi.createProduct(
        event.price,
        event.categoryNames,
        name: event.name,
        description: event.description,
        stockQuantity: event.stockQuantity,
        sizes: event.sizes,
      );
      if (createdProduct != null) {
        emit(ProductCreated(createdProduct));
      } else {
        emit(ProductError('Erreur lors de la création du produit.'));
      }
    } catch (e) {
      emit(ProductError('An unexpected error occurred:  ${e.toString()}'));
    }
  }

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
        emit(ProductError('Erreur lors de la mise à jour du produit.'));
      }
    } catch (e) {
      emit(ProductError('An unexpected error occurred:  ${e.toString()}'));
    }
  }

  Future<void> _onDeleteProduct(
      DeleteProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      await _productApi.deleteProduct(event.productId);
      emit(ProductDeleted());
    } catch (e) {
      emit(ProductError('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
