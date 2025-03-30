// bottom sheet review all.dart:

import 'package:flutter/material.dart';
import 'package:ln_foot/widgets/product_details/review_item.dart';

void showReviewsAll(BuildContext context, List<ReviewItem> list) {
  showModalBottomSheet(
    context: context,
    isScrollControlled:
        true, // Allows the sheet to take up more screen height if needed
    shape: const RoundedRectangleBorder(
      // Consistent rounded corners
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.8, // Initial height of the sheet
          maxChildSize: 0.9, // Maximum height of the sheet
          minChildSize: 0.8,
          builder: (context, scrollController) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text("Rating & Reviews",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 2),
                      Divider(),
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
          });
    },
  );
}
