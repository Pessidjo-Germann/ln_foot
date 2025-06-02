import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/auth/auth_bloc.dart';
import 'package:ln_foot/bloc/cart/cart_bloc.dart';
import 'package:ln_foot/bloc/product/product_bloc.dart';
import 'package:ln_foot/bloc/saved_items/saved_items_bloc.dart';
import 'package:ln_foot/bloc/order/order_bloc.dart';
import 'package:ln_foot/bloc/category/category_bloc.dart';

import 'package:ln_foot/bloc/review/review_bloc.dart';
import 'package:ln_foot/bloc/heading/heading_bloc.dart'; // Import HeadingBloc
import 'package:ln_foot/blocs/network_bloc/network_bloc.dart'; // Import NetworkBloc
import 'package:connectivity_plus/connectivity_plus.dart'; // Import Connectivity
import 'package:ln_foot/widgets/offline_notification_banner.dart'; // Import OfflineNotificationBanner
import 'package:ln_foot/screen/home_screen.dart';
import 'package:ln_foot/screen/login_options_screen.dart';
import 'package:ln_foot/screen/offline_page.dart';
import 'package:ln_foot/screen/splash_screen.dart';
import 'package:ln_foot/theme/app_theme.dart';
import 'package:ln_foot/service.dart';
import 'package:ln_foot/service/refreshing_http_client.dart'; // Added import
import 'package:http/http.dart' as http; // Added import
import 'package:lnFoot_api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Vérifie si c'est le premier lancement
  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('is_first_launch') ?? true;

  if (isFirstLaunch) {
    await prefs.setBool('is_first_launch', false);
  }

  final authService = await AuthService.create();
  final token = await authService.getAccessToken();
  final refresh = authService.getAccessToken();

  debugPrint('Refresh token: $refresh');
  debugPrint('Token: $token');

  final apiClient = ApiClient();
  final baseHttpClient = http.Client();
  final refreshingClient = RefreshingHttpClient(baseHttpClient, authService);
  apiClient.client = refreshingClient;
  debugPrint('RefreshingHttpClient set on ApiClient.');

  final productApi = ProductControllerApi(apiClient);
  final orderControllerApi = OrderControllerApi(apiClient);
  final categoryControler = CategoryControllerApi(apiClient);
  final reviewControllerApi = ReviewControllerApi(apiClient);
  final productVariantControllerApi = ProductVariantControllerApi(apiClient);
  final headingControllerApi = HeadingControllerApi(apiClient);

  runApp(MyApp(
    authService: authService,
    orderControllerApi: orderControllerApi,
    productApi: productApi,
    categoryControllerApi: categoryControler,
    productVariantControllerApi: productVariantControllerApi,
    reviewControllerApi: reviewControllerApi,
    headingControllerApi: headingControllerApi,
    apiClient: apiClient,
    isFirstLaunch: isFirstLaunch,
  ));
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final OrderControllerApi orderControllerApi;
  final ProductControllerApi productApi;
  final CategoryControllerApi categoryControllerApi;
  final ReviewControllerApi reviewControllerApi;
  final ProductVariantControllerApi productVariantControllerApi;
  final HeadingControllerApi headingControllerApi;
  final ApiClient apiClient;
  final bool isFirstLaunch;

  const MyApp({
    super.key,
    required this.authService,
    required this.orderControllerApi,
    required this.productApi,
    required this.categoryControllerApi,
    required this.productVariantControllerApi,
    required this.reviewControllerApi,
    required this.headingControllerApi,
    required this.apiClient,
    required this.isFirstLaunch,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authService: authService)..add(AppStarted()),
        ),
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(
              productApi: productApi,
              productVariantApi: productVariantControllerApi)
            ..add(LoadAllProducts()),
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
                ..add(LoadAllCategories()), // Use const
        ),
        BlocProvider<HeadingBloc>(
          // Add HeadingBloc provider
          create: (_) => HeadingBloc(headingControllerApi: headingControllerApi)
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
        BlocProvider<NetworkBloc>(
          // Add NetworkBloc provider
          create: (_) => NetworkBloc(connectivity: Connectivity()),
        ),
      ],
      child: MaterialApp(
        title: 'LN SHOP',
        theme: appThemeData,
        home: isFirstLaunch
            ? SplashScreen(apiClient: apiClient)
            : AuthWrapper(apiClient: apiClient),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Column(
            children: [
              const OfflineNotificationBanner(),
              Expanded(child: child!),
            ],
          );
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  final ApiClient apiClient;

  const AuthWrapper({super.key, required this.apiClient});

  @override
  Widget build(BuildContext context) {
    // Vérifie d'abord l'état de la connexion réseau
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, networkState) {
        // Si l'utilisateur est hors ligne, affiche la page offline
        if (networkState is NetworkOffline) {
          return const OfflinePage();
        }

        // Si l'utilisateur est en ligne, procède avec l'authentification normale
        return BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Unauthenticated) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginOptionsScreen()),
                (Route<dynamic> route) => false,
              );
            } else if (state is Authenticated) {
              debugPrint("hello we are in wapper");
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (Route<dynamic> route) => false,
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Erreur d\'authentification: ${state.message}'),
                ),
              );
              // Redirige vers la connexion même en cas d'erreur grave
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginOptionsScreen()),
                (Route<dynamic> route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading || state is AuthInitial) {
              return SplashScreen(apiClient: apiClient);
            } else if (state is Authenticated ||
                state is AuthenticatedWithToken) {
              debugPrint("hello we are in wapper");
              return const HomeScreen();
            } else {
              return LoginOptionsScreen();
            }
          },
        );
      },
    );
  }
}
