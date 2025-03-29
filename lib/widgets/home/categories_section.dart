import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoriesSection extends StatelessWidget {
  CategoriesSection({super.key});

  // Nouvelle structure utilisant List<Map<String, dynamic>>
  final List<Map<String, dynamic>> categories = [
    {
      'icon': 'images/maillot_asset.svg',
      'name': 'Maillot',
    },
    {
      'icon': 'images/shoes.svg',
      'name': 'chaussure',
    },
    {
      'icon': 'images/sports_soccer.svg',
      'name': 'Ballon',
    },
    {
      'icon': 'images/Gym.svg',
      'name': 'Fitness',
    },
    {
      'icon': 'images/stationery_asset.svg',
      'name': 'Stationery',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                    minimumSize: const Size(50, 30), // Adjust size as needed
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerRight,
                    foregroundColor:
                        Colors.grey, // Use your theme's accent color
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
            height: 80, // Adjust height based on icon/text size and padding
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              separatorBuilder: (context, index) =>
                  const SizedBox(width: 20), // Spacing between items
              itemBuilder: (context, index) {
                final category = categories[index];
                return _CategoryItem(
                  icon: category['icon'],
                  label: category['name'],
                  onTap: () {
                    print('Category ${category['name']} tapped');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget for individual category items
class _CategoryItem extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              icon,
              height: 24,
              width: 24,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
