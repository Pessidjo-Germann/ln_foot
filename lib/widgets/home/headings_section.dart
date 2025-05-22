import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/heading/heading_bloc.dart';
import 'package:lnFoot_api/api.dart'; // For HeadingDto
import 'package:shimmer/shimmer.dart'; // For loading shimmer

class HeadingsSection extends StatelessWidget {
  const HeadingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeadingBloc, HeadingState>(
      builder: (context, state) {
        if (state is HeadingLoading) {
          return _buildLoadingIndicator();
        } else if (state is HeadingsLoaded) {
          if (state.headings.isEmpty) {
            return const SizedBox.shrink(); // Or a message like 'No headings available'
          }
          return _buildHeadingsList(context, state.headings);
        } else if (state is HeadingError) {
          // Optionally display the error, or just hide the section
          // return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
          return const SizedBox.shrink(); // For now, hide on error
        }
        // HeadingInitial or other states
        return _buildLoadingIndicator(); // Show loading by default
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      height: 120, // Adjust height as needed
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3, // Number of shimmer placeholders
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 70,
                    height: 10,
                    color: Colors.white,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeadingsList(BuildContext context, List<HeadingDto> headings) {
    return Container(
      height: 130, // Adjust height based on content
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Tendances', // Or a dynamic title if available, or simply "Headings"
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: headings.length,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemBuilder: (context, index) {
                final heading = headings[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    width: 90, // Width of each heading item
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (heading.imageUrl != null && heading.imageUrl!.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              heading.imageUrl!,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Icon(Icons.image_not_supported, color: Colors.grey.shade400, size: 30),
                              ),
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        else
                          Container( // Placeholder if no image
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Icon(Icons.category, color: Colors.grey.shade400, size: 30),
                          ),
                        const SizedBox(height: 6),
                        if (heading.title != null)
                          Text(
                            heading.title!,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
