import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/category/category_bloc.dart';
import 'package:ln_foot/bloc/product/product_bloc.dart'; // Import ProductBloc
import 'package:ln_foot/widgets/home/categories/category_item.dart';
import 'package:ln_foot/widgets/home/categories/category_shimmer.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, categoryState) {
        if (categoryState is CategoryLoading) {
          return const CategoryShimmerList();
        } else if (categoryState is CategoriesLoaded) {
          final categories = categoryState.categories;
          return BlocBuilder<ProductBloc, ProductState>(
            builder: (context, productState) {
              String? currentSelectedCategoryName;
              if (productState is ProductsLoaded) {
                currentSelectedCategoryName = productState.selectedCategoryName;
              }
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
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<ProductBloc>()
                                  .add(ClearProductFilter());
                              print(
                                  'View All Categories pressed - dispatching ClearProductFilter');
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerRight,
                              foregroundColor: Colors.grey,
                            ),
                            child: const Text(
                              'View All',
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
                      height: 80,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 20),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final bool isItemSelected = category.name != null &&
                              category.name == currentSelectedCategoryName;
                          return CategoryItem(
                            icon: 'images/maillot_asset.svg',
                            label: category.name ?? 'Catégorie',
                            onTap: () {
                              if (category.name != null) {
                                context.read<ProductBloc>().add(
                                    FilterProductsByCategory(category.name!));
                                print(
                                    'Category ${category.name} tapped - dispatching FilterProductsByCategory');
                              } else {
                                print(
                                    'Category name is null, cannot filter.');
                              }
                            },
                            isSelected: isItemSelected,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (categoryState is CategoryError) {
          return Center(child: Text('Erreur: ${categoryState.message}'));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
