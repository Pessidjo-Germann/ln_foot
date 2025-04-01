import 'package:flutter/material.dart';
// You might need a package for star ratings, e.g., flutter_rating_bar
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewBottomSheet extends StatefulWidget {
  // Pass the order details if needed (e.g., product name/image)
  final Map<String, dynamic> order;

  const ReviewBottomSheet({super.key, required this.order});

  @override
  State<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends State<ReviewBottomSheet> {
  double _rating = 0; // Initial rating
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      // Padding to adjust for keyboard and provide spacing
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16, // Adjust for keyboard + bottom padding
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView( // Ensure content is scrollable when keyboard appears
        child: Column(
          mainAxisSize: MainAxisSize.min, // Take minimum space needed
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Laisser un avis',
                  style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  tooltip: 'Fermer', // Accessibility
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Subtitle Text
            Text(
              'Comment s\'est passée votre commande pour "${widget.order['name']}" ?', // Include product name
              style: textTheme.bodyMedium,
            ),
             Text(
              'Merci de donner votre note et également votre avis.',
              style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),

            // Star Rating - Replace with an actual rating widget package
            Center(
              child:
              // Placeholder - Use a real rating bar package here
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: List.generate(5, (index) {
                   return IconButton(
                     icon: Icon(
                       index < _rating ? Icons.star : Icons.star_border,
                       color: Colors.amber,
                       size: 35,
                     ),
                     onPressed: () {
                       setState(() {
                         _rating = index + 1.0;
                       });
                     },
                   );
                 }),
              )
              /* Example using flutter_rating_bar:
              RatingBar.builder(
                 initialRating: _rating,
                 minRating: 1,
                 direction: Axis.horizontal,
                 allowHalfRating: false, // Or true if you want half stars
                 itemCount: 5,
                 itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                 itemBuilder: (context, _) => const Icon(
                   Icons.star,
                   color: Colors.amber,
                 ),
                 onRatingUpdate: (rating) {
                   setState(() {
                     _rating = rating;
                   });
                 },
              ),
              */
            ),
            const SizedBox(height: 20),

            // Review Text Field
            TextField(
              controller: _reviewController,
              decoration: InputDecoration(
                hintText: 'Écrivez votre avis...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colorScheme.primary),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),

            // Add Photo Button
            Center( // Center the button
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement image picking logic
                  print('Add photo action');
                },
                icon: const Icon(Icons.add_photo_alternate_outlined, size: 20),
                label: const Text('Ajouter une photo'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.grey[700],
                  side: BorderSide(color: Colors.grey[400]!),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_rating > 0 && _reviewController.text.isNotEmpty) ? () {
                  // TODO: Implement review submission logic
                  print('Submitting review: Rating $_rating, Review: ${_reviewController.text}');
                  // Potentially update the order state locally or refetch data
                  Navigator.pop(context); // Close bottom sheet on success
                } : null, // Disable button if rating or text is missing
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary, // Use theme primary color
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
                ),
                child: const Text('Soumettre'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
