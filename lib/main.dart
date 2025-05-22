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
import 'package:ln_foot/bloc/heading/heading_bloc.dart'; // Import HeadingBloc
import 'package:ln_foot/screen/splash_screen.dart';
import 'package:ln_foot/theme/app_theme.dart';
import 'package:ln_foot/service.dart';
import 'package:ln_foot/service/refreshing_http_client.dart'; // Added import
import 'package:http/http.dart' as http; // Added import
import 'package:lnFoot_api/api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authService = await AuthService.create();
  final token = await authService.getAccessToken(); // Kept for potential debug or initial checks
  final refresh = authService.getAccessToken(); // Kept for potential debug

  debugPrint('Refresh token: $refresh');
  debugPrint('Token: $token');

  final apiClient = ApiClient();

  // Instantiate and set RefreshingHttpClient
  final baseHttpClient = http.Client(); 
  final refreshingClient = RefreshingHttpClient(baseHttpClient, authService);
  apiClient.client = refreshingClient; 
  debugPrint('RefreshingHttpClient set on ApiClient.');

  // Removed: apiClient.setAuthToken(token ?? '');
  // debugPrint('Token set in ApiClient: $token'); // Also commented out related debugPrint

  final productApi = ProductControllerApi(apiClient);
  final orderControllerApi = OrderControllerApi(apiClient);
  final categoryControler = CategoryControllerApi(apiClient);
  // final coloredProductControllerApi = ColoredProductControllerApi(apiClient);
  final reviewControllerApi = ReviewControllerApi(apiClient);
  final productVariantControllerApi= ProductVariantControllerApi(apiClient);
  final headingControllerApi = HeadingControllerApi(apiClient); // Instantiate HeadingControllerApi
  runApp(MyApp(
    authService: authService,
    orderControllerApi: orderControllerApi,
    productApi: productApi,
    categoryControllerApi: categoryControler,
    productVariantControllerApi: productVariantControllerApi,
    //  coloredProductControllerApi: coloredProductControllerApi,
    reviewControllerApi: reviewControllerApi,
    headingControllerApi: headingControllerApi, // Pass HeadingControllerApi
    apiClient: apiClient,
  ));
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final OrderControllerApi orderControllerApi;
  final ProductControllerApi productApi;
  final CategoryControllerApi categoryControllerApi;
  // final ColoredProductControllerApi coloredProductControllerApi;
  final ReviewControllerApi reviewControllerApi;
  final ProductVariantControllerApi productVariantControllerApi;
  final HeadingControllerApi headingControllerApi; // Add field for HeadingControllerApi
  final ApiClient apiClient;

  const MyApp({
    super.key,
    required this.authService,
    required this.orderControllerApi,
    required this.productApi,
    required this.categoryControllerApi,
    required this.productVariantControllerApi,
    // required this.coloredProductControllerApi,
    required this.reviewControllerApi,
    required this.headingControllerApi, // Add to constructor
    required this.apiClient,
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
              ProductBloc(productApi: productApi,productVariantApi: productVariantControllerApi)..add(LoadAllProducts()),
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
                ..add( LoadAllCategories()), // Use const
        ),
        BlocProvider<HeadingBloc>( // Add HeadingBloc provider
          create: (_) => 
              HeadingBloc(headingControllerApi: headingControllerApi)
                ..add(const LoadHeadings()), // Dispatch initial event, use const
        ),
        // BlocProvider<ColoredProductBloc>(
        //   create: (_) => ColoredProductBloc(
        //       coloredProductControllerApi: coloredProductControllerApi),
        // ),
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
        home: SplashScreen(apiClient: apiClient),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
