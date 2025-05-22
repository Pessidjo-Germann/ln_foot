import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/user_session_manager.dart';
import '../bloc/order/order_bloc.dart';
import 'package:ln_foot/bloc/auth/auth_bloc.dart';
import 'package:lnFoot_api/api.dart';
import '../model/order_status.dart'; // Added import
import '../widgets/custom_app_bar.dart';
// Import the newly created widgets
import '../widgets/my_orders/order_status_tabs.dart';
import '../widgets/my_orders/order_list.dart';
import '../widgets/my_orders/empty_orders_view.dart';
import '../widgets/my_orders/review_bottom_sheet.dart';
import '../model/order_status.dart';
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

  // Helper pour convertir OrderDto en Map<String, dynamic> pour OrderList
  List<Map<String, dynamic>> _mapOrders(
      List<OrderDto> orders, OrderStatus status) { // Parameter type changed
    return orders
        .where((order) =>
            order.status != null && order.status == status.displayName) // Added filter
        .map((order) {
      debugPrint('Order ID: ${order..orderItems.first.toJson()}');
      final item = order.orderItems.isNotEmpty ? order.orderItems.first : null;
      return {
        'id': order.id,
        'image': item != null
            ? 'images/product1.png'
            : null, // À adapter si tu as l'URL dans OrderItemDto
        'name': order.status, // À adapter selon ton modèle
        'size': item?.size != null ? 'Taille: ${item!.size}' : '',
        'price': item!.price.toString(), // À adapter si tu as le prix
        'status': order.status,
        'reviewed': false, // À adapter si tu as cette info
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
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
            // Ici, tu dois filtrer selon l'onglet sélectionné
            debugPrint('Nombre de commandes: ${state.orders.length}');
            debugPrint('Commande');
            // Use the imported OrderStatus for filtering
            final ongoing = _mapOrders(state.orders, OrderStatus.ongoing);
            final completed = _mapOrders(state.orders, OrderStatus.completed);
            final review = _mapOrders(state.orders, OrderStatus.review);
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
          } else if (state is OrderError) {
            return Center(child: Text('Erreur: ${state.message}'));
          } else {
            return const Center(child: Text('Aucune commande trouvée.'));
          }
        },
      ),
    );
  }

  // Helper to build the content for each tab (corrigé pour List<Map<String, dynamic>>)
  Widget _buildTabView(List<Map<String, dynamic>> orders, OrderStatus status) { // Parameter type changed
    if (orders.isEmpty) {
      return Center(child: Text("Pas de commande pour le moment"),); // Assuming EmptyOrdersView is compatible or will be updated
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
