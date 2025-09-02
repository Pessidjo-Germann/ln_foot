
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingBottomSheet extends StatelessWidget {
  const LoadingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 80,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }
}
