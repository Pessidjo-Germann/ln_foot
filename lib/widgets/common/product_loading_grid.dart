import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductLoadingGrid extends StatelessWidget {
  final int itemCount;
  final double childAspectRatio;
  final EdgeInsetsGeometry padding;

  const ProductLoadingGrid({
    super.key,
    this.itemCount = 6,
    this.childAspectRatio = 0.58,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: GridView.builder(
          itemCount: itemCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            return Card(
              elevation: 1.5,
              shadowColor: Colors.grey.withOpacity(0.15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 60, height: 12.0, color: Colors.white),
                        const SizedBox(height: 4),
                        Container(
                            width: double.infinity,
                            height: 16.0,
                            color: Colors.white),
                        const SizedBox(height: 4),
                        Container(
                            width: double.infinity * 0.7,
                            height: 16.0,
                            color: Colors.white),
                        const SizedBox(height: 8),
                        Container(width: 80, height: 14.0, color: Colors.white),
                        const SizedBox(height: 10),
                        Container(
                            width: 100, height: 12.0, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
