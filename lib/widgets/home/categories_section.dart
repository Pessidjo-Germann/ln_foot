import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/category/category_bloc.dart';
import 'package:ln_foot/widgets/home/categories/category_item.dart';
import 'package:lnFoot_api/api.dart';

class CategoriesSection extends StatelessWidget {
  CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoriesLoaded) {
          final categories = state.categories;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Header: Title and View All button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: Implement View All categories action
                          print('View All Categories pressed');
                        },
                        // Style the button to look like plain text
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        //  minimumSize:  Size(50, 30), 
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          alignment: Alignment.centerRight,
                          foregroundColor: Colors.grey,
                        ),
                        child: const Text(
                          'View All', // Or 'Voir tous' based on locale
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Horizontal List of Categories
                SizedBox(
                  height:
                      80, // Adjust height based on icon/text size and padding
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 20), // Spacing between items
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return CategoryItem(
                        icon:
                            'images/maillot_asset.svg', // À adapter si tu as une icône dans CategoryDto
                        label: category.name ?? 'Catégorie',
                        onTap: () {
                          print('Category ${category.name} tapped');
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is CategoryError) {
          return Center(child: Text('Erreur: ${state.message}'));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
