// bottom sheet review all.dart:

import 'package:flutter/material.dart';
import 'package:ln_foot/widgets/product_details/review_item.dart';

void showReviewsAll(
    BuildContext context, Widget Function(ScrollController) widgetBuilder) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      // Consistent rounded corners
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.4,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          builder: (context, scrollController) {
            return widgetBuilder(scrollController);
          });
    },
  );
}

class ReviewListWidget extends StatelessWidget {
  final List<ReviewItem> list;
  final ScrollController scrollController;
  const ReviewListWidget(
      {super.key, required this.list, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(height: 4),
          Text("Rating & Reviews",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 2),
          Divider(thickness: 0.4),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return list[index];
              },
            ),
          ),
        ]));
  }
}
