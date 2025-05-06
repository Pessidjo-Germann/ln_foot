import 'package:flutter/material.dart';
import 'order_item_widget.dart'; // Import the item widget
// Import the review bottom sheet widget when created
// import 'review_bottom_sheet.dart';

class OrderList extends StatelessWidget {
  final List<Map<String, dynamic>> orders;
  // Callback to show the review sheet from the screen
  final Function(BuildContext, Map<String, dynamic>) showReviewSheetCallback;

  const OrderList({
    super.key,
    required this.orders,
    required this.showReviewSheetCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0), // Add padding around the list
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final bool isReviewTab = order['status'] == 'review';
        final bool reviewed = order['reviewed'] ?? false;

        return Column(
          children: [
            OrderItemWidget(
              order: order,
              onReviewPressed: isReviewTab
                  ? () {
                      if (!reviewed) {
                        // Call the function passed from the screen to show the sheet
                        showReviewSheetCallback(context, order);
                      } else {
                        // Handle viewing the existing review (optional)
                        print("View review action for ${order['name']}");
                        // Maybe show a dialog or navigate to a review details screen
                      }
                    }
                  : null, // No action needed for ongoing/completed from here
            ),
              const Divider(
                height: 1,
                thickness: 0.4 ,
                indent: 16,
                endIndent: 16,
                color: Color(0xFFEEEEEE),
              ),
          ],
        );
      },
    );
  }
}
