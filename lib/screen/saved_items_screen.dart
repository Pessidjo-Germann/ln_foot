import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Bloc
import 'package:ln_foot/bloc/saved_items/saved_items_bloc.dart'; // Import Bloc
import 'package:ln_foot/screen/product_details_screen.dart';
import 'package:ln_foot/widgets/saved_items/shimmer_product_card.dart';
// import '../model/product.dart'; // Remplacé par ProductDto
import '../widgets/common/product_card.dart'; // Reusable product card
import '../widgets/custom_app_bar.dart'; // Reusable app bar
import '../widgets/saved_items/empty_saved_items_view.dart'; // Empty state view

class SavedItemsScreen extends StatefulWidget {
  const SavedItemsScreen({super.key});

  @override
  State<SavedItemsScreen> createState() => _SavedItemsScreenState();
}

class _SavedItemsScreenState extends State<SavedItemsScreen> {
  // bool _isLoading = true; // Supprimé

  @override
  void initState() {
    super.initState();
    // Déclencher l'événement pour charger les éléments sauvegardés
    context.read<SavedItemsBloc>().add(LoadSavedItems());
    /* // Simulate loading delay - Supprimé
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    */
  }

  // TODO: Replace placeholder data with actual saved items logic
  /* // Données statiques supprimées
  final List<Product> _savedItems = [
    // ... données supprimées ...
  ];
  */

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final bool isEmpty = _savedItems.isEmpty; // Supprimé

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Éléments enregistrés',
        showBackButton: true,
        actions: [
          // Notification icon as seen in the design
          IconButton(
            icon: const Icon(Icons
                .notifications_none_outlined), // Or use your custom icon if available
            onPressed: () {
              // TODO: Navigate to notifications screen
              print('Notification icon pressed');
            },
          ),
        ],
      ),
      body: BlocBuilder<SavedItemsBloc, SavedItemsState>(
        builder: (context, state) {
          if (state is SavedItemsLoading) {
            // Afficher le shimmer pendant le chargement
            // Utiliser GridView.builder pour le shimmer pour correspondre à la mise en page
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two items per row
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.6, // Adjust aspect ratio as needed
              ),
              itemCount: 6, // Nombre de placeholders shimmer
              itemBuilder: (context, index) => const ShimmerProductCard(),
            );
          } else if (state is SavedItemsLoaded) {
            final items = state.items;
            final bool isEmpty = items.isEmpty;

            if (isEmpty) {
              return const EmptySavedItemsView();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      '${items.length} Items',
                      style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two items per row
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio:
                            0.6, // Adjust aspect ratio as needed for ProductCard layout
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ProductCard(
                          product: item,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                product: item,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          } else if (state is SavedItemsError) {
            return Center(
              child: Text('Erreur: ${state.message}'),
            );
          } else {
            // État initial ou inconnu
            return const Center(child: Text('Aucun élément sauvegardé.'));
          }
        },
      ),
    );
  }
}
