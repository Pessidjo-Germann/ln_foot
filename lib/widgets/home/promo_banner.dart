import 'package:flutter/material.dart';
import 'package:ln_foot/theme/app_theme.dart';

class PromoBanner extends StatefulWidget {
   const PromoBanner({super.key});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  int _currentPage = 0;
  final int _totalPages = 3;
  final PageController _pageController = PageController();

  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bannerHeight = 140.0;
    

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
      child: Column(
        children: [
          Container(
            height: bannerHeight,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _totalPages,
              // Use onPageChanged callback
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                 return AnimatedContainer(
                  duration:
                      const Duration(milliseconds: 500), // Animation duration
                  curve: Curves.easeInOut, // Animation curve

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'images/first section.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.image_not_supported,
                          color: Colors.white54),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          // Pagination Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_totalPages, (index) {
               return AnimatedContainer(
                duration: const Duration(
                    milliseconds: 300), 
                curve: Curves.easeOut, 
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle, 
                  color: _currentPage == index
                      ? kPrimaryColor  
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
