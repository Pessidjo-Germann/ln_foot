import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/auth/auth_bloc.dart';
import 'package:ln_foot/bloc/product/product_bloc.dart';  
import 'package:ln_foot/bloc/saved_items/saved_items_bloc.dart';  
import 'package:ln_foot/screen/splash_screen.dart';
import 'package:ln_foot/theme/app_theme.dart';
import 'package:ln_foot/service.dart';
import 'package:lnFoot_api/api.dart';  

void main() {
  // Instantiate services and API clients
  final authService = AuthService();
  final apiClient = ApiClient();  
  final productControllerApi =
      ProductControllerApi(apiClient); // Instantiate Product API

  runApp(MyApp(
    authService: authService,
    productControllerApi: productControllerApi, // Pass Product API
  ));
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final ProductControllerApi productControllerApi; // Add Product API field

  const MyApp({
    super.key,
    required this.authService,
    required this.productControllerApi, // Update constructor
  });

  @override
  Widget build(BuildContext context) {
    // Wrap MaterialApp with MultiBlocProvider
    return MultiBlocProvider(
      providers: [
        // Provide AuthBloc
        BlocProvider<AuthBloc>(
          create: (context) =>
              AuthBloc(authService: authService)..add(AppStarted()),
        ),
        // Provide ProductBloc
        BlocProvider<ProductBloc>(
          create: (context) =>
              ProductBloc(productControllerApi: productControllerApi)
                ..add(LoadAllProducts()), // Load products on creation
        ),
        // Provide SavedItemsBloc
        BlocProvider<SavedItemsBloc>(
          create: (context) => SavedItemsBloc()
            ..add(
                LoadSavedItems()), // Charger les éléments sauvegardés au démarrage
        ),
        // Add other Blocs here
      ],
      child: MaterialApp(
        title: 'LN Foot',
        theme: appThemeData,
        home:
            const SplashScreen(), // SplashScreen likely handles initial routing based on AuthState
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
