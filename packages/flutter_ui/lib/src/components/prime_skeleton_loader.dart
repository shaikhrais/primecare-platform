import 'package:flutter/material.dart';

class PrimeSkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const PrimeSkeletonLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
