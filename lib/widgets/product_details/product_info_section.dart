import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/review/review_bloc.dart';
import 'package:ln_foot/utils/bottom_sheet_review_all.dart';
import 'package:ln_foot/widgets/product_details/review_item.dart';

class ProductInfoSection extends StatelessWidget {
  final String name;
  final double price;
  final double rating;
  final int reviewCount;
  final String productId;

  const ProductInfoSection({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'fr_FR',
      symbol: 'FCFA',
      decimalDigits: 0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              currencyFormatter.format(price),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.star, color: Colors.amber, size: 18),
                ),
                const SizedBox(width: 3),
                Text(
                  '$rating',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 1),
                BlocBuilder<ReviewBloc, ReviewState>(
                  builder: (context, state) {
                    return TextButton(
                      onPressed: () {
                        context.read<ReviewBloc>().add(LoadAllReviews());
                        showReviewsAll(
                          context,
                          (scrollController) =>
                              BlocBuilder<ReviewBloc, ReviewState>(
                            builder: (context, state) {
                              if (state is ReviewsLoaded) {
                                final productReviews = state.reviews
                                    .where((review) =>
                                        review.productId == productId)
                                    .toList();

                                return ReviewListWidget(
                                  list: productReviews
                                      .map((review) => ReviewItem(
                                            rating: review.rating,
                                            author: 'Anonymous',
                                            date: 'N/A',
                                            comment: review.comment,
                                          ))
                                      .toList(),
                                  scrollController: scrollController,
                                );
                              }
                              if (state is ReviewLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return const Center(
                                child: Text('Pas d\'avis disponible'),
                              );
                            },
                          ),
                        );
                      },
                      child: Text(
                        '($reviewCount Review)',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
