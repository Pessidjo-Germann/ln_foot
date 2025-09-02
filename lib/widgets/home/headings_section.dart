import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/heading/heading_bloc.dart';
import 'package:ln_foot/theme/app_theme.dart'; // For kPrimaryColor
import 'package:lnFoot_api/api.dart'; // For HeadingDto
import 'package:shimmer/shimmer.dart'; // For loading shimmer

class HeadingsSection extends StatefulWidget {
  const HeadingsSection({super.key});

  @override
  State<HeadingsSection> createState() => _HeadingsSectionState();
}

class _HeadingsSectionState extends State<HeadingsSection> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeadingBloc, HeadingState>(
      builder: (context, state) {
        if (state is HeadingLoading) {
          return _buildLoadingIndicator();
        } else if (state is HeadingsLoaded) {
          if (state.headings.isEmpty) {
            return const SizedBox.shrink();
          }
          return _buildHeadingsCarousel(context, state.headings);
        } else if (state is HeadingError) {
          return const SizedBox.shrink(); // Hide on error
        }
        return _buildLoadingIndicator(); // Default to loading
      },
    );
  }

  Widget _buildLoadingIndicator() {
    final bannerHeight = 140.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
      child: Column(
        children: [
          SizedBox(
            height: bannerHeight,
            width: double.infinity,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) { // Placeholder dots
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadingsCarousel(BuildContext context, List<HeadingDto> headings) {
    final bannerHeight = 140.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
      child: Column(
        children: [
          SizedBox(
            height: bannerHeight,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: headings.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                final heading = headings[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15), // Added right padding for consistency
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          if (heading.imageUrl != null && heading.imageUrl!.isNotEmpty)
                            Image.network(
                              heading.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Colors.grey.shade200,
                                child: Icon(Icons.image_not_supported, color: Colors.grey.shade400, size: 50),
                              ),
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  color: Colors.grey.shade200,
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
                            )
                          else
                            Container(
                              color: Colors.grey.shade200,
                              child: Icon(Icons.category, color: Colors.grey.shade400, size: 50),
                            ),
                          if (heading.title != null) // Display title over the image
                            Positioned(
                              bottom: 10,
                              left: 10,
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  heading.title!,
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          if (headings.length > 1) // Show dots only if more than one heading
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(headings.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? kPrimaryColor // Use theme color
                        : Colors.grey.shade400,
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }
}
