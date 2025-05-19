import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/auth/auth_bloc.dart';
import 'package:ln_foot/bloc/cart/cart_bloc.dart';
import 'package:ln_foot/bloc/product/product_bloc.dart';
import 'package:ln_foot/bloc/saved_items/saved_items_bloc.dart';
import 'package:ln_foot/bloc/order/order_bloc.dart';
import 'package:ln_foot/bloc/category/category_bloc.dart';
import 'package:ln_foot/bloc/colored_product/colored_product_bloc.dart';
import 'package:ln_foot/bloc/review/review_bloc.dart';
import 'package:ln_foot/screen/splash_screen.dart';
import 'package:ln_foot/theme/app_theme.dart';
import 'package:ln_foot/service.dart';
import 'package:lnFoot_api/api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authService = await AuthService.create();
  final token = await authService.getAccessToken();
  final refresh = authService.getRefreshToken();
  debugPrint('Refresh token: $refresh');
  debugPrint('Token: $token');

  final apiClient = ApiClient();
  if (token != null && token.isNotEmpty) {
    apiClient.setAuthToken(token);
  }
  final productApi = ProductControllerApi(apiClient);
  final orderControllerApi = OrderControllerApi(apiClient);
  final categoryControler = CategoryControllerApi(apiClient);
  final coloredProductControllerApi = ColoredProductControllerApi(apiClient);
  final reviewControllerApi = ReviewControllerApi(apiClient);
  runApp(MyApp(
    authService: authService,
    orderControllerApi: orderControllerApi,
    productApi: productApi,
    categoryControllerApi: categoryControler,
    coloredProductControllerApi: coloredProductControllerApi,
    reviewControllerApi: reviewControllerApi,
  ));
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final OrderControllerApi orderControllerApi;
  final ProductControllerApi productApi;
  final CategoryControllerApi categoryControllerApi;
  final ColoredProductControllerApi coloredProductControllerApi;
  final ReviewControllerApi reviewControllerApi;

  const MyApp({
    super.key,
    required this.authService,
    required this.orderControllerApi,
    required this.productApi,
    required this.categoryControllerApi,
    required this.coloredProductControllerApi,
    required this.reviewControllerApi,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) =>
              AuthBloc(authService: authService)..add(CheckTokenStored()),
        ),
        BlocProvider<ProductBloc>(
          create: (_) =>
              ProductBloc(productApi: productApi)..add(LoadAllProducts()),
        ),
        BlocProvider<SavedItemsBloc>(
          create: (_) => SavedItemsBloc()..add(LoadSavedItems()),
        ),
        BlocProvider<OrderBloc>(
          create: (_) => OrderBloc(orderControllerApi: orderControllerApi),
        ),
        BlocProvider<CategoryBloc>(
          create: (_) =>
              CategoryBloc(categoryControllerApi: categoryControllerApi)
                ..add(LoadAllCategories()),
        ),
        BlocProvider<ColoredProductBloc>(
          create: (_) => ColoredProductBloc(
              coloredProductControllerApi: coloredProductControllerApi),
        ),
        BlocProvider<CartBloc>(
          create: (_) => CartBloc()..add(LoadCart()),
        ),
        BlocProvider<ReviewBloc>(
          create: (_) => ReviewBloc(reviewControllerApi: reviewControllerApi),
        ),
      ],
      child: MaterialApp(
        title: 'LN Foot',
        theme: appThemeData,
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
