import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/blocs/network_bloc/network_bloc.dart';
import 'package:ln_foot/pages/offline_page.dart';
import 'package:ln_foot/user_session_manager.dart';
import '../bloc/order/order_bloc.dart';

import 'package:lnFoot_api/api.dart';
import '../model/order_status.dart'; // Added import
import '../widgets/custom_app_bar.dart';
// Import the newly created widgets
import '../widgets/my_orders/order_status_tabs.dart';
import '../widgets/my_orders/order_list.dart';

import '../widgets/my_orders/review_bottom_sheet.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _userId;
  Map<String, dynamic>? _userInfo;

  // Ajout : API et cache pour les variantes de produit
  final ProductVariantControllerApi _productVariantApi =
      ProductVariantControllerApi();
  final ProductControllerApi _productApi = ProductControllerApi();
  final Map<String, ProductVariantDto?> _productVariantCache = {};
  final Map<String, ProductDto?> _productCache = {};
  @override
  void initState() {
    super.initState();
    _loadUserInfoAndDispatchOrders();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  Future<void> _loadUserInfoAndDispatchOrders() async {
    final data = await UserSessionManager.getUserInfo();
    debugPrint('Données utilisateur récupérées : $data');
    if (!mounted) return;

    if (data != null && data.containsKey('sub')) {
      final userId = data['sub'] as String?;
      debugPrint('User ID récupéré : $userId');

      if (userId != null && userId.isNotEmpty) {
        setState(() {
          _userInfo = data;
          _userId = userId;
        });

        // Ajouter à la frame suivante
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          context.read<OrderBloc>().add(LoadUserOrders(userId: userId));
        });
      } else {
        debugPrint('userId est null ou vide');
      }
    } else {
      debugPrint('Aucune donnée utilisateur ou clé sub manquante');
    }
  }

  // Nouvelle version asynchrone
  Future<List<Map<String, dynamic>>> _mapOrders(
      List<OrderDto> orders, OrderStatus status) async {
    final filteredOrders = orders
        .where((order) =>
            order.status != null && order.status == status.displayName)
        .toList();

    final List<Map<String, dynamic>> mappedOrders = [];

    for (final order in filteredOrders) {
      try {
        final item =
            order.orderItems.isNotEmpty ? order.orderItems.first : null;
        String? imageUrl;
        String productName = 'Produit';

        // Vérification plus robuste
        if (item?.productVariantId != null &&
            item!.productVariantId!.isNotEmpty) {
          try {
            ProductVariantDto? productVariant;
            final variantId = item.productVariantId!;

            if (_productVariantCache.containsKey(variantId)) {
              productVariant = _productVariantCache[variantId];
            } else {
              debugPrint('Récupération de la variante: $variantId');
              productVariant =
                  await _productVariantApi.getProductVariant(variantId);
              _productVariantCache[variantId] = productVariant;
            }

            if (productVariant != null) {
              imageUrl = productVariant.imageUrl;
              debugPrint('ImageUrl récupérée: $imageUrl');

              // Récupération sécurisée du nom du produit
              if (productVariant.productId != null &&
                  productVariant.productId!.isNotEmpty) {
                ProductDto? product;
                final productId = productVariant.productId!;

                if (_productCache.containsKey(productId)) {
                  product = _productCache[productId];
                } else {
                  debugPrint('Récupération du produit: $productId');
                  product = await _productApi.getProductById(productId);
                  _productCache[productId] = product;
                }

                if (product?.name != null && product!.name!.isNotEmpty) {
                  productName = product.name!;
                }
              }
            }
          } catch (e) {
            debugPrint(
                'Erreur lors de la récupération de la variante/produit: $e');
            // Continue avec les valeurs par défaut
          }
        }

        // Vérification des valeurs avant ajout
        final orderMap = {
          'id': order.id ?? 'unknown',
          'image': imageUrl ?? 'images/product1.png',
          'name': productName,
          'size': item?.size != null ? 'Taille: ${item!.size}' : '',
          'price': _safeParsePrice(item?.price),
          'status': _mapOrderStatus(order.status),
          'reviewed': false,
        };

        debugPrint('Commande mappée: $orderMap');
        mappedOrders.add(orderMap);
      } catch (e) {
        debugPrint('Erreur lors du mapping de la commande ${order.id}: $e');
        // Ajoutez une commande par défaut ou ignorez
      }
    }

    return mappedOrders;
  }

  // Méthodes helper
  String _safeParsePrice(dynamic price) {
    if (price == null) return '0';
    if (price is num) return price.toString();
    if (price is String) {
      try {
        return double.parse(price).toString();
      } catch (e) {
        return '0';
      }
    }
    return '0';
  }

  String _mapOrderStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return OrderStatus.ongoing.displayName;
      case 'completed':
        return OrderStatus.completed.displayName;
      default:
        return OrderStatus.review.displayName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, networkState) {
        if (networkState is NetworkOffline) {
          return const OfflinePage();
        }
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Mes commandes',
            showBackButton: true,
            onBackButtonPressed: () => Navigator.pop(context),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none_outlined),
                onPressed: () {
                  // Navigate to notifications screen
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
                },
              ),
              const SizedBox(width: 8), // Add some padding
            ],
          ),
          body: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is OrdersLoaded) {
                // Utilisation de FutureBuilder pour gérer le mapping asynchrone
                return FutureBuilder<List<List<Map<String, dynamic>>>>(
                  future: Future.wait([
                    _mapOrders(state.orders, OrderStatus.ongoing),
                    _mapOrders(state.orders, OrderStatus.completed),
                    _mapOrders(state.orders, OrderStatus.review),
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Erreur: ${snapshot.error}'));
                    }
                    final data = snapshot.data;
                    if (data == null) {
                      return const Center(
                          child: Text('Aucune donnée disponible'));
                    }
                    final ongoing = data[0];
                    final completed = data[1];
                    final review = data[2];
                    return Column(
                      children: [
                        OrderStatusTabs(tabController: _tabController),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              // Tab 1: Ongoing Orders
                              _buildTabView(ongoing, OrderStatus.ongoing),
                              // Tab 2: Completed Orders
                              _buildTabView(completed, OrderStatus.completed),
                              // Tab 3: Review Orders
                              _buildTabView(review, OrderStatus.review),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else if (state is OrderError) {
                return Center(child: Text('Erreur: ${state.message}'));
              } else {
                return const Center(child: Text('Aucune commande trouvée.'));
              }
            },
          ),
        );
      },
    );
  }

  // Helper to build the content for each tab (corrigé pour List<Map<String, dynamic>>)
  Widget _buildTabView(List<Map<String, dynamic>> orders, OrderStatus status) {
    // Parameter type changed
    if (orders.isEmpty) {
      return Center(
        child: Text("Pas de commande pour le moment"),
      ); // Assuming EmptyOrdersView is compatible or will be updated
    } else {
      return OrderList(
        orders: orders,
        showReviewSheetCallback: _showReviewBottomSheet, // Pass the callback
      );
    }
  }

  // Function to show the actual ReviewBottomSheet
  void _showReviewBottomSheet(
      BuildContext context, Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Important for keyboard handling
      shape: const RoundedRectangleBorder(
        // Apply rounded corners
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ReviewBottomSheet(order: order), // Use the created widget
    ).then((value) {
      // Optional: Handle result after bottom sheet closes (e.g., refresh list if review submitted)
      if (value == true) {
        // Assuming ReviewBottomSheet returns true on successful submission
        print("Review submitted, potentially refresh list");
        // Add logic to update the state or refetch data if needed
        // setState(() { ... });
      }
    });
  }
}
