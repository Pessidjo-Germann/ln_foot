import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/auth/auth_bloc.dart';
import 'package:ln_foot/bloc/category/category_bloc.dart';
import 'package:ln_foot/bloc/product/product_bloc.dart';
import 'package:ln_foot/bloc/heading/heading_bloc.dart'; // Import HeadingBloc
import 'package:ln_foot/blocs/network_bloc/network_bloc.dart';
import 'package:ln_foot/pages/offline_page.dart';
import 'package:ln_foot/screen/cart_screen.dart';
import 'package:ln_foot/screen/login_options_screen.dart';
import 'package:ln_foot/screen/profile_screen.dart';
import 'package:ln_foot/widgets/home/home_app_bar.dart';
import 'package:ln_foot/widgets/home/search_bar_widget.dart';
import 'package:ln_foot/widgets/home/categories_section.dart'; // Import the Categories Section
import 'package:ln_foot/widgets/home/headings_section.dart'; // Add this import
// import 'package:ln_foot/widgets/home/promo_banner.dart'; // Import the Promo Banner - REMOVED
import 'package:ln_foot/widgets/home/special_offers_section.dart'; // Import the Special Offers Section
import 'package:ln_foot/theme/app_theme.dart';

import 'saved_items_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    // Calculer la distance avant de changer _selectedIndex
    final int distance = (index - _selectedIndex).abs();
    final duration = Duration(milliseconds: 200 + (distance * 100));
    
    setState(() {
      _selectedIndex = index;
    });
    
    // Animer vers la page sélectionnée avec une durée adaptée à la distance
    _pageController.animateToPage(
      index,
      duration: duration,
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
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
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const BouncingScrollPhysics(), // Animation plus naturelle
        children: screens,
      ),
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
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  @override
  bool get wantKeepAlive => true;
  late TextEditingController _searchController;
  
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(); // Initialize controller
    WidgetsBinding.instance.addObserver(this);
    _loadInitialData();
  }
  
  void _loadInitialData() {
    _loadProducts(); // Defaults to forceRefresh: false
    _loadCategories(); // Defaults to forceRefresh: false
    _loadHeadings(); // Call _loadHeadings
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Rafraîchir les données quand l'app revient en premier plan
      _refreshData();
    }
  }
  
  void _refreshData() {
    _loadProducts(forceRefresh: true);
    _loadCategories(forceRefresh: true);
    _loadHeadings(forceRefresh: true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _searchController.dispose(); // Dispose controller
    super.dispose();
  }

  void _loadProducts({bool forceRefresh = false}) {
    context.read<ProductBloc>().add(LoadAllProducts(forceRefresh: forceRefresh));
  }

  void _loadCategories({bool forceRefresh = false}) {
    context.read<CategoryBloc>().add(LoadAllCategories(forceRefresh: forceRefresh));
  }

  void _loadHeadings({bool forceRefresh = false}) {
    // Define _loadHeadings
    context.read<HeadingBloc>().add(LoadHeadings(forceRefresh: forceRefresh));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, networkState) {
        if (networkState is NetworkOffline) {
          return const OfflinePage();
        }

        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState is Unauthenticated) {
              return  LoginOptionsScreen();
            }

            return Scaffold(
              appBar: const HomeAppBar(),
              body: RefreshIndicator(
                onRefresh: () async {
                  _refreshData();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchBarWidget(
                        controller: _searchController,
                        isClickable: false,
                        isSearching: _searchController.text.isNotEmpty,
                        onChanged: (query) {
                          context
                              .read<ProductBloc>()
                              .add(SearchProducts(query));
                          setState(() {});
                        },
                        onClear: () {
                          _searchController.clear();
                          context
                              .read<ProductBloc>()
                              .add(const SearchProducts(""));
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 8),
                      CategoriesSection(),
                      const SizedBox(height: 16),
                      const HeadingsSection(),
                      const SizedBox(height: 16),
                      const SpecialOffersSection(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
