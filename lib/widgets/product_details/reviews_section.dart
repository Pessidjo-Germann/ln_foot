import 'package:flutter/material.dart';

import 'review_item.dart';

class ReviewsSection extends StatefulWidget {
  const ReviewsSection({super.key});

  @override
  _ReviewsSectionState createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text(
          'Évaluation et avis', // Consider localization
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87, // Use theme color
          ),
        ),
        trailing: Icon(
          _isExpanded ? Icons.expand_less : Icons.expand_more,
          color: Colors.black54, // Use theme color
        ),
        onExpansionChanged: (bool expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: 4, thickness: 1),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Text('4.8/5', style: TextStyle(fontSize: 18)),
                  SizedBox(width: 5),
                  Column(
                    children: [
                      Text('Note globale'),
                      Text('(12 evalutions)',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ]),
                Divider(height: 4, thickness: 1),
                SizedBox(height: 16),
                ReviewItem(
                  rating: 5,
                  author: 'Client satisfait',
                  date: '20 Mars 2025',
                  comment: 'Excellent produit, très confortable !',
                ),
                Divider(height: 24, thickness: 1),
                ReviewItem(
                  rating: 4,
                  author: 'Utilisateur Lambda',
                  date: '15 Mars 2025',
                  comment: 'Bonne qualité, taille un peu juste.',
                ),
                SizedBox(height: 16),

                // TextButton(onPressed: () {}, child: Text('Voir tous les avis')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
