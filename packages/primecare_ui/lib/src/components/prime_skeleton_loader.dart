import 'package:flutter/material.dart';

class PrimeSkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const PrimeSkeletonLoader({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = 8.0,
  }) : super(key: key);

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
