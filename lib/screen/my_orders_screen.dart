import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
// Import the newly created widgets
import '../widgets/my_orders/order_status_tabs.dart';
import '../widgets/my_orders/order_list.dart';
import '../widgets/my_orders/empty_orders_view.dart';
import '../widgets/my_orders/review_bottom_sheet.dart'; // Import the bottom sheet

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Placeholder data - replace with actual data fetching logic
  final List<Map<String, dynamic>> _ongoingOrders = [
    {
      'image': 'images/product1.png', // Replace with actual image path/URL
      'name': 'Godasse Nike',
      'size': 'Taille: 40',
      'price': '25000FCFA',
      'status': 'ongoing',
    },
    {
      'image': 'images/product2.png', // Replace with actual image path/URL
      'name': 'Maillot',
      'size': 'Taille: XL',
      'price': '10000FCFA',
      'status': 'ongoing',
    },
     {
      'image': 'images/product3.png', // Replace with actual image path/URL
      'name': 'Godasse Adidas',
      'size': 'Taille: 42',
      'price': '26000FCFA',
      'status': 'ongoing',
    },
     {
      'image': 'images/product2.png', // Replace with actual image path/URL
      'name': 'Maillot',
      'size': 'Taille: XL',
      'price': '10000FCFA',
      'status': 'ongoing',
    },
  ];

  final List<Map<String, dynamic>> _completedOrders = [
     {
      'image': 'images/product1.png', // Replace with actual image path/URL
      'name': 'Godasse Nike',
      'size': 'Taille: 40',
      'price': '25000FCFA',
      'status': 'completed',
    },
    {
      'image': 'images/product2.png', // Replace with actual image path/URL
      'name': 'Maillot',
      'size': 'Taille: XL',
      'price': '10000FCFA',
      'status': 'completed',
    },
     {
      'image': 'images/product3.png', // Replace with actual image path/URL
      'name': 'Godasse Adidas',
      'size': 'Taille: 42',
      'price': '26000FCFA',
      'status': 'completed',
    },
     {
      'image': 'images/product2.png', // Replace with actual image path/URL
      'name': 'Product Name', // Example name change
      'size': 'Taille: XL',
      'price': '10000FCFA',
      'status': 'completed',
    },
  ];

   final List<Map<String, dynamic>> _reviewOrders = [
     {
      'image': 'images/product1.png', // Replace with actual image path/URL
      'name': 'Godasse Nike',
      'size': 'Taille: 40',
      'price': '25000FCFA',
      'status': 'review',
      'reviewed': false,
    },
    {
      'image': 'images/product2.png', // Replace with actual image path/URL
      'name': 'Maillot',
      'size': 'Taille: XL',
      'price': '10000FCFA',
      'status': 'review',
      'reviewed': false,
    },
     {
      'image': 'images/product3.png', // Replace with actual image path/URL
      'name': 'Godasse Adidas',
      'size': 'Taille: 42',
      'price': '26000FCFA',
      'status': 'review',
      'reviewed': true, // Example: Already reviewed
    },
     {
      'image': 'images/product2.png', // Replace with actual image path/URL
      'name': 'Product Name',
      'size': 'Taille: XL',
      'price': '10000FCFA',
      'status': 'review',
      'reviewed': true, // Example: Already reviewed
    },
  ];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Add listener if needed to react to tab changes
     _tabController.addListener(() {
        setState(() {}); // Rebuild to update list visibility or other state
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Map tab index to OrderStatus enum
  OrderStatus _getStatusFromIndex(int index) {
    switch (index) {
      case 0: return OrderStatus.ongoing;
      case 1: return OrderStatus.completed;
      case 2: return OrderStatus.review;
      default: return OrderStatus.ongoing; // Default or throw error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Mes commandes',
        showBackButton: true,
        onBackButtonPressed: ()=> Navigator.pop(context),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined), // Or use your specific notification icon
            onPressed: () {
              // Navigate to notifications screen
              // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
            },
          ),
          const SizedBox(width: 8), // Add some padding
        ],
      ),
      body: Column(
        children: [
          // Use the OrderStatusTabs widget
          OrderStatusTabs(tabController: _tabController),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Tab 1: Ongoing Orders
                _buildTabView(_ongoingOrders, OrderStatus.ongoing),
                // Tab 2: Completed Orders
                _buildTabView(_completedOrders, OrderStatus.completed),
                // Tab 3: Review Orders
                _buildTabView(_reviewOrders, OrderStatus.review),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper to build the content for each tab
  Widget _buildTabView(List<Map<String, dynamic>> orders, OrderStatus status) {
    if (orders.isEmpty) {
      return EmptyOrdersView(status: status);
    } else {
      return OrderList(
        orders: orders,
        showReviewSheetCallback: _showReviewBottomSheet, // Pass the callback
      );
    }
  }

  // Function to show the actual ReviewBottomSheet
  void _showReviewBottomSheet(BuildContext context, Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Important for keyboard handling
      shape: const RoundedRectangleBorder( // Apply rounded corners
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ReviewBottomSheet(order: order), // Use the created widget
    ).then((value) {
       // Optional: Handle result after bottom sheet closes (e.g., refresh list if review submitted)
       if (value == true) { // Assuming ReviewBottomSheet returns true on successful submission
         print("Review submitted, potentially refresh list");
         // Add logic to update the state or refetch data if needed
         // setState(() { ... });
       }
    });
  }
}
