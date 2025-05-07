import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lnFoot_api/api.dart';
import 'package:ln_foot/service/fake_product_service.dart';
import 'package:http/http.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  // Remplacer l'API par notre service de données fictives
  final FakeProductService _fakeProductService = FakeProductService();

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
      final products = await _fakeProductService.getAllProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onLoadProductById(
      LoadProductById event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final product = await _fakeProductService.getProductById(event.productId);
      emit(ProductLoaded(product));
    } catch (e) {
      emit(ProductError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onCreateProduct(
      CreateProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final productData = {
        'name': event.name,
        'price': event.price,
        'categoryNames': event.categoryNames,
        'description': event.description,
        'stockQuantity': event.stockQuantity,
        'sizes': event.sizes,
      };

      final createdProduct =
          await _fakeProductService.createProduct(productData);
      emit(ProductCreated(createdProduct));
    } catch (e) {
      emit(ProductError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateProduct(
      UpdateProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final updatedProduct = await _fakeProductService.updateProduct(
        event.productId,
        event.productData.toJson(),
      );
      emit(ProductUpdated(updatedProduct));
    } catch (e) {
      emit(ProductError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteProduct(
      DeleteProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      await _fakeProductService.deleteProduct(event.productId);
      emit(ProductDeleted());
    } catch (e) {
      emit(ProductError('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
