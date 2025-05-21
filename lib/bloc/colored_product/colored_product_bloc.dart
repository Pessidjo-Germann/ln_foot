// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:lnFoot_api/api.dart'; // Import depuis le package API lnFoot_api
// import 'package:ln_foot/constants/error_messages.dart';

// part 'colored_product_event.dart';
// part 'colored_product_state.dart';

// class ColoredProductBloc
//     extends Bloc<ColoredProductEvent, ColoredProductState> {
//   // Injection DIRECTE du contrôleur API
//   final ColoredProductControllerApi coloredProductControllerApi;

//   ColoredProductBloc({required this.coloredProductControllerApi})
//       : super(ColoredProductInitial()) {
//     on<LoadColoredProducts>(_onLoadColoredProducts);
//     on<LoadColoredProductById>(_onLoadColoredProductById);
//     on<CreateColoredProduct>(_onCreateColoredProduct);
//     on<UpdateColoredProduct>(_onUpdateColoredProduct);
//     on<DeleteColoredProduct>(_onDeleteColoredProduct);
//   }

//   Future<void> _onLoadColoredProducts(
//       LoadColoredProducts event, Emitter<ColoredProductState> emit) async {
//     emit(ColoredProductLoading());
//     try {
//       final coloredProducts =
//           await coloredProductControllerApi.getColoredProducts();
//       emit(ColoredProductsLoaded(coloredProducts ?? []));
//     } on ApiException catch (e) {
//       emit(ColoredProductError(ErrorMessages.productLoadFailed));
//     } catch (e) {
//       emit(ColoredProductError(ErrorMessages.unknownError));
//     }
//   }

//   Future<void> _onLoadColoredProductById(
//       LoadColoredProductById event, Emitter<ColoredProductState> emit) async {
//     emit(ColoredProductLoading());
//     try {
//       final coloredProduct =
//           await coloredProductControllerApi.getColoredProduct(event.id);
//       if (coloredProduct != null) {
//         emit(ColoredProductLoaded(coloredProduct));
//       } else {
//         emit(const ColoredProductError("Colored product not found."));
//       }
//     } on ApiException catch (e) {
//       emit(ColoredProductError(ErrorMessages.productLoadFailed));
//     } catch (e) {
//       emit(ColoredProductError(ErrorMessages.unknownError));
//     }
//   }

//   Future<void> _onCreateColoredProduct(
//       CreateColoredProduct event, Emitter<ColoredProductState> emit) async {
//     emit(ColoredProductLoading());
//     try {
//       final createdColoredProduct =
//           await coloredProductControllerApi.createColoredProduct(
//         coloredProductDto: event.coloredProductData,
//       );
//       if (createdColoredProduct != null) {
//         emit(ColoredProductCreated(createdColoredProduct));
//         // Optionnel : Recharger la liste après création
//         // add(LoadColoredProducts());
//       } else {
//         emit(const ColoredProductError(
//             "Colored product creation failed silently."));
//       }
//     } on ApiException catch (e) {
//       emit(ColoredProductError(ErrorMessages.productLoadFailed));
//     } catch (e) {
//       emit(ColoredProductError(ErrorMessages.unknownError));
//     }
//   }

//   Future<void> _onUpdateColoredProduct(
//       UpdateColoredProduct event, Emitter<ColoredProductState> emit) async {
//     emit(ColoredProductLoading());
//     try {
//       final updatedColoredProduct =
//           await coloredProductControllerApi.updateColoredProduct(
//         event.id,
//         coloredProductDto: event.coloredProductData,
//       );
//       if (updatedColoredProduct != null) {
//         emit(ColoredProductUpdated(updatedColoredProduct));
//         // Optionnel : Recharger la liste après mise à jour
//         // add(LoadColoredProducts());
//       } else {
//         emit(const ColoredProductError(
//             "Colored product update failed silently."));
//       }
//     } on ApiException catch (e) {
//       emit(ColoredProductError(ErrorMessages.productLoadFailed));
//     } catch (e) {
//       emit(ColoredProductError(ErrorMessages.unknownError));
//     }
//   }

//   Future<void> _onDeleteColoredProduct(
//       DeleteColoredProduct event, Emitter<ColoredProductState> emit) async {
//     emit(ColoredProductLoading());
//     try {
//       await coloredProductControllerApi.deleteColoredProduct(event.id);
//       emit(ColoredProductDeleted());
//       // Optionnel : Recharger la liste après suppression
//       // add(LoadColoredProducts());
//     } on ApiException catch (e) {
//       emit(ColoredProductError(ErrorMessages.productLoadFailed));
//     } catch (e) {
//       emit(ColoredProductError(ErrorMessages.unknownError));
//     }
//   }
// }
