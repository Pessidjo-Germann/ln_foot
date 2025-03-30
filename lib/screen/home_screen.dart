import 'package:flutter/material.dart';
import 'package:ln_foot/widgets/home/home_app_bar.dart'; 
import 'package:ln_foot/widgets/home/search_bar_widget.dart';  
import 'package:ln_foot/widgets/home/categories_section.dart'; // Import the Categories Section
import 'package:ln_foot/widgets/home/promo_banner.dart'; // Import the Promo Banner
import 'package:ln_foot/widgets/home/special_offers_section.dart'; // Import the Special Offers Section
import 'package:ln_foot/theme/app_theme.dart';

import 'search_screen.dart';  

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Track the selected navigation item

  // Handle navigation item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Here you would typically navigate to different screens
    // For now, we're just updating the selected index
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),  
      body: SingleChildScrollView(
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(
              isClickable: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
            ),
            const SizedBox(height: 8),  

            // Categories Section
            CategoriesSection(), // Use the Categories Section widget
            // const SizedBox(height: 16), // Spacing is handled within CategoriesSection or below

             const PromoBanner(), // Use the Promo Banner widget
            // const SizedBox(height: 24), // Spacing handled by PromoBanner padding or below

            const SpecialOffersSection(),

            const SizedBox(
                height: 24), // Add some final padding at the bottom if needed
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensures all labels are visible
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: kAppOrangeColor, // Use the orange color from theme
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
