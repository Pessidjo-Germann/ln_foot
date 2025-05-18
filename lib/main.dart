import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/auth/auth_bloc.dart';
import 'package:ln_foot/bloc/product/product_bloc.dart';
import 'package:ln_foot/bloc/saved_items/saved_items_bloc.dart';
import 'package:ln_foot/bloc/order/order_bloc.dart';
import 'package:ln_foot/screen/splash_screen.dart';
import 'package:ln_foot/theme/app_theme.dart';
import 'package:ln_foot/service.dart';
import 'package:lnFoot_api/api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authService = await AuthService.create();
  final token = await authService.getAccessToken();
  final apiClient = ApiClient();
  if (token != null && token.isNotEmpty) {
    apiClient.setAuthToken(token);
  }
  final productApi = ProductControllerApi(apiClient);
  final orderControllerApi = OrderControllerApi(apiClient);
  runApp(MyApp(
    authService: authService,
    orderControllerApi: orderControllerApi,
    productApi: productApi,
  ));
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final OrderControllerApi orderControllerApi;
  final ProductControllerApi productApi;

  const MyApp({
    super.key,
    required this.authService,
    required this.orderControllerApi,
    required this.productApi,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authService: authService)..add(AppStarted()),
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
