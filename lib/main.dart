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
  final orderControllerApi = OrderControllerApi();
  runApp(MyApp(
    authService: authService,
    orderControllerApi: orderControllerApi,
  ));
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final OrderControllerApi orderControllerApi;

  const MyApp({
    super.key,
    required this.authService,
    required this.orderControllerApi,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authService: authService)..add(AppStarted()),
        ),
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc()..add(LoadAllProducts()),
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
        home:
            const SplashScreen(), 
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
