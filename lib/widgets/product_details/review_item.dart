import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  final int rating;
  final String author;
  final String date;
  final String comment;
  final List<String>? imageUrls;

  const ReviewItem({
    super.key,
    required this.rating,
    required this.author,
    required this.date,
    required this.comment,
    this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ligne avec étoiles et nom d'utilisateur
          Row(
            children: [
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Nom d'utilisateur
              Text(
                author,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Commentaire
          Text(
            comment,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),

          // Images (si présentes)
          if (imageUrls != null && imageUrls!.isNotEmpty)
            Container(
              height: 70,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageUrls!.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 70,
                    height: 70,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(imageUrls![index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

          // Date
          Row(
            children: [
              Text(
                '$author,',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
