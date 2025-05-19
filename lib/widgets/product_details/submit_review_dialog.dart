import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/review/review_bloc.dart';
import 'package:lnFoot_api/api.dart';

class SubmitReviewDialog extends StatefulWidget {
  final String productId;

  const SubmitReviewDialog({Key? key, required this.productId})
      : super(key: key);

  @override
  _SubmitReviewDialogState createState() => _SubmitReviewDialogState();
}

class _SubmitReviewDialogState extends State<SubmitReviewDialog> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  int _rating = 5;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Submit Review'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<int>(
              value: _rating,
              items: List.generate(5, (index) => index + 1)
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text('$value Stars'),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _rating = value ?? 5;
                });
              },
              decoration: const InputDecoration(labelText: 'Rating'),
            ),
            TextFormField(
              controller: _commentController,
              decoration: const InputDecoration(labelText: 'Comment'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a comment';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final reviewData = ReviewDto(
                productId: widget.productId,
                rating: _rating,
                comment: _commentController.text,
              );
              context.read<ReviewBloc>().add(CreateReview(
                    userId: 'exampleUserId', // Replace with actual user ID
                    reviewData: reviewData,
                  ));
              Navigator.of(context).pop();
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
