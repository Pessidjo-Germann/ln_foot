import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ln_foot/bloc/review/review_bloc.dart';

import 'review_item.dart';
import 'submit_review_dialog.dart';

class ReviewsSection extends StatefulWidget {
  final String productId;

  const ReviewsSection({super.key, required this.productId});

  @override
  _ReviewsSectionState createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ReviewsLoaded) {
          final reviews = state.reviews;
          return Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(
                'Évaluation et avis',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              trailing: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.black54,
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
                      Divider(height: 4, thickness: 0.4),
                      ...reviews.map((review) => Column(
                            children: [
                              ReviewItem(
                                rating: review.rating,
                                author: 'Anonymous', // Placeholder for author
                                date: 'N/A', // Placeholder for date
                                comment: review.comment,
                              ),
                              Divider(height: 24, thickness: 0.4),
                            ],
                          )),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          SubmitReviewDialog(productId: widget.productId),
                    );
                  },
                  child: const Text('Ajouter un avis'),
                ),
              ],
            ),
          );
        } else if (state is ReviewError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(
              child: Text('Pas d\'avis valable pour le moment .'));
        }
      },
    );
  }
}
