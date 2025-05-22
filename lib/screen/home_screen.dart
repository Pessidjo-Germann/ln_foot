import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/cart/cart_bloc.dart';
import 'package:ln_foot/bloc/category/category_bloc.dart';
import 'package:ln_foot/bloc/product/product_bloc.dart';
import 'package:ln_foot/screen/cart_screen.dart';
import 'package:ln_foot/screen/profile_screen.dart';
import 'package:ln_foot/service.dart';
import 'package:ln_foot/widgets/home/home_app_bar.dart';
import 'package:ln_foot/widgets/home/search_bar_widget.dart';
import 'package:ln_foot/widgets/home/categories_section.dart'; // Import the Categories Section
import 'package:ln_foot/widgets/home/promo_banner.dart'; // Import the Promo Banner
import 'package:ln_foot/widgets/home/special_offers_section.dart'; // Import the Special Offers Section
import 'package:ln_foot/theme/app_theme.dart';

import 'saved_items_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> screens = [
    const HomeContent(),
    const SavedItemsScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: kAppOrangeColor,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Maison',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Enregistré',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Compte',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late TextEditingController _searchController; // Declare controller

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(); // Initialize controller
    _loadProducts();
    _loadCategories();
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose controller
    super.dispose();
  }

  void _loadProducts() {
    context.read<ProductBloc>().add(LoadAllProducts());
  }

  void _loadCategories() {
    context.read<CategoryBloc>().add(LoadAllCategories());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const HomeAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadProducts();
          _loadCategories();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarWidget(
                controller: _searchController,
                isClickable: false, // Important change
                isSearching: _searchController.text.isNotEmpty, // Reflects if there's text
                onChanged: (query) {
                  context.read<ProductBloc>().add(SearchProducts(query));
                  // We need to call setState to rebuild the SearchBarWidget 
                  // itself to show/hide the clear button based on text input
                  setState(() {}); 
                },
                onClear: () {
                  _searchController.clear();
                  context.read<ProductBloc>().add(const SearchProducts(""));
                  setState(() {}); // To update the clear button visibility
                },
                // onFilterTap: () { /* TODO: Implement filter action if needed */ },
                // onSubmit: () { /* Handle submission if needed, e.g., keyboard done */ }
              ),
              const SizedBox(height: 8),
              CategoriesSection(),
              const PromoBanner(),
              const SpecialOffersSection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
