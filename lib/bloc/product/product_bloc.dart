import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lnFoot_api/api.dart'; 
import 'package:http/http.dart';  

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductControllerApi productControllerApi;

  ProductBloc({required this.productControllerApi}) : super(ProductInitial()) {
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
      final products = await productControllerApi.getAllProducts();
      emit(ProductsLoaded(products ?? []));
    } on ApiException catch (e) {
      emit(ProductError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(ProductError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onLoadProductById(
      LoadProductById event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final product =
          await productControllerApi.getProductById(event.productId);
      if (product != null) {
        emit(ProductLoaded(product));
      } else {
        emit(const ProductError('Product not found.'));
      }
    } on ApiException catch (e) {
      emit(ProductError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(ProductError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onCreateProduct(
      CreateProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      // Note: L'appel API utilise des paramètres nommés.
      final createdProduct = await productControllerApi.createProduct(
        event.price,
        event.categoryNames,
        id: event.id,
        imageUrl: event.imageUrl,
        file:
            event.file, // Assurez-vous que MultipartFile est géré correctement
        name: event.name,
        description: event.description,
        stockQuantity: event.stockQuantity,
        sizes: event.sizes,
      );
      if (createdProduct != null) {
        emit(ProductCreated(createdProduct));
        // Optionnel: add(LoadAllProducts()); // Pour rafraîchir la liste
      } else {
        emit(const ProductError('Product creation failed silently.'));
      }
    } on ApiException catch (e) {
      emit(ProductError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(ProductError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateProduct(
      UpdateProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final updatedProduct = await productControllerApi.updateProduct(
        event.productId,
        productDto: event.productData, // L'API attend un ProductDto
      );
      if (updatedProduct != null) {
        emit(ProductUpdated(updatedProduct));
        // Optionnel: add(LoadAllProducts()); // Pour rafraîchir la liste
      } else {
        emit(const ProductError('Product update failed silently.'));
      }
    } on ApiException catch (e) {
      emit(ProductError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(ProductError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteProduct(
      DeleteProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      await productControllerApi.deleteProduct(event.productId);
      emit(ProductDeleted());
      // Optionnel: add(LoadAllProducts()); // Pour rafraîchir la liste
    } on ApiException catch (e) {
      emit(ProductError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(ProductError('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
